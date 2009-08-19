#
# Program.pm
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

package Sitetool::Base::Program;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&version
                 &hint
                 &program_name_set);
}

sub program_name_set ($)
{
}

sub version ()
{
    assert(defined($::PROGRAM_NAME));
    assert($::PROGRAM_NAME ne "");

    print $::PROGRAM_NAME . " (" . $Sitetool::Autoconfig::PACKAGE_NAME . ") " . $Sitetool::Autoconfig::PACKAGE_VERSION . "\n";
    print "\n";
    print "Copyright (C) 2008, 2009 Francesco Salvestrini\n";
    print "\n";
    print "This is free software.  You may redistribute copies of it under the terms of\n";
    print "the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.\n";
    print "There is NO WARRANTY, to the extent permitted by law.\n";
}

sub hint ($)
{
    my $string = shift;

    if (defined($string)) {
        assert($string ne "");

        print $::PROGRAM_NAME . ": " . $string . "\n";
    }
    print "Try \`" . $::PROGRAM_NAME . " -h' for more information.\n";
}

1;
