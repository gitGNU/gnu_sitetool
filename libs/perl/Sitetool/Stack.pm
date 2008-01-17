#
# Stack.pm
#
# (C) 2007, 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

package Sitetool::Stack;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

sub new {
  my $class = shift;

  assert(defined($class));

  my $self        = {};
  $self->{VALUES} = ();
  
  return bless($self, $class);
}

sub push($$) {
  my $self  = shift;
  my $value = shift;

  assert(defined($self));

  push(@{$self->{VALUES}}, $value);
}

sub pop($) {
  my $self  = shift;
  my $value;

  assert(defined($self));

  $value = pop(@{$self->{VALUES}});

  return $value;
}

#sub poke($) {
#  my $self  = shift;
#  my $value;
#
#  assert(defined($self));
#
#  # Replace the stack-top value with the passed one
#  $self->pop();
#  $self->push($value);
#
#  return $value;
#}
#
#sub peek($$) {
#  my $self  = shift;
#  my $value = shift;
#
#  assert(defined($self));
#
#  # Get the stack-top value without changing it
#  $value = $self->pop();
#  $self->push($value);
#}

1;
