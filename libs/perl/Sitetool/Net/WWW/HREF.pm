#
# HREF.pm
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

package Sitetool::Net::WWW::HREF;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use File::Basename;
use File::Path;
use File::Spec;

use Sitetool::Autoconfig;
use Sitetool::Base::Trace;
use Sitetool::Base::Debug;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);

    @ISA    = qw(Exporter);
    @EXPORT = qw(&href_compute
		 &href_extract
		 &href_isftp
		 &href_ishttp
		 &href_ishttps
		 &href_ismailto);
}

sub href_isftp ($)
{
    my $link = shift;

    assert(defined($link));

    if ($link =~ m/^[ \t]*ftp:\/\/.*$/) {
	return 1;
    }

    return 0;
}

sub href_ishttp ($)
{
    my $link = shift;

    assert(defined($link));

    if ($link =~ m/^[ \t]*http:\/\/.*$/) {
	return 1;
    }

    return 0;
}

sub href_ishttps ($)
{
    my $link = shift;

    assert(defined($link));

    if ($link =~ m/^[ \t]*https:\/\/.*$/) {
	return 1;
    }

    return 0;
}

sub href_ismailto ($)
{
    my $link = shift;

    assert(defined($link));

    if ($link =~ m/^[ \t]*mailto:.*$/) {
	return 1;
    }

    return 0;
}

sub href_extract ($)
{
    my $string = shift;
    my @links;

    assert(defined($string));

    @links = ();

    while ($string =~ m/href\s*=\s*"([^"\s]+)"/gi) {
	push(@links, $1);
    }

    debug("Extracted HREFs are \`@links'");

    return @links;
}

#
# XXX FIXME:
#     We compute links using file related functions. This is an hack that works
#     only on UNIX. Obviously this is wrong and it should be fixed ASAP
#
sub href_compute ($$)
{
    my $from  = shift;
    my $to    = shift;
    my $link;

    assert(defined($from));
    assert(defined($to));

    debug("Computing relative link " .
	  "from \`" . $from . "'"    .
	  "to \`" . $to   . "'");
    {
	my ($from_volume, $from_path, $from_file) =
	    File::Spec->splitpath($from);

	debug("Fixing from \`" . $from . "'");
	$from = File::Spec->catpath($from_volume, $from_path, "");
	debug("Fixed from \`" . $from . "'");

	my ($to_volume,   $to_path,   $to_file)   =
	    File::Spec->splitpath($to);

	debug("Fixing to \`" . $to . "'");
	$to = File::Spec->catpath($to_volume, $to_path, $to_file);
	debug("Fixing to \`" . $to . "'");
    }

    $link = File::Spec->abs2rel($to, $from);
    assert(defined($link));

    $link = File::Spec->canonpath($link);

    debug("Link is \`" . $link . "'");

    return $link;
}

1;
