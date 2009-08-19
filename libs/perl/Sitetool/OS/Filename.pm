#
# Filename.pm
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

package Sitetool::OS::Filename;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use File::Temp;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;
use Sitetool::Base::Trace;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&filename_rel2abs
                 &filename_canonicalize
                 &filename_extension
                 &filename_mktemp);
}

sub filename_mktemp ()
{
    my $name;

    $name = mktemp(lc($PACKAGE_NAME) . "." . "XXXXXX");

    assert(defined($name));
    assert($name ne "");

    return $name;
}

sub filename_rel2abs ($)
{
    my $name = shift;

    assert(defined($name));
    assert($name ne "");

    return File::Spec->rel2abs($name);
}

sub filename_canonicalize ($)
{
    my $name = shift;

    $name =~ s/[ \t\s\/:]/_/;

    return $name;
}

sub filename_extension ($)
{
    my $path         = shift;
    my $volume;
    my $directories;
    my $file;
    my $extension;

    assert($path ne "");

    ($volume, $directories, $file) = File::Spec->splitpath($path);

    $extension = $file;
    $extension =~ s/^.*\.//;

    debug("Extension for file \`$path' is \`$extension'");

    return $extension;
}

1;
