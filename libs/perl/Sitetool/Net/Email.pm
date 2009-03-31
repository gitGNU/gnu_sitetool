#
# Email.pm
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

package Sitetool::Net::Email;

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
    @EXPORT = qw(&obfuscate_email);
}

#
# Obfuscate email address from an input string
#
sub email_obfuscate ($)
{
  my $string = shift;

  assert(defined($string));

  if ($string =~ /^(.*?)\@(.*?)$/) {
      my $name;
      my $domain;

      $name   = $1;
      $domain = $2;

      assert(defined($name));
      assert(defined($domain));

      $string = $name . " DOT " . $domain;
  }

  assert(defined($string));

  return $string;
}

1;
