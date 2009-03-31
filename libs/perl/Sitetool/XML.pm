#
# XML.pm
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

package Sitetool::XML;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;
use Sitetool::Base::Trace;
use Sitetool::OS::Shell;
use Sitetool::OS::File;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&xml2xhtml);
}

sub xml2xhtml ($$)
{
    my $input_filename  = shift;
    my $output_filename = shift;

    assert(defined($input_filename));
    assert(defined($output_filename));

    debug("Transforming XML "            .
	  "\`" . $input_filename  . "' " .
	  "to XHTML "                    .
	  "\`" . $output_filename . "'");

    if (!file_ispresent($input_filename)) {
	error("File \`" . $input_filename . "' is missing");
	return 0;
    }

    my $string;

    $string =
	"cp $input_filename $output_filename";

    if (!shell_execute($string)) {
	error("Cannot transform XML file "  .
	      "\`" . $input_filename . "' " .
	      "into XHTML file "            .
	      "\`" . $output_filename . "'");
	return 0;
    }

    return 1;
}

1;
