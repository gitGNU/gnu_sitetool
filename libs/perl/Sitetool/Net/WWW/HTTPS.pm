# -*- perl -*-

#
# HTTPS.pm
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

package Sitetool::Net::WWW::HTTPS;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Autoconfig;
use Sitetool::Base::Trace;
use Sitetool::Base::Debug;
use Sitetool::OS::Shell;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&https_download);
}

sub https_download ($$)
{
    my $href     = shift;
    my $filename = shift;

    assert(defined($href));
    assert(defined($filename));

    # XXX FIXME: Replace with a proper check
    assert(defined($WGET));
    if ($WGET eq "") {
        error("The wget executable was not available in your system when "  .
              $PACKAGE_NAME . " has been configured");
        error("In order to use the requested functionality please install " .
              "wget and re-install " . $PACKAGE_NAME);
        exit 1;
    }

    my $command;

    $command = "$WGET -q --timeout 1 -l 1 -O $filename -- $href";
    if (!shell_execute($command)) {
        return 0;
    }

    return 1;
}

1;
