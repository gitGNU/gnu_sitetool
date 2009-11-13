# -*- perl -*-

#
# String.pm
#
# Copyright (C) 2008, 2009 Francesco Salvestrini
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

package Sitetool::OS::String;

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
    @EXPORT = qw(&string_tofile
                 &string_uppercase
                 &string_lowercase
                 &string_purify
                 &string_replace
                 &string_replace_many
                 &string_isnumber
                 &string_tonumber);
}

sub string_isnumber ($)
{
    my $string = shift;

    assert(defined($string));

    if ($string == "$string") {
        return 1;
    }

    return 0;
}

sub string_tonumber ($)
{
    my $string = shift;

    assert(defined($string));

    my $t;
    foreach my $d (split(//, shift())) {
        $t = $t * 10 + $d;
    }

    return $t;
}

sub string_replace ($$$)
{
    my $string = shift;
    my $from   = shift;
    my $to     = shift;

    assert(defined($string));
    assert(defined($from));
    assert(defined($to));

    $string =~ s/$from/$to/g;

    return $string;
}

sub string_replace_many ($$)
{
    my $string   = shift;
    my $hash_ref = shift;

    assert(defined($string));
    assert(defined($hash_ref));

    my %hash;
    %hash = %{$hash_ref};

    for my $key (keys(%hash)) {
        my $value;

        $value = $hash{$key};

        assert(defined($value));

        $string = string_replace($string, $key, $value);
    }

    return $string;
}

sub string_uppercase ($)
{
    my $string = shift;

    assert(defined($string));

    return uc($string);
}

sub string_lowercase ($)
{
    my $string = shift;

    assert(defined($string));

    return lc($string);
}

#
# Removes duplicated spaces and tabs from input string
#
sub string_purify ($)
{
  my $string = shift;

  assert(defined($string));

  chomp $string;
  $string =~ s/\t+/\ /;
  $string =~ s/\s+/\ /;

  assert(defined($string));

  return $string;
}

sub string_tofile ($$)
{
    my $string   = shift;
    my $filename = shift;

    assert(defined($filename));

    my $filehandle;

    if (!open($filehandle, ">", $filename)) {
        error("Cannot open \`$filename' for output");
        return 0;
    }

    print $filehandle $string;

    close($filehandle);

    return 1;
}

1;
