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

package Sitetool::RCFile;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;
use Sitetool::OS::File;

sub new ($$)
{
    my $class    = shift;
    my $filename = shift;

    assert(defined($class));
    assert(defined($filename));

    my $self = { };

    $self->{FILENAME} = $filename;

    bless $self, $class;

    return $self;
}

sub read ($)
{
    my $self = shift;

    assert(defined($self));

    my $filename;

    $filename = $self->{FILENAME};
    assert(defined($filename));

    if (!file_is_present($filename)) {
	error("File \`" . $filename . "' is not present");
	return 0;
    }

    my $filehandle;

    if (!open($filehandle, "<", $filename)) {
	error("Cannot open \`$filename' for input");
	return 0;
    }

    my $string;
#    my $section;

    while (<$filehandle>) {
	$string = $_;
#	if ($string =~ /\[(.*)\]/) {
#	    # Got a section
#	    $section = $1;
#	    $section = s/^[ \t]*//;
#	    $section = s/[ \t]*$//;
#	} elsif ($string =~ /[](.*)[]=[](.*)[]/) {
#	    my $variable;
#	    my $value;
#
#	    $variable = $1;
#	    $value    = $2;
#	}
    }

    close($filehandle);

    return 1;
}

sub write ($)
{
    my $self = shift;

    assert(defined($self));

    my $filename;

    $filename = $self->{FILENAME};
    assert(defined($filename));

    my $filehandle;

    if (!open($filehandle, "<", $filename)) {
	error("Cannot open \`$filename' for input");
	return 0;
    }

    print $filehandle "";

    close($filehandle);

    return 1;
}

1;
