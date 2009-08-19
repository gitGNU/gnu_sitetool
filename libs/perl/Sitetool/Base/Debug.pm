#
# Debug.pm
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

package Sitetool::Base::Debug;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Carp;
#use POSIX qw(&exit EXIT_FAILURE EXIT_SUCCESS);

use Sitetool::Autoconfig;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&bug
                 &assert
                 &missing);
}

sub bug ($)
{
    my $string = shift;

    print STDERR "\n";
    if (defined($string)) {
        print STDERR "Bug hit: " . $string . "\n";
    } else {
        print STDERR "Bug hit\n";
    }
    print STDERR
        "Please report the problem to "                   .
        "<" . $Sitetool::Autoconfig::PACKAGE_BUGREPORT . ">\n";
    print STDERR "\n";

    confess(); # From Carp module

    # We must exit with a different exit code that a generic error (which is 1)
    exit 88;
}

sub assert ($)
{
    my $expression = shift;

    if ($expression == 0) {
        bug("Assertion failed !!!");
    }
}

sub missing ()
{
    bug("Missing code");
}

1;
