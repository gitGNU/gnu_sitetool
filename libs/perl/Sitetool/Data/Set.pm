#
# Set.pm
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

package Sitetool::Set;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;

sub new {
    my $class = shift;

    assert(defined($class));

    my $self = { };

    $self->{DATA} = { };

    return bless($self, $class);
}

sub clear ($)
{
    my $self = shift;

    assert(defined($self));

    $self->{DATA} = { };
}

sub add ($$)
{
    my $self = shift;
    my $key  = shift;
    my $data = shift;

    assert(defined($self));
    assert(defined($key));

    $self->{DATA}->{$key} = $data;

    return 1;
}

sub remove ($$)
{
    my $self = shift;
    my $key  = shift;

    assert(defined($self));
    assert(defined($key));

    delete $self->{DATA}->{$key};

    return 1;
}

sub find ($$)
{
    my $self = shift;
    my $key  = shift;

    assert(defined($self));
    assert(defined($key));

    if (defined($self->{DATA}->{$key})) {
	return $self->{DATA}->{$key};
    }

    return undef;
}

sub foreach ($$)
{
    my $self         = shift;
    my $callback_ref = shift;

    assert(defined($self));
    assert(defined($callback_ref));

    for my $key (keys(%{$self->{DATA}})) {
	$callback_ref->($key);
    }

    return 1;
}

1;
