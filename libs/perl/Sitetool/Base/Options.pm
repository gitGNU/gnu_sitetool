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

sub new($)
{
    my $class = shift;

    assert(defined($class));

    my $self  = { };

    debug("Creating object for options handling");

    $self->{IDS}       = ( );
    $self->{SHORT}     = { };
    $self->{LONG}      = { };
    $self->{CALLBACK}  = { };
    $self->{ARGSCOUNT} = { };

    return bless($self, $class);
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
    assert(defined($callback));
    assert($argscount >= 0);

    debug("Adding option");

    if ($self->check_id($id)) {
	error("ID \`" . $id . "' is already present");
	return 0;
    }
    push(@{$self->{IDS}}, $id);

    if (defined($long)) {
	assert(length($long) > 1);

	my $tmp = $self->get_id_from_long($long);

	if (defined($tmp)) {
	    error("Long option \`"    . $long . "' " .
		  "has already id \`" . $tmp  . "'" );
	    return 0;
	}
	$self->{LONG}->{$id} = $long;
    }

    if (defined($short)) {
	assert(length($short) == 1);

	my $tmp = $self->get_id_from_short($short);

	if (defined($tmp)) {
	    error("Short option \`"   . $short . "' " .
		  "has already id \`" . $tmp   . "'" );
	    return 0;
	}
	$self->{SHORT}->{$id} = $short;
    }

    $self->{CALLBACK}->{$id}  = $callback;
    $self->{ARGSCOUNT}->{$id} = $argscount;

    debug("  option id:              `" .
	  $id                           .
	  "\'");
    debug("  option long:            `"    .
	  (defined($self->{LONG}->{$id})   ?
	   $self->{LONG}->{$id} : "undef") .
	  "\'");
    debug("  option short:           `"     .
	  (defined($self->{SHORT}->{$id})   ?
	   $self->{SHORT}->{$id} : "undef") .
	  "\'");
    debug("  option callback:        `"       .
	  (defined($self->{CALLBACK}->{$id})  ?
	   $self->{CALLBACK}->{$id}: "undef") .
	  "\'");
    debug("  option arguments count: `" .
	  $self->{ARGSCOUNT}->{$id}     .
	  "\'");

    return 1;
}

sub get_id_from_long($$)
{
    my $self = shift;
    my $opt  = shift;

    assert(defined($self));
    assert(defined($opt));

    for my $id (keys %{$self->{LONG}}) {

	if ($self->{LONG}->{$id} eq $opt) {
	    debug("Got long option \`" . $opt . "' for id \`" . $id . "'");
	    return $id;
	}
    }

    return undef;
}

sub get_id_from_short($$)
{
    my $self = shift;
    my $opt  = shift;

    assert(defined($self));
    assert(defined($opt));

    for my $id (keys %{$self->{SHORT}}) {

	if ($self->{SHORT}->{$id} eq $opt) {
	    debug("Got short option \`" . $opt . "' for id \`" . $id . "'");
	    return $id;
	}
    }

    return undef;
}

sub check_id($$)
{
    my $self = shift;
    my $id   = shift;

    assert(defined($self));
    assert(defined($id));

    for my $i (@{$self->{IDS}}) {

	if ($id eq $self->{IDS}[$i]) {
	    return 1;
	}
    }

    return 0;
}

sub parse($$)
{
    my $self   = shift;
    my $string = shift;

    assert(defined($self));
    assert(defined($string));

    $string =~ s/^\s+//;
    $string =~ s/\s+$//;

    debug("Parsing options\' string `" . $string . "\'");

    if (length($string) < 2) {
	return $string;
    }

    while ($string =~ s/([^\s]+)//) {
	my $token = $1;

	debug("Current token is `" . $token . "\'");

	if ($token eq "--") {
	    # Options end
	    return $string;
	}

	my $tmp;
	my $id;

	($tmp) = $token =~ /^(.)/;

	if ($tmp eq "-") {
	    ($tmp) = $token =~ /^.(.)/;

	    if ($tmp eq "-") {
		($tmp) = $token =~ /^..(.*)/;
		$id    = $self->get_id_from_long($tmp);

		if (!defined($id)) {
		    error("Unknown long option `" . $token . "\'");
		    return undef;
		}

		debug("Found long option `" . $tmp .
		      "\' with id `"        . $id  .
		      "\'");
	    } else {

		if (length($token) > 2) {
		    bug("Options bundling isn\'t supported");
		}

		($tmp) = $token =~ /^.(.)/;
		$id    = $self->get_id_from_short($tmp);

		if (!defined($id)) {
		    error("Unknown short option `" . $token . "\'");
		    return undef;
		}

		debug("Found short option `" . $tmp .
		      "\' with id `"         . $id  .
		      "\'");
	    }
	} else {
	    error("Unknown option `" . $token . "\'");
	    return undef;
	}

	if ($self->{ARGSCOUNT}->{$id} > 0) {
	    debug("Getting options parameters [" .
		  $self->{ARGSCOUNT}->{$id}      .
		  "]");
	}

	my @params;

	for (my $i = 0; $i < $self->{ARGSCOUNT}->{$id}; $i++) {
	    $string =~ s/([^\s]+)//;

	    if (!defined($1)) {
		error("Missing parameter for option `" . $tmp . "\'");
		return undef;
	    }

	    my $param = $1;

	    if ($param =~ /^\"/) {

		while ($string =~ s/([^\"]+)//) {
		    if (!defined($1)) {
			error("Missing parameter for `" . $string . "\'");
			return undef;
		    }

		    my $tmp = $1;

		    if ($tmp =~ /\\$/) {
			$string = s/^(.)//;
			$tmp    = $tmp . $1;
		    }

		    $param = $param . $tmp;
		}

	    }
	    $params[$i] = $param;

	    debug("Found parameter `" . $params[$i] . "\'");
	}

	if ($self->{ARGSCOUNT}->{$id} > 0) {
	    assert($#params == ($self->{ARGSCOUNT}->{$id} - 1));
	}
    }

    return $string;
}

1;
