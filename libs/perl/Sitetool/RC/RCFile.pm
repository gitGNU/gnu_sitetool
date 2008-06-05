#
# RCFile.pm
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

package Sitetool::RC::RCFile;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;
use Sitetool::Base::Trace;
use Sitetool::OS::File;

sub new ($$)
{
    my $class    = shift;
    my $filename = shift;

    assert(defined($class));
    assert(defined($filename));

    my $self = { };

    $self->{FILENAME} = $filename;
    $self->{HOSTS}    = { };

    bless $self, $class;

    return $self;
}

#
# XXX FIXME: This sub is only a sketch, we should output more clearer messages
#
sub iscorrect ()
{
    my $self = shift;

    assert(defined($self));

    my $found_host = 0;
    for my $host (keys(%{$self->{HOSTS}})) {
	$found_host = 1;

	my $found_login = 0;
	for my $login (keys(%{$self->{HOSTS}->{$host}->{LOGIN}})) {

	    $found_login = 1;
	    if (!defined(($self->{HOSTS}->{$host}->{LOGIN}->{$login}))) {
		warning("Host "              .
			"\`" . $host . "', " .
			"login "             .
			"\`" . $login . "' " .
			"is without a password");
		return 1;
	    }
	}

	if (!$found_login) {
	    warning("Host \`" . $host . "' is without a login");
	    return 1;
	}
    }

    if (!$found_host) {
	warning("No hosts defined");
	return 1;
    }

    return 1;
}

sub load ($)
{
    my $self = shift;

    assert(defined($self));

    debug("Loading RC file");

    my $filename;

    $filename = $self->{FILENAME};
    assert(defined($filename));

    if (!file_ispresent($filename)) {
	error("File \`" . $filename . "' is not present");
	return 0;
    }

    my $filehandle;

    if (!open($filehandle, "<", $filename)) {
	error("Cannot open \`$filename' for input");
	return 0;
    }

    my $string;
    my $lineno;
    my $nodes;
    my $host;
    my $login;
    my $password;

    $host     = undef;
    $login    = undef;
    $password = undef;
    $lineno   = 0;
    $nodes    = 0;

    debug("Parsing file \`" . $filename . "'");
    while (<$filehandle>) {
	$string = $_;
	if ($string =~ /^[ \t]*\#.*$/) {
	    # Skip comments
	} elsif ($string =~ /^[ \t]*$/) {
	    # Skip empty lines
	} elsif ($string =~ /^[ \t]*host[ \t]+(.*)$/) {

	    $host     = $1;
	    $login    = undef;
	    $password = undef;

	    debug("Got $1");

	    assert(defined($host));
	    debug("Got host keyword at line " . $lineno . ", " .
		  "host = \`" . $host . "'");

	    $self->{HOSTS}->{$host} = { };

	    $nodes++;

	} elsif ($string =~ /^[ \t]*login[ \t]+(.*)$/) {

	    debug("Got $1");

	    $login    = $1;
	    $password = undef;

	    assert(defined($login));
	    debug("Got login keyword at line " . $lineno . ", " .
		  "login = \`" . $login . "'");

	    if (!defined($host)) {
		error("Wrong formatted input file \`" . $filename . "'");
		return 0;
	    }

	    #if (defined($self->{HOSTS}->{$host}->{LOGIN}->{$login})) {
	    #	error("Login \`" . $login . "' already defined");
	    #	return 0;
	    #}
	    $self->{HOSTS}->{$host}->{LOGIN}->{$login} = undef;

	    $nodes++;

	} elsif ($string =~ /^[ \t]*password[ \t]+(.*)$/) {

	    debug("Got $1");

	    $password = $1;

	    assert(defined($password));
	    debug("Got password keyword at line " . $lineno . ", " .
		  "password = \`" . $password . "'");

	    if (!defined($host)) {
		error("Wrong formatted input file \`" . $filename . "'");
		return 0;
	    }
	    if (!defined($login)) {
		error("Wrong formatted input file \`" . $filename . "'");
		return 0;
	    }

	    #if (defined($self->{HOSTS}->{$host}->{LOGIN}->{$login})) {
	    #	error("Login \`" . $login . "' already defined");
	    #	return 0;
	    #}
	    $self->{HOSTS}->{$host}->{LOGIN}->{$login} = $password;

	    $nodes++;

	} else {
	    error("Unknown input line " . $lineno . " in file " .
		  "\`" . $filename . "'");
	    return 0;
	}

	$lineno++;
    }
    debug("Parsing of \`" . $filename . "' complete");

    close($filehandle);

    if (!$self->iscorrect()) {
	error("File \`" . $filename . "' has an incorrect format");
	return 0;
    }

    debug("Loaded " . $nodes . " nodes");

    return 1;
}

