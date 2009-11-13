# -*- perl -*-

#
# Stack.pm
#
# Copyright (C) 2008, 2009 Francesco Salvestrini
#                          Alessandro Massignan
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

package Sitetool::Data::Stack;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;

sub new {
    my $class = shift;

    assert(defined($class));

    my $self        = {};
    $self->{VALUES} = ();

    return bless($self, $class);
}

sub clear ($)
{
    my $self = shift;

    assert(defined($self));

    $self->{VALUES} = ();
}

sub push ($$)
{
    my $self  = shift;
    my $value = shift;

    assert(defined($self));

    push(@{$self->{VALUES}}, $value);
}

sub pop ($)
{
    my $self  = shift;
    my $value;

    assert(defined($self));

    $value = pop(@{$self->{VALUES}});

    return $value;
}

sub size ($)
{
    my $self = shift;

    assert(defined($self));

    return ($#{@{$self->{VALUES}}} + 1);
}

sub is_empty ($)
{
    my $self = shift;

    assert(defined($self));

    return (($self->size() == 0) ? 1 : 0);
}

sub poke ($)
{
  my $self  = shift;
  my $value;

  assert(defined($self));
  if ($self->is_empty()) {
      bug("poke() called on empty stack");
  }

  $value = $self->pop();
  $self->push($value);

  return $value;
}

sub peek ($$)
{
  my $self  = shift;
  my $value = shift;

  assert(defined($self));
  if ($self->is_empty()) {
      bug("peek() called on empty stack");
  }

  $value = $self->pop();
  $self->push($value);
}

1;
