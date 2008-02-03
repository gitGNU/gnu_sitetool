#
# Trace.pm
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

package Sitetool::Base::Trace;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);
    
    @ISA    = qw(Exporter);
    @EXPORT = qw(&trace_prefix_set
		 &error
		 &warning &warning_set &warning_get 
		 &verbose &verbose_set &verbose_get
		 &debug   &debug_set   &debug_get  );
}

my $trace_prefix = "";
my $verbose_mode = 0;
my $debug_mode   = 0;
my $warning_mode = "none";

sub trace_prefix_set ($)
{
    my $string = shift;

    assert(defined($string));

    $trace_prefix = $string;
}

sub error ($)
{
    my $string = shift;

    assert(defined($string));

    print $trace_prefix . ": " . $string . "\n";
}

sub warning_set ($)
{
    my $string = shift;

    $warning_mode = $string;
}

sub warning_get ()
{
    return $warning_mode;
}

sub warning ($)
{
    my $string = shift;
    
    assert($warning_mode ne "");
    assert(defined($string));

    if ($warning_mode eq "none") {
	return;
    }

    print $trace_prefix . ": " . $string . "\n";
}

sub verbose_set ($)
{
    my $value = shift;

    $verbose_mode = $value;
}

sub verbose_get ()
{
    return $verbose_mode;
}

sub verbose ($)
{
    my $string = shift;

    assert(defined($string));

    if ($verbose_mode != 0) {
	print $trace_prefix . ": " . $string . "\n";
    }
}

sub debug_set ($)
{
    my $value = shift;

    $debug_mode = $value;
}

sub debug_get ()
{
    return $debug_mode;
}

sub debug ($)
{
    my $string = shift;

    assert(defined($string));

    if ($debug_mode != 0) {
	print $trace_prefix . ": " . $string . "\n";
    }
}

1;
