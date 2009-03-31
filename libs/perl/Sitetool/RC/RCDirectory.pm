#
# RCDirectory.pm
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

package Sitetool::RC::RCDirectory;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;
use Sitetool::Base::Trace;
use Sitetool::OS::String;
use Sitetool::OS::Directory;
use Sitetool::OS::Home;
use Sitetool::OS::Environment;

sub new ($)
{
    my $class = shift;

    assert(defined($class));

    my $self = { };

    my $directory;

    $directory = environment_get("SITETOOL_RC_FILES");
    if (!defined($directory)) {
	$directory =
	    File::Spec->catfile(home(),
				"." . $Sitetool::Autoconfig::PACKAGE_NAME);
	$directory = string_lowercase($directory);
	assert(defined($directory));
    }

    $self->{NAME} = $directory;

    if (!directory_ispresent($directory)) {
	if (!directory_create($directory)) {
	    return undef;
	}
    }

    assert(directory_ispresent($directory));

    bless $self, $class;

    return $self;
}

sub dirname ($)
{
    my $self = shift;

    assert(defined($self));

    return $self->{NAME};
}

1;
