#
# File.pm
#
# Copyright (C) 2007, 2008 Francesco Salvestrini
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

package Sitetool::OS::File;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use File::Basename;
use File::Copy;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);
    
    @ISA    = qw(Exporter);
    @EXPORT = qw(&file_remove
		 &file_touch
		 &file_link
		 &file_cat
		 &file_copy
		 &file_move
		 &file_mtime
		 &file_tostring
		 &file_ispresent
		 &file_isexecutable
		 &file_isobsolete);
}

sub file_isobsolete ($$)
{
    my $input_filename  = shift;
    my $output_filename = shift;

    assert(defined($input_filename));
    assert(defined($output_filename));
    assert(file_ispresent($input_filename));
    
    if (!file_ispresent($output_filename)) {
	return 1;
    }
    
    if (file_mtime($input_filename) > file_mtime($output_filename)) {
	return 1;
    }

    return 0;
}

sub file_ispresent ($)
{
    my $name = shift;

    assert(defined($name));

    return ((-e $name) ? 1 : 0);
}

sub file_isexecutable ($)
{
    my $name = shift;

    assert(defined($name));

    return ((-X $name) ? 1 : 0);
}

sub file_tostring ($$)
{
    my $filename   = shift;
    my $string_ref = shift;

    assert(defined($filename));
    assert(defined($string_ref));

    ${$string_ref} = undef;

    if (! -f $filename) {
	error("Cannot open file "       .
	      "\`" . $filename . "' "   .
	      "for input, it is missing");
	return 0;
    }

    my $filehandle;

    if (!open($filehandle, "<", $filename)) {
	error("Cannot open \`$filename' for input");
	return 0;
    }
    
    my $string;

    $string = "";
    while (<$filehandle>) {
	$string = $string . $_;
    }
    
    close($filehandle);

    ${$string_ref} = $string;

    return 1;
}

sub file_mtime ($)
{
    my $filename = shift;

    assert(defined($filename));
    assert($filename ne "");

    if (!file_ispresent($filename)) {
	bug("file_mtime() called over not existent file \`" . $filename . "'");
    }

    my ($dev,   $ino,   $mode,  $nlink,
	$uid,   $gid,   $rdev,  $size,
	$atime, $mtime, $ctime, $blksize,
	$blocks) = stat($filename);
    
    return $mtime;
}

sub file_remove ($)
{
    my $filename = shift;

    assert(defined($filename));
    assert($filename ne "");

    debug("Removing file \`" . $filename . "'");
    if (!file_ispresent($filename)) {
	return 1;
    } elsif (-f $filename) {
	if (unlink($filename) != 1) {
	    error("Cannot remove file \`" . $filename . "'");
	}

	return 1;
    }

    bug("Unreachable part ...");
}

sub file_touch ($)
{
    my $filename = shift;

    assert(defined($filename));
    assert($filename ne "");

    debug("Touching file \`" . $filename . "'");

    my $filehandle;

    if (!open($filehandle, ">", $filename)) {
	error("Cannot touch file \`" . $filename . "'");
	return 0;
    }

    print $filehandle "";
    close($filehandle);

    return 1;
}

sub file_copy ($$)
{
    my $source      = shift;
    my $destination = shift;

    assert(defined($source));
    assert($source ne "");
    assert(defined($destination));
    assert($destination ne "");

    if (!file_ispresent($source)) {
	error("File \`" . $source . "' does not exists");
	return 0;
    }
    if (file_ispresent($destination)) {
	warning("Overwriting file \`" . $destination . "'");
    }

    debug("Copying \`" . $source . "' to \`" . $destination . "'");
    if (!copy($source, $destination)) {
	error("Cannot copy \`" . $source . "' to \`" . $destination . "'");
	return 0;
    }
    
    return 1;
}

sub file_move ($$)
{
    my $source      = shift;
    my $destination = shift;

    assert(defined($source));
    assert($source ne "");
    assert(defined($destination));
    assert($destination ne "");

    if (!file_ispresent($source)) {
	error("File \`" . $source . "' does not exists");
	return 0;
    }
    if (file_ispresent($destination)) {
	warning("Overwriting file \`" . $destination . "'");
    }

    debug("Moving \`" . $source . "' to \`" . $destination . "'");
    if (!move($source, $destination)) {
	error("Cannot move \`" . $source . "' to \`" . $destination . "'");
	return 0;
    }

    return 1;
}

sub file_link ($$)
{
    my $source      = shift;
    my $destination = shift;

    assert(defined($source));
    assert($source ne "");
    assert(defined($destination));
    assert($destination ne "");

    if (!file_ispresent($source)) {
	error("File \`" . $source . "' does not exists");
	return 0;
    }

    my $symlink_exists;
    $symlink_exists = eval {
	no warnings 'all';
	symlink("", "");
	1
    };
    if ($symlink_exists) {
	debug("sym-linking \`" . $source . "' to \`" . $destination . "'");

	if (!symlink($source, $destination)) {
	    error("Cannot symlink "        .
		  "\`" . $source . "'"     .
		  " to "                   .
		  "\`" . $destination . "'");
	    return 0;
	}
    } else {
	debug("hard-linking \`" . $source . "' to \`" . $destination . "'");

	if (!file_copy($source, $destination)) {
	    return 0;
	}
    }

    return 1;
}

#
# NOTE:
#     Quite different from file_copy, we evaluate vars while copying input ...
#
sub file_cat ($$)
{
    my $source      = shift;
    my $destination = shift;

    assert(defined($source));
    assert($source ne "");
    assert(defined($destination));
    assert($destination ne "");

    if (!file_ispresent($source)) {
	error("File \`" . $source . "' does not exists");
	return 0;
    }

    my $input_filehandle;
    my $output_filehandle;

    if (!open($input_filehandle, "<", $source)) {
	error("Cannot open \`" . $source . "' for input");
	return 0;
    }
    if (!open($output_filehandle, ">>", $destination)) {
	error("Cannot open \`" . $destination . "' for output");
	return 0;
    }

    while(<$input_filehandle>) {
	print $output_filehandle "$_";
    }

    close($input_filehandle);
    close($output_filehandle);

    return 1;
}

1;
