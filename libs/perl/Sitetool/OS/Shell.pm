#
# Shell.pm
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

package Sitetool::OS::Shell;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);
    
    @ISA    = qw(Exporter);
    @EXPORT = qw(&shell_execute &shell_execute_and_report);
}

sub shell_execute ($)
{
    my $string = shift;

    assert(defined($string));

    debug("Executing command \`$string'");

    system($string);
    if ($? == -1) {
	error("Failed to execute \`$string'");
	return 0;
    } elsif ($? & 127) {
	error("Child died ?");
	return 0;
    } else {
	my $retval = $? >> 8;

	debug("Shell execution return value is $retval");

	return ($retval ? 0 : 1);
    }

    bug("Unreachable part ...");
}

sub shell_execute_and_report ($)
{
    my $string = shift;

    assert(defined($string));

    my $retval;

    debug("executing command \`$string'");

    system($string);
    if ($? == -1) {
	error("Failed to execute \`$string'");
	$retval = $?;
    } elsif ($? & 127) {
	error("Child died ?");
	$retval = $? & 127;
    } else {
	$retval = $? >> 8;

	debug("Shell execution return value is $retval");
    }

    return $retval;
}

1;
