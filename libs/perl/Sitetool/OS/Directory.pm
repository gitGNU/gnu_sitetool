#
# Directory.pm
#
# Copyright (C) 2008, 2009 Francesco Salvestrini
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

package Sitetool::OS::Directory;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use File::Path;
use File::Spec;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&directory_create
		 &directory_remove
		 &directory_items
		 &directory_ispresent
		 &directory_link
		 &directory_copy);
}

sub directory_ispresent ($)
{
    my $name = shift;

    assert(defined($name));

    return ((-d $name) ? 1 : 0);
}

#sub directory_makepath ($)
#{
#    my $filename = shift;
#
#    assert(defined($filename));
#
#    $path = dirname($filename);
#    if (!directory_create($path)) {
#	return 0;
#    }
#
#    return 1;
#}


sub directory_create ($)
{
    my $dirname = shift;

    assert($dirname ne "");

    debug("Creating directory \`$dirname'");

    if (directory_ispresent($dirname)) {
	debug("Directory \`" . $dirname . "' exists already");
	return 1;
    }

    eval {
	no warnings 'all';
	mkpath($dirname, 0, 0777)
    };
    if ($@) {
	debug("Evaluation returned `" . $@ . "'");
	error("Cannot create directory \`" . $dirname . "'");
	return 0;
    }

    return 1;
}

sub directory_remove ($)
{
    my $dirname = shift;

    assert($dirname ne "");

    debug("Removing directory \`$dirname'");

    if (!directory_ispresent($dirname)) {
	debug("Directory \`" . $dirname . "' is not present");
	return 1;
    }

    if (rmtree($dirname, 0, 1) == 0) {
	error("Cannot remove directory \`" . $dirname . "'");
	return 0;
    }

    return 1;
}

sub patterns_match ($$)
{
    my $patterns_ref = shift;
    my $string       = shift;
    my @patterns;

    assert(defined($patterns_ref));

    @patterns = @{ $patterns_ref };
    for my $pattern (@patterns) {
	if ($string =~ $pattern) {
	    debug("String "             .
		  "\`" . $string . "' " .
		  "matches patters "    .
		  "\`" . @patterns . "'");
	    return 1;
	}
    }

    return 0;
}

sub directory_items ($$)
{
    my $directory      = shift;
    my $exclusions_ref = shift;

    assert(defined($directory));
    assert(defined($exclusions_ref));

    debug("Reading items for directory `" . $directory . "'");

    my $directory_handle;
    if (!opendir($directory_handle, "./")) {
	error("Cannot open directory \`" . $directory . "'");
	return 0;
    }

    my @items = [ ];
    my @dirty_items;

    @dirty_items = readdir($directory_handle);
    debug("Dirty items are: `@dirty_items'");
    closedir($directory_handle);

    my @clean_items;

    for my $item (@dirty_items) {
	if (($item =~ /^\.$/) || ($item =~ /^\.\.$/)) {
	    # Skip `.' and `..' items ...
	    next;
	}

	if (patterns_match($exclusions_ref, $item)) {
	    debug("Item \`" . $item . "' should be excluded");
	    next;
	}

	push(@clean_items, $item);
    }
    debug("Clean items are: `@clean_items'");

    @items = @clean_items;

    return @items;
}

sub directory_copy ($$)
{
    my $source      = shift;
    my $destination = shift;

    assert(defined($source));
    assert($source ne "");
    assert(defined($destination));
    assert($destination ne "");

    bug("Not yet implemented");
    return 0;
}

sub directory_link ($$)
{
    my $source      = shift;
    my $destination = shift;

    assert(defined($source));
    assert($source ne "");
    assert(defined($destination));
    assert($destination ne "");

    if (!directory_ispresent($source)) {
	error("Directory \`" . $source . "' does not exists");
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

	if (!directory_copy($source, $destination)) {
	    return 0;
	}
    }

    return 1;
}

1;
