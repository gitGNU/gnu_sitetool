#
# Terminal.pm
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

package Sitetool::Misc::Terminal;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;
use Sitetool::OS::Environment;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&terminal_width
		 &terminal_height);
}

sub terminal_width ()
{
    my $width;
    my $value;

    $value = environment_get("COLUMNS");
    $width = 80;

    if (!defined($value)) {
        return $width;
    }
    if (!string_isnumber($value)) {
        return $width;
    }

    return string_tonumber($value);
}

sub terminal_height ()
{
    my $height;
    my $value;

    $value  = environment_get("LINES");
    $height = 25;

    if (!defined($value)) {
        return $height;
    }
    if (!string_isnumber($value)) {
        return $height;
    }

    return string_tonumber($value);
}

1;