sub save ($)
{
    my $self = shift;

    assert(defined($self));

    debug("Saving RC file");

    if (!$self->iscorrect()) {
	error("RC Data contains incorrect data");
	return 0;
    }

    my $filename;

    $filename = $self->{FILENAME};
    assert(defined($filename));

    my $filehandle;

    if (!open($filehandle, ">", $filename)) {
	error("Cannot open \`$filename' for input");
	return 0;
    }

    my $nodes;

    $nodes = 0;
    for my $host (keys(%{$self->{HOSTS}})) {
	debug("Saving host \`" . $host . "'");

	print $filehandle "host     " . $host . "\n";

	$nodes++;

	for my $login (keys(%{$self->{HOSTS}->{$host}->{LOGIN}})) {
	    debug("Saving login \`" . $login . "'");

	    print $filehandle "login    " . $login . "\n";

	    $nodes++;

	    my $password;

	    $password = $self->{HOSTS}->{$host}->{LOGIN}->{$login};
	    if (defined($password)) {
		debug("Saving password \`" . $password . "'");

		print $filehandle "password " . $password . "\n";

		$nodes++;
	    }
	}

	print $filehandle "\n";
    }
    debug("Saved " . $nodes . " nodes");

    close($filehandle);

    return 1;
}

sub add ($$$$)
{
    my $self     = shift;
    my $host     = shift;
    my $login    = shift;
    my $password = shift;

    assert(defined($self));
    assert(defined($host));
    assert(defined($login));
    assert(defined($password));

    debug("Adding RC entry " .
	  "(\`" . $host . "', \`" . $login . "', \`" . $password . "')");

    if (!defined($self->{HOSTS})) {
	$self->{HOSTS} = { };
	debug("HOSTS created")
    }
    if (!defined($self->{HOSTS}->{$host})) {
	$self->{HOSTS}->{$host} = { };
	debug("HOSTS \`" . $host . "' created")
    }
    if (!defined($self->{HOSTS}->{$host}->{LOGIN})) {
	$self->{HOSTS}->{$host}->{LOGIN} = { };
	debug("HOSTS \`" . $host . "' LOGIN created")
    }

    $self->{HOSTS}->{$host}->{LOGIN}->{$login} = $password;
    debug("HOSTS \`" . $host . "' LOGIN \`" . $login . "' password created " .
	  " with value \`" . $self->{HOSTS}->{$host}->{LOGIN}->{$login} . "'");

    return 1;
}

sub remove ($$$)
{
    my $self     = shift;
    my $host     = shift;
    my $login    = shift;

    assert(defined($self));
    assert(defined($host));
    assert(defined($login));

    debug("Removing RC entry " .
	  "(\`" . $host . "', \`" . $login . "')");

    delete $self->{HOSTS}->{$host}->{LOGIN}->{$login};

    return 1;
}

sub foreach ($$) {
    my $self     = shift;
    my $callback = shift;

    assert(defined($self));
    assert(defined($callback));

    for my $host (keys(%{$self->{HOSTS}})) {
	debug("Iterating over host \`" . $host . "'");

	for my $login (keys(%{$self->{HOSTS}->{$host}->{LOGIN}})) {
	    debug("Iterating over login \`" . $login . "'");

	    my $password;
	    $password = $self->{HOSTS}->{$host}->{LOGIN}->{$login};

	    if (!$callback->($host, $login, $password)) {
		return;
	    }
	}
    }
}

1;
