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

sub new ($)
{
    my $class = shift;

    assert(defined($class));

    my $self = { };

    bless($self, $class);

    $self->clean();

    return $self;
}

sub clean ($)
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

sub add ($$$$$$$)
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

sub config ($$)
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

sub get_id_from_long ($$)
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

sub get_id_from_short ($$)
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

sub check_id ($$)
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

sub _parse_sub_options ($$$$$)
{
    my $options_ref   = shift;
    my $option        = shift;
    my $args_min      = shift;
    my $args_max      = shift;
    my $arguments_ref = shift;

    assert(defined($options_ref));
    assert(defined($option));
    assert($args_max >= 0);
    assert($args_min <= $args_max);
    assert($#$arguments_ref == -1);

    if ((($#$options_ref == -1) || ($$options_ref[0] =~ /^\-/)) &&
	($args_min == 0)) {
	# No options to parse
	return 1;
    }

    if ($args_max > 0) {
	# Parsing for options arguments

	debug("Getting options arguments "   .
	      "["  . $args_min               .
	      ", " . $args_max               .
	      "]");

	if ($args_min > ($#$options_ref + 1)) {
	    error("Too few arguments for option \`" . $option . "'");
	    return 0;
	}

	my $idx = 0;

	while ($#$options_ref > -1) {
	    my $argument = shift(@{$options_ref});

	    if ($argument =~ /^\-..*/) {
		# We encountered an option while parsing arguments.
		# Check if we reach the minimum arguments number and
		# then release the token

		if ($idx < $args_min) {
		    error("Too few arguments for option \`" . $option . "'");
		    return 0;
		}
		unshift(@{$options_ref}, $argument);
		last;
	    }

	    if ($idx == $args_max) {
		# Reach max arguments number
		last;
	    }

	    push(@{$arguments_ref}, $argument);

	    debug("Found argument `" . $argument . "'");

	    $idx++;
	}
    }

    return 1;
}

sub parse ($$)
{
    my $self        = shift;
    my $options_ref = shift;

    assert(defined($self));
    assert(defined($options_ref));

    if (($#{$options_ref} == -1) || ($$options_ref[0] !~ /^\-/)) {
	# No options to parse
	return 1;
    }

    debug("Options string \`" . "@{$options_ref}" . "'");

    while ($#$options_ref > -1) {
	my $id;
	my $option;

	$id        = "";
	$option    = shift(@{$options_ref});

	assert(defined($option));

	debug("Options token: \`" . $option . "'");

	if ($option eq "--") {
	    # Meet options terminator, close up
	    debug("Found options terminator");
	    last;
	}

	if ($option =~ /^\-.*/) {
	    # Found option syntax, check if it is short or long

	    if ($option =~ /^\-\-.*/) {
		$option =~ s/^\-\-//;

		if ($option =~ /([^\=]+)\=(.*)/) {
		    # Splitting option pattern "--option=params"

		    assert(defined($1));

		    $option = $1;

		    if (defined($2)) {
			unshift(@{$options_ref}, $2);
		    }
		}

		$id = $self->get_id_from_long($option);

		if (!defined($id)) {
		    error("Unknown long option \`" . $option . "'");
		    return 0;
		}

		debug("Found long option \`" . $option .
		      "' with id \`"         . $id     .
		      "'");

	    } else {
		$option =~ s/^\-//;

		if (length($option) > 1) {
		    # Handling options bundling

		    my @bundle;
		    my $tmp = $option;

		    $tmp = join(" -", split(/\ */, $tmp));
		    $tmp = "-" . $tmp;
		    @bundle = split(/\ /, $tmp);

		    debug("Bundled options \`" . $option   .
			  "' expanded as \`"   . "@bundle" .
			  "'");

		    $option = $tmp;

		    if (!&parse($self, \@bundle)) {
			error("Failed to parse bundled options `-" .
			      $option                              .
			      "'");
			return 0;
		    }
		    next;
		}

		$id = $self->get_id_from_short($option);

		if (!defined($id)) {
		    error("Unknown option \`" . $option . "'");
		    return 0;
		}

		debug("Found short option \`" . $option .
		      "' with id \`"          . $id     .
		      "'");
	    }
	} else {
	    error("Unknown option \`" . $option . "'");
	    return 0;
	}

	my @arguments;

	@arguments = qw( );

	if (!_parse_sub_options($options_ref,
			       $option,
			       $self->{ARGSMIN}->{$id},
			       $self->{ARGSMAX}->{$id},
			       \@arguments)) {
	    error("Failed to parse sub options " .
		  "for option \`" . $option      .
		  "\`");
	    return 0;
	}

	debug("Executing callback");

	if (!&{$self->{CALLBACK}->{$id}}(@arguments)) {
	    debug("Callback for option \`" . $option . "' " .
		  "requested a premature quit");
	    return 1;
	}
    }

    return 1;
}

1;
