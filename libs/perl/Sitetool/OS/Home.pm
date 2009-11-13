# -*- perl -*-

#
# Home.pm
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

package Sitetool::OS::Home;

use 5.8.0;

use warnings;
use strict;
use diagnostics;
use Config;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;
use Sitetool::OS::Directory;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&home);
}

sub home ()
{
    my $osname;
    my $homedir;

    $osname  = $Config{osname};
    $homedir = undef;
    if ($osname =~ /MSWin32/) {
        bug("MSWin32 not yet supported")
    } elsif ($osname =~ /darwin/) {
        bug("darwin not yet supported")
    } elsif ($osname =~ /MacOS9/) {
        bug("MacOS9 not yet supported")
    } else {
        $homedir = $ENV{HOME};
    }

    assert(defined($homedir));

    if (!directory_ispresent($homedir)) {
        bug("Problems detecting home directory");
    }

    return $homedir;
}

1;
