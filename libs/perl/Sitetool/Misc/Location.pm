# -*- perl -*-

#
# Location.pm
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

package Sitetool::Misc::Location;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;
use Sitetool::Data::Stack;

sub new
{
    my $class = shift;

    assert(defined($class));

    my $self = {};

    $self->{POSITION} = undef;
    $self->{CONTEXTS} = Sitetool::Data::Stack->new();
    assert(defined($self->{CONTEXTS}));

    return bless($self, $class);
}

sub position_set ($$)
{
    my $self     = shift;
    my $position = shift;

    assert(defined($self));
    assert(defined($position));

    $self->{POSITION} = $position;

    return 1;
}

sub position_get ($)
{
    my $self = shift;

    assert(defined($self));

    return $self->{POSITION};
}

sub contexts_push ($$)
{
    my $self    = shift;
    my $context = shift;

    assert(defined($self));
    assert(defined($context));

    return $self->{CONTEXTS}->push($context)
}

sub contexts_pop ($)
{
    my $self = shift;

    assert(defined($self));

    return $self->{CONTEXTS}->pop();
}

sub contexts_size ($)
{
    my $self = shift;

    assert(defined($self));

    return $self->{CONTEXTS}->size();
}

1;
