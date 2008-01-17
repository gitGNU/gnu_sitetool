#
# Digest.pm
#
# (C) 2007, 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

package Sitetool::Digest;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;
use Sitetool::Base::Trace;
use Sitetool::OS::File;
use Sitetool::OS::Filename;
use Sitetool::OS::Shell;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);
    
    @ISA    = qw(Exporter);
    @EXPORT = qw(&digest_compute_md5
		 &digest_compute_sha1
		 &digest_compute_sha224
		 &digest_compute_sha256
		 &digest_compute_sha384
		 &digest_compute_sha512);
}

sub digest_compute ($$$)
{
    my $filename   = shift;
    my $executable = shift;
    my $string_ref = shift;

    assert(defined($filename));
    assert(defined($executable));
    assert(defined($string_ref));

    if (!file_ispresent($filename)) {
	error("Cannot compute "        .
	      "digest for file "       .
	      "\`" . $filename . "', " .
	      "input file is missing");
	return 0;
    }

    if ($executable eq "") {
	error("Missing executable to compute checksum");
	return 0;
    }

    my $digest_file = filename_mktemp();
    assert(defined($digest_file));

    my $command;

    $command = "$executable $filename > $digest_file";
    if (!shell_execute($command)) {
	error("Cannot compute digest");
	file_remove($digest_file);
	return 0;
    }
    
    my $temp;
    
    $temp = "";
    if (!file_tostring($digest_file, \$temp)) {
	error("Cannot read digest back");
	file_remove($digest_file);
	return 0;
    }

    file_remove($digest_file);

    debug("Temp is \`" . $temp . "'");

    $temp =~ s/\n//g;
    $temp =~ s/[ \t]+.*$//;

    debug("Computed digest is \`" . $temp . "'");

    ${ $string_ref } = $temp;

    return 1;
}

sub digest_compute_md5 ($$)
{
    my $filename   = shift;
    my $string_ref = shift;

    debug("Computing MD5 sum for file \`" . $filename . "'");

    return digest_compute($filename,
			  $Sitetool::Autoconfig::MD5SUM,
			  $string_ref);
}

sub digest_compute_sha1 ($$)
{
    my $filename   = shift;
    my $string_ref = shift;

    debug("Computing SHA-1 sum for file \`" . $filename . "'");

    return digest_compute($filename,
			  $Sitetool::Autoconfig::SHA1SUM,
			  $string_ref);
}

sub digest_compute_sha224 ($$)
{
    my $filename   = shift;
    my $string_ref = shift;

    debug("Computing SHA-224 sum for file \`" . $filename . "'");

    return digest_compute($filename,
			  $Sitetool::Autoconfig::SHA224SUM,
			  $string_ref);
}

sub digest_compute_sha256 ($$)
{
    my $filename   = shift;
    my $string_ref = shift;

    debug("Computing SHA-256 sum for file \`" . $filename . "'");

    return digest_compute($filename,
			  $Sitetool::Autoconfig::SHA256SUM,
			  $string_ref);
}

sub digest_compute_sha384 ($$)
{
    my $filename   = shift;
    my $string_ref = shift;

    debug("Computing SHA-384 sum for file \`" . $filename . "'");

    return digest_compute($filename,
			  $Sitetool::Autoconfig::SHA384SUM,
			  $string_ref);
}

sub digest_compute_sha512 ($$)
{
    my $filename   = shift;
    my $string_ref = shift;

    debug("Computing SHA-512 sum for file \`" . $filename . "'");

    return digest_compute($filename,
			  $Sitetool::Autoconfig::SHA512SUM,
			  $string_ref);
}

1;
