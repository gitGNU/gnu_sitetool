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

    my $self = { };

    bless($self, $class);

    $self->clean();

    return $self;
}

sub clean($)
{
    my $self = shift;

    assert(defined($self));

    $self->{IDS}       = ( );
    $self->{SHORT}     = { };
    $self->{LONG}      = { };
    $self->{CALLBACK}  = { };
    $self->{ARGSMIN}   = { };
    $self->{ARGSMAX}   = { };
}

sub add($$$$$$$)
{
    my $self      = shift;
    my $id        = shift;
    my $short     = shift;
    my $long      = shift;
    my $callback  = shift;
    my $argsmin   = shift;
    my $argsmax   = shift;

    assert(defined($self));
    assert(defined($id));
    assert(defined($short) || defined($long));
    assert(ref($callback) eq 'CODE');
    assert($argsmin >= 0);
    assert($argsmax >= 0);
    assert($argsmin <= $argsmax);

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

    $self->{CALLBACK}->{$id} = $callback;
    $self->{ARGSMIN}->{$id}  = $argsmin;
    $self->{ARGSMAX}->{$id}  = $argsmax;

    debug("  option id:              \`" .
	  $id                            .
	  "'");
    debug("  option long:            \`"   .
	  (defined($self->{LONG}->{$id})   ?
	   $self->{LONG}->{$id} : "undef") .
	  "'");
    debug("  option short:           \`"    .
	  (defined($self->{SHORT}->{$id})   ?
	   $self->{SHORT}->{$id} : "undef") .
	  "'");
    debug("  option callback:        \`"      .
	  (defined($self->{CALLBACK}->{$id})  ?
	   $self->{CALLBACK}->{$id}: "undef") .
	  "'");
    debug("  option arguments min:   \`" .
	  $self->{ARGSMIN}->{$id}        .
	  "'");
    debug("  option arguments max:   \`" .
	  $self->{ARGSMAX}->{$id}        .
	  "'");

    return 1;
}

sub config($$)
{
    my $self      = shift;
    my $array_ref = shift;

    assert(defined($self));
    assert(defined($array_ref));

    $self->clean();

    my $id;
    $id = 0;
    for my $entry (@{$array_ref}) {

	if (!$self->add($id, @{$entry})) {
	    error("Failed to add option");
	    return 0;
	}
	$id++;
    }

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
    my $self        = shift;
    my $options_ref = shift;

    assert(defined($self));
    assert(defined($options_ref));

    debug("Options string \`" . "@{$options_ref}" . "'");

    if ($$options_ref[0] !~ /^\-/) {
	# No options to parse
	return 1;
    }

    my $index = 0;

    while ($index <= $#$options_ref) {
	my $id;
	my $option;
	my @arguments;

	$id        = "";
	$option    = $$options_ref[$index];
	@arguments = ( );

	debug("Options token: \`" . $option . "'");
	debug("Parsing index: " . $index . "'");

	if ($option eq "--") {
	    # Meet options terminator, close up
	    debug("Found options terminator");
	    $index++;
	    last;
	}

	if ($option =~ /^\-.*/) {
	    # Found option syntax, check if it is short or long

	    if ($option =~ /^\-\-.*/) {
		(my $tmp) = $option =~ /^\-\-(.*)/;
		$id       = $self->get_id_from_long($tmp);

		if (!defined($id)) {
		    error("Unknown option \`" . $option . "'");
		    return 0;
		}

		debug("Found long option \`" . $tmp .
		      "' with id \`"         . $id  .
		      "'");

	    } else {
		if (length($option) > 2) {
		    bug("Options bundling isn't supported");
		}

		(my $tmp) = $option =~ /^.(.)/;
		$id = $self->get_id_from_short($tmp);

		if (!defined($id)) {
		    error("Unknown option \`" . $option . "'");
		    return 0;
		}

		debug("Found short option \`" . $tmp .
		      "' with id \`"          . $id  .
		      "'");
	    }
	} else {
 	    error("Unknown option \`" . $option . "'");
 	    return 0;
	}

	if (($self->{ARGSMAX}->{$id} - $self->{ARGSMIN}->{$id}) == 0) {
	    # Parsing for options arguments

	    debug("Getting options arguments "   .
		  "["                            .
		  $self->{ARGSMIN}->{$id}        .
		  ", "                           .
		  $self->{ARGSMAX}->{$id}        .
		  "]");

	    if (($index + $self->{ARGSMIN}->{$id}) > $#$options_ref) {
		error("Too few arguments for option \`" . $option . "'");
		return 0;
	    }
	    $index++;

	    my $pre_index = $index;

	    for my $i ($index..$#$options_ref) {
		my $argument = $$options_ref[$i];

		if ($argument =~ /^\-..*/) {
		    # We encountered an option while parsing arguments.
		    # Check if we reach the minimum arguments number and
		    # then release the token

		    if (($i - $pre_index) < $self->{ARGSMIN}->{$id}) {
			error("Too few arguments for option \`" .
			      $option                           .
			      "'");
			return 0;
		    }
		    last;
		}

		if (($i - $pre_index) == $self->{ARGSMAX}->{$id}) {
		    # Reach max arguments number
		    last;
		}

		push(@arguments, $argument);

		debug("Found argument `" . $argument . "'");

		$index++;
	    }

	} else {
	    $index++;
	}

	debug("Executing callback");

	if (!&{$self->{CALLBACK}->{$id}}(@arguments)) {
	    error("Failed to execute callback for option \`" .
		  $option                                    .
		  "'");
	    return 0;
	}
    }

    if ($index > $#$options_ref) {
	undef(@{$options_ref});
    } else {
	@{$options_ref} = "@{$options_ref}[$index..$#$options_ref]";
    }

    return 1;
}

1;
