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

    debug("Creating object for options handling");

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

    debug("Adding option");

    if (defined($long)) {
	assert(length($long) > 1);
	$self->{'LONG'}->{$id} = $long;
    }

    if (defined($short)) {
	assert(length($short) == 1);
	$self->{'SHORT'}->{$id} = $short;
    }

    $self->{'CALLBACK'}->{$id}  = $callback;
    $self->{'ARGSCOUNT'}->{$id} = $argscount;

    debug("  option id:              `" .
	  $id                           .
	  "\'");
    debug("  option long:            `"    .
	  defined($self->{'LONG'}->{$id})  ?
	  $self->{'LONG'}->{$id} : "undef" .
	  "\'");
    debug("  option short:           `"     .
	  defined($self->{'SHORT'}->{$id})) ?
	  $self->{'SHORT'}->{$id} : "undef"  .
	  "\'");
    debug("  option callback:        `" .
	  $self->{'CALLBACK'}->{$id}    .
	  "\'");
    debug("  option arguments count: `" .
	  $self->{'ARGSCOUNT'}->{$id}   .
	  "\'");

    return 1;
}

# XXX FIXME: We need a get_id_from_short() and a get_id_from_long() cause we
#            could eventually have -v and --v ...
sub get_id($)
{
    my $self = shift;
    my $opt  = shift;

    assert(defined($self));
    assert(defined($opt));

    for my $k (keys $self->{'LONG'}) {

	if ($self->{'LONG'}->{$k} eq $opt) {
	    debug("Found option with id `" .
		  $k                       .
		  "\'");

    	    return $k;
	}
    }

    for my $k (keys $self->{'SHORT'}) {

	if ($self->{'SHORT'}->{$k} eq $opt) {
	    debug("Found option with id `" .
		  $k                       .
		  "\'");

	    return $k;
	}
    }

    return undef;
}

sub parse($$)
{
    my $self   = shift;
    my $string = shift;

    assert(defined($self));
    assert(defined($string));

    $string =~ s/^\s+//;
    $string =~ s/\s+$//;

    debug("Parsing options\' string `" .
	  $string                      .
	  "\'");


    if (length($string) < 2) {
	return $string;
    }

    while ($string =~ s/([^\s]+)//) {
	my $token = $1;

	debug("Current token is `" .
	      $token               .
	      "\'");

	if ($token eq "--") {
	    # Options' end
	    return $string;
	}

	my $tmp;
	my $id;

	($tmp) = $token =~ /^(.)/;

	if ($tmp eq "-") {
	    ($tmp) = $token =~ /^.(.)/;

	    if ($tmp eq "-") {

		($tmp) = $token =~ /^..(.*)/;
		$id    = get_id($tmp);

		if (!defined($id)) {
		    error("Unknown long option `" .
			  $token                  .
			  "\'");
		    return undef;
		}

	    } else {

		if (length($token) > 2) {
		    # XXX FIXME: Use bug()
		    error("Options\' bundling isn\'t supported");
		    return 1
		}

		($tmp) = $token =~ /^.(.)/;
		$id    = get_id($tmp);

		if (!defined($id)) {
		    error("Unknown short option `" .
			  $token                   .
			  "\'");
		    return undef;
		}
	    }
	} else {

	    error("Unknown option `" .
		  $token             .
		  "\'");
	    return undef;

	}

	debug("Getting options\' parameters");

	my @params;

	for (my $i = 0; $i < $self->{'ARGSCOUNT'}->{$id}; $i++) {
	    $string =~ s/([^\s]+)//;

	    if (!defined($1)) {
		error("Missing parameter for option `" .
		      $token                           .
		      "\'");
		return undef;
	    }

	    my $param = $1;

	    if ($param =~ /^\"/) {

		while ($string =~ s/([^\"]+)//) {

		    if (!defined($1)) {
			error("Unterminated option parameter `" .
			      $string                           .
			      "\'");
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
	}

	if ($self->{'ARGSCOUNT'}->{$id} > 0) {
	    assert($#params == ($self->{'ARGSCOUNT'}->{$id} - 1));
	}
    }

    return $string;
}

1;
