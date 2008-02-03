#
# Pagemap.pm
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

package Sitetool::Pagemap;

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
use Sitetool::WWW::HREF;
use Sitetool::OS::File;
use Sitetool::OS::Filename;
use Sitetool::OS::String;
use Sitetool::Tree;
use Sitetool::Scheme;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);
    
    @ISA    = qw(Exporter);
    @EXPORT = qw(&pagemap_create);
}

sub tree_dump ($$$)
{
    my $tree_ref = shift;
    my $node_ref = shift;
    my $level    = shift;
 
    assert(defined($tree_ref));
    assert(defined($node_ref));
    assert(defined($level));

    my $tree;
    $tree = ${$tree_ref};
    assert(defined($tree));

    my $node;
    $node = ${$node_ref};
    assert(defined($node));

    debug("Handling sub-tree generation for node \`" . $tree->id() . "'");
    
    my $string;
    $string = "";

    my $id;
    my $title;
    my $href;
    
    $id = $tree->id();
    assert(defined($id));
    $title = $tree->data("title");
    assert(defined($title));
    $href = href_compute($node->data("href"), $tree->data("href"));
    assert(defined($href));
    
    if ($tree->is_leaf()) {
	
	#
	# The output the result
	#
	$string = $string                                             .
	    (" " x ($level * 2))                                      .
	    "('leaf "                                                 .
	    "(\"" . $id . "\" \"" . $title . "\" \"" . $href  . "\")" .
	    ")\n";
    } else {
	# A node must have some children
	assert($tree->children() >= 0);

	$string = $string                                                     .
	    (" " x ($level * 2))                                              .
	    "('node (\"" . $id . "\" \"" . $title . "\" \"" . $href . "\" (\n";

	$level++;
	for my $child_ref ($tree->children()) {
	    assert(defined($child_ref));

	    my $temp;
	    $temp = "";
	    
	    debug("Child is \`" . $child_ref . "'");
	    $temp = &tree_dump($child_ref, $node_ref, $level + 1);
	    if (!defined($temp)) {
		error("Cannot compute pagemap for tree " .
		      "\`" . ${$child_ref}->id() . "'");
		return undef;
	    }

	    $string = $string . $temp;
	}
	$level--;

	$string = $string        .
	    (" " x ($level * 2)) .
	    ")))\n";
    }

    return $string;
}

sub pagemap_create ($$$)
{
    my $sitemap_filename = shift;
    my $page_id          = shift;
    my $output_filename  = shift;

    assert(defined($sitemap_filename));
    assert(defined($page_id));
    assert(defined($output_filename));

    if (!file_ispresent($sitemap_filename)) {
	error("Cannot open file \`" . $sitemap_filename . "' for reading");
	return 0;
    }

    verbose("Creating pagemap for page \`" . $page_id . "'");

    my $dumped;
    $dumped = "";
    if (!file_tostring($sitemap_filename, \$dumped)) {
	return 0;
    }

    my $tree_ref;

    # XXX FIXME: We should use the former version of 'eval' ...
    #eval {
    #	no warnings 'all';
    #	$dumped;
    #};
    eval $dumped;
    if ($@) {
	debug("Evaluation returned `" . $@ . "'");
	error("Bad data in \`" . $sitemap_filename . "'");
	return 0;
    }

    my $tree = $$tree_ref;

    #
    # XXX FIXME:
    #     Using relink() is really a nasty fix, please remove it ASAP
    #

    if (!$tree->relink()) {
	return 0;
    }
    
    debug("Checking if page \`" . $page_id . "' is in site map");

    my $page_node_ref;
    $page_node_ref = $tree->find($page_id);
    if (!defined($page_node_ref)) {
	error("Page "                       .
	      "\`" . $page_id . "' "        .
	      "is not in map "              .
	      "\'" . $sitemap_filename . "'");
	return 0;
    }
    debug("Page node ref is \`" . $page_node_ref . "'");

    my $page_node;
    $page_node = ${$page_node_ref};

    debug("Page node is \`" . $page_node->id() . "'");

    debug("Computing pagemap for page \`" . $page_id . "'");

    my $string;

    $string = tree_dump(\$tree, \$page_node, 1);
    if (!defined($string)) {
        error("Cannot build pagemap for page \`" . $page_id . "'");
        return 0;
    }

#    $string = "(define page-map `(\"" . $page_id . "\"\n" . $string . "))\n";
    $string = "(\"" . $page_id . "\"\n" . $string . ")\n";
    
    $string = scheme_indent($string);
    assert(defined($string));

    if (!string_tofile($string, $output_filename)) {
	return 0;
    }

    return 1;
}

1;
