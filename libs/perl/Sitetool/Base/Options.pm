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
    $self->{HASARG}    = undef;
    $self->{OPTARG}    = undef;
    $self->{OPTIND}    = 0;
    $self->{STRERROR}  = undef;

    # XXX Fix me:
    #   May we offer both 'opterr' and 'optopt' support?
}

sub _error($$)
{
    my $self   = shift;
    my $string = shift;

    chomp($string);
    $self->{STRERROR} = $string;
}

sub strerror($)
{
    my $self = shift;

    return $self->{STERROR};
}

sub add ($$$$$$)
{
    my $self     = shift;
    my $id       = shift;
    my $short    = shift;
    my $long     = shift;
    my $callback = shift;
    my $hasarg   = shift;

    assert(defined($self));
    assert($id >= 0);
    assert(defined($short) || defined($long));
    assert(ref($callback) eq 'CODE');
    assert((ref($hasarg) eq "HASH")      ||
	   ($hasarg >= 0 && $hasarg <= 2));

    debug("Adding option");

    if ($self->__check_id($id)) {
	$self->_error("ID \`" . $id . "' is already present");
	return 0;
    }
    push(@{$self->{IDS}}, $id);

    if (defined($long)) {
	assert(length($long) > 1);

	my $tmp = $self->__get_id_from_long($long);

	if (defined($tmp)) {
	    $self->_error("Long option \`"    . $long . "' " .
			  "has already id \`" . $tmp  . "'" );
	    return 0;
	}
	$self->{LONG}->{$id} = $long;
    }

    if (defined($short)) {
	assert(length($short) == 1);

	my $tmp = $self->__get_id_from_short($short);

	if (defined($tmp)) {
	    $self->_error("Short option \`"   . $short . "' " .
			  "has already id \`" . $tmp   . "'" );
	    return 0;
	}
	$self->{SHORT}->{$id} = $short;
    }

    $self->{CALLBACK}->{$id} = $callback;
    $self->{HASARG}->{$id}   = $hasarg;

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
    debug("  option callback:        \`"       .
	  (defined($self->{CALLBACK}->{$id})   ?
	   $self->{CALLBACK}->{$id} : "undef") .
	  "'");
    debug("  option arguments:       \`"   .
	  ($self->{HASARG}->{$id} eq '0'   ?
	   "none"                          :
	   ($self->{HASARG}->{$id} eq '1'  ?
	    "required"                     :
	    ($self->{HASARG}->{$id} eq '2' ?
	     "optional"                    :
	     "subopts")))	           .
	  "\`");

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
	    $self->_error("Failed to add option");
	    return 0;
	}
	$id++;
    }

    return 1;
}

sub __get_id_from_abbr ($$)
{
    my $self   = shift;
    my $string = shift;

    assert(defined($self));
    assert(defined($string));

    my $id;

    #
    # Checking for long options abbreviated form and return
    #   '-1'      - if it founds the same abbreviation twice
    #   'undef'   - if any option matches the abbreviation
    #   option ID - if an option matches the abbreviation
    #
    for my $i (keys %{$self->{LONG}}) {

	if ($self->{LONG}->{$i} =~ /^$string.+$/) {
	    debug("Option \`"              . $self->{LONG}->{$i} .
		  "\` with id \`"          . $i                  .
		  "\` completes string \`" . $string             .
		  "\`");

	    if (defined($id)) {
		return -1;
	    }

	    $id = $i;
	}
    }

    return $id;
}

sub __get_id_from_long ($$)
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

sub __get_id_from_short ($$)
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

sub __check_id ($$)
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

