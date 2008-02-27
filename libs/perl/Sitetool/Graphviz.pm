#
# Graphviz.pm
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

package Sitetool::Graphviz;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;
use Sitetool::OS::File;
use Sitetool::Data::Tree;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);
    
    @ISA    = qw(Exporter);
    @EXPORT = qw(&sitemap2graphviz);
}


sub graphviz_helper ($$)
{
    my $node_ref      = shift;
    my $output_handle = shift;

    assert(defined($node_ref));
    assert(defined($output_handle));

    my $node;
    $node = $$node_ref;

    my @children = $node->children();
#    debug("Children are \`@children' (" . ($#children + 1) . " children)");

    my $id;
    my $shape;

    $id = $node->id();
    if ($node->is_leaf()) {
	$shape = "box"; # "ellipse peripheries=2";
    } else {
	$shape = "ellipse"; # "ellipse peripheries=1";
    }
    print $output_handle
	"\t\"" . $id . "\" [shape=" . $shape . "];\n";

    for my $child_ref (@children) {
	assert(defined($child_ref));
#	debug("Child ref is \`$child_ref'");
	
	my $child = $$child_ref;
	print $output_handle
	    "\t\"" . $id . "\" -- \"" . $child->id() . "\";\n";
	if (!&graphviz_helper($child_ref, $output_handle)) {
	    error("Cannot dump node "        . 
		  "\`" . $child->id() . "' " .
		  "graphviz structure");
	    return 0;
	}
    }

    return 1;
}

sub sitemap2graphviz ($$)
{
    my $input_filename   = shift;
    my $output_filename  = shift;

    assert(defined($input_filename));
    assert(defined($output_filename));

    debug("Creating graphviz");

    my $string;

    debug("Reading sitemap from \`" . $input_filename . "'");
    $string = "";
    if (!file_tostring($input_filename, \$string)) {
	return 0;
    }

    my $tree_ref;
    
    debug("Cross your fingers, we're starting evaluation");

    # XXX FIXME: We should use the former version of 'eval' ...
    #eval {
    #	no warnings 'all';
    #	$string;
    #};
    eval $string;
    if ($@) {
	debug("Evaluation returned `" . $@ . "'");
	error("Bad configuration frozen in \`" . $input_filename . "' ($@)");
	return 0;
    }

    assert(defined($tree_ref));

    my $output_filehandle;
    if (!open($output_filehandle, ">" , $output_filename)) {
	error("Cannot open file \`" . $output_filename . "' for writing");
	return 0;
    }
    assert(defined($output_filehandle));

    print $output_filehandle "graph sitemap {\n";
    print $output_filehandle "\toverlap=scale;\n";
    print $output_filehandle "\tsplines=true;\n";
    if (!graphviz_helper($tree_ref, $output_filehandle)) {
	close($output_filehandle);
	file_remove($output_filehandle);
	return 0;
    }
    print $output_filehandle "}\n";

    close($output_filehandle);

    return 1;
}

1;
