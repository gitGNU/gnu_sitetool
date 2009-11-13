# -*- perl -*-

#
# Text.pm
#
# Copyright (C) 2008, 2009 Francesco Salvestrini
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

package Sitetool::Misc::Text;

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
    @EXPORT = qw(&text_wrap
                 &text_length);
}

sub text_length ($)
{
    my $text   = shift;

    assert(defined($text));

    my $length;

    while ($text =~ s/([^\n]+)//) {
        my $s = $1;
        my $l = length($s);
        my $t = $s =~ s/\t/\t/sg;
        $l   += 7 * $t;

        if (defined($length)) {

            if ($l > $length) {
                $length = $l;
            }
        } else {
            $length = $l;
        }
    }

    return $length;
}

sub text_wrap ($$)
{
    my $text     = shift;
    my $max_len  = shift;

    assert(defined($text));
    assert($max_len > 0);

    if ($max_len >= text_length($text)) {
        return $text;
    }

    my $result;

    while ($text =~ s/([^\n]+)//) {
        my $string = $1;

        assert(defined($string));

        my $buffer;

        while (($string =~ s/^([^ \t]+)//) || ($string =~ s/^([ \t])//)) {
            my $token = $1;

            assert(defined($token));

            if (text_length($token) > $max_len) {

                if (defined($result)) {
                    $result = $result . "\n" . $token;
                } else {
                    $result = $token;
                }
                next;
            }

            if (defined($buffer)) {

                if ((text_length($buffer) + text_length($token)) < $max_len) {
                        $buffer = $buffer . $token;
                } else {

                    if (defined($result)) {
                        $result = $result . "\n" . $buffer;
                        undef($buffer);
                    } else {
                        $result = $buffer;
                        undef($buffer);
                    }
                    $buffer = $token;
                }
            } else {
                $buffer = $token;
            }

            if ($string eq "") {

                if (defined($result)) {
                    $result = $result . "\n" . $buffer;
                } else {
                    $result = $buffer;
                }
                undef($buffer);
            }
        }

        if (defined($buffer)) {

            if (defined($result)) {
                $result = $result . $buffer;
            } else {
                $result = $buffer;
            }
        }
    }

    return $result;
}

1;