sub parse ($$)
{
    my $self     = shift;
    my $argv_ref = shift;

    assert(defined($self));
    assert(defined($argv_ref));

    debug("Parsing options string");

    debug("Options string \`" . "@{$argv_ref}" . "'");

    if (($#{$argv_ref} == -1)    ||
	($$argv_ref[0] !~ /^\-/) ||
	($$argv_ref[0] =~ /^.$/)) {
	# No options to parse
	return 1;
    }

    while ($self->{OPTIND} <= $#$argv_ref) {
	my @option_args;
	my $opt_id;
	my $option;
	my %subopts;

	# Cleaning up option argument variable
	$self->{OPTARG} = undef;

	# Storing option from ARGV (for debugging purpose)
	$option = $$argv_ref[$self->{OPTIND}];

	# Getting option ID
	$opt_id = $self->__getopt_long($argv_ref);
	assert(defined($opt_id));

	# Checking return value from getopt_long()
	if ($opt_id eq '-1') {
	    #
	    # No more options
	    #
	    return 1;
	}

	if ($opt_id eq '?') {
	    # Error found (error message already printed)
	    assert(defined($self->{STRERROR}));
	    return 0;
	}

	assert(defined($opt_id));

	#
	# Arranging arguments for option callback
	#
	# XXX Fix me:
	#  for the moment we handle callback's arguments with an
	#  array, but when subopts code will raise: should we
	#  handle it in a diferrent way?
	#
	if (defined($self->{OPTARG})) {
	    debug("Option arguments: \`" . $self->{OPTARG} . "\`");

	    push(@option_args, $self->{OPTARG});
	}

	debug("Executing callback");

	my $callback_ret = &{$self->{CALLBACK}->{$opt_id}}(@option_args);

	debug("Callback for option \`" . $option . "' " .
	      "returned " . $callback_ret);

	if ($callback_ret < 0) {
	    debug("Callback returned with error");
	    return 0;
	} elsif ($callback_ret == 0) {
	    debug("Callback for option \`" . $option . "' " .
		  "requested a premature quit");
	    return 1;
	} else {
	    debug("Callback returned correctly");
	}
    }

    debug("Options parsing complete");

    return 1;
}

sub __getopt_long ($$)
{
    my $self     = shift;
    my $argv_ref = shift;

    assert(defined($self));
    assert(defined($argv_ref));
    assert($self->{OPTIND} >= 0);

    if ($$argv_ref[$self->{OPTIND}] =~ /^.$/) {
	return -1;
    }

    my $curr_opt = $$argv_ref[$self->{OPTIND}];
    assert($curr_opt =~ /\-.+/);

    debug("Processing ARGV[" . $self->{OPTIND} .
	  "]: \`"            . $curr_opt       .
	  "\`");


    # Matching the terminator we give up from getopt() moving
    # the index on the next position
    if ($curr_opt eq "--") {
	debug("Found options terminator \`" . $curr_opt . "\`");
	$self->{OPTIND}++;
	return -1;
    }

    my $opt_id;
    my $tmp_opt;
    my $tmp_arg;

    if ($curr_opt =~ /^\-\-/) {
	debug("Checking current ARGV for long option");

	$curr_opt =~ /^\-\-([^=]+)(=(.*))?$/;
	assert(defined($1));

	$tmp_opt = $1;

	if (defined($3)) {
	    $tmp_arg = $3;
	}
	$opt_id = $self->__get_id_from_long($tmp_opt);

	# If long option matching failed, we move for abbreviated form
	if(!defined($opt_id)) {
	    $opt_id = $self->__get_id_from_abbr($tmp_opt);

	    if (defined($opt_id) && $opt_id eq "-1") {
		$self->_error("Option \`" . $curr_opt . "\` is ambiguous");
		return '?';
	    }
	}
    } else {
	debug("Checking current ARGV for short option");

	$curr_opt =~ /^\-(.*)$/;
	assert(defined($1));

	if (length($1) > 1) {
	    $curr_opt =~ /^\-(.)(.*)$/;

	    $tmp_opt = $1;
	    $tmp_arg = $2;
	} else {
	    $tmp_opt = $1;
	}
	$opt_id = $self->__get_id_from_short($tmp_opt);
    }

    if (!defined($opt_id)) {
	$self->_error("Unrecognized option \`" . $ curr_opt . "\`");
	return '?';
    }

    # Option matching success... Going for its arguments
    if (!defined($tmp_arg)) {
	$tmp_arg = $$argv_ref[++$self->{OPTIND}];
    } else {

	if ($self->{HASARG}->{$opt_id} eq '0') {
	    $self->_error("Option \`" . $tmp_opt . "\` " .
			  "does not allow an argument");
	    return '?'
	}
    }

    if (($self->{HASARG}->{$opt_id} eq '1')         ||
	(ref($self->{HASARG}->{$opt_id}) eq "HASH")) {

	debug("Checking for required argument");

	if ((!defined($tmp_arg))                &&
	    (++$self->{OPTIND} > $#{$argv_ref})) {
	    $self->_error("Missing arguments for option " .
			  "\`" . $curr_opt . "\`");
	    return '?';
	}
	$self->{OPTARG} = $tmp_arg;
	$self->{OPTIND}++;
    }

    if ($self->{HASARG}->{$opt_id} eq '2') {

	debug("Checking for optional argument");

	# Skipping argument if we reach the end of options array or if it's
	# another option
	if ((++$self->{OPTIND} > $#{$argv_ref} + 1)       ||
	    defined($self->__get_id_from_long($tmp_arg))  ||
	    defined($self->__get_id_from_abbr($tmp_arg))  ||
	    defined($self->__get_id_from_short($tmp_arg))) {
	    return $opt_id;
	}
	$self->{OPTARG} = $tmp_arg;
    }

    return $opt_id;
}

1;
