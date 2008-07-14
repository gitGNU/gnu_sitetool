#
# Tuple.pm
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

package Sitetool::Tuple;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;

sub new ($$)
{
    my $class = shift;
    my $size  = shift;

    assert(defined($class));
    assert(defined($size));
    assert($size > 0);

    my $self = { };

    $self->{SIZE} = $size;
    $self->{DATA} = ( );

    bless $self, $class;

    return $self;
}

sub clear ($)
{
    my $self = shift;

    # $self->{SIZE} = $size;
    $self->{DATA} = ( );

    assert(defined($self));
}

sub size ($)
{
    my $self = shift;

    assert(defined($self));

    return $self->{SIZE};
}

sub value
{
    my $self  = shift;
    my $index = shift;
    my $value = shift;

    assert(defined($self));
    assert(defined($index));

    assert($index < $self->{SIZE});

    if (defined($value)) {
	$self->{DATA}[$index] = $value;
    }

    return $self->{DATA}[$index];
}

1;
