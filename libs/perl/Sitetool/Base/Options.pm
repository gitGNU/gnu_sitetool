#
# Options.pm
#
# Copyright (C) 2007, 2008 Francesco Salvestrini
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

package Sitetool::Base::Options;

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
    @EXPORT = qw();
}

sub new($)
{
    my $class = shift;
    my $self  = { };

    $self->{'SHORT'}     = { };
    $self->{'LONG'}      = { };
    $self->{'CALLBACK'}  = { };
    $self->{'ARGSCOUNT'} = { };
 
    bless $self, $class;

    return $self;
}

sub add($$$$$$)
{
    my $self      = shift;
    my $id        = shift;
    my $short     = shift;
    my $long      = shift;
    my $callback  = shift;
    my $argscount = shift;

    assert(defined($self));
    assert(defined($id));
    assert(defined($short) || defined($long));
    assert($argscount >= 0);
    assert(defined($callback));

    if (defined($long)) {
	assert(length($long) > 1);
	
	$self->{'LONG'}->{$id} = $long;
    }

    if (defined($short)) {
	assert(length($short) == 1);
	
	$self->{'SHORT'}->{$id} = $short;
    }

    $self->{'CALLBACK'}->{$id}  = $callback;
    $self->{'ARGSCOUNT'}->{$id} = $args;

     return 1;
}

sub parse($)
{
    my $self = shift;
    
    assert(defined($self));

    return 1;
}

1;
