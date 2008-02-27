#
# Sitemap.pm
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

package Sitetool::Sitemap;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Cwd;

use Sitetool::Autoconfig;
use Sitetool::Base::Trace;
use Sitetool::Base::Debug;
use Sitetool::OS::File;
use Sitetool::OS::Filename;
use Sitetool::OS::String;
#use Sitetool::OS::Directory;
use Sitetool::Data::Tree;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);
    
    @ISA    = qw(Exporter);
    @EXPORT = qw(&sitemap_create);
}

#sub tree_create ($$$$)
#{
#    my $tree           = shift;
#    my $directory      = shift;
#    my $exclusions_ref = shift;
#    my $level          = shift;
#
#    assert(defined($tree));
#    assert(defined($directory));
#
#    my $prefix;
#    $prefix = "  " x ($level + 1);
#
#    debug($prefix . "Working on node \`" . $tree->id() . "'");
#
#    my $wd;
#    $wd = cwd;
#
#    if (!directory_is_present($directory)) {
#	error("Cannot open directory \`" . $directory . "'");
#	return 0;
#    }
#
#    debug($prefix . "Working on directory \`" . $directory . "'");
#    if (!chdir($directory)) {
#	error("Cannot change directory to \`" . $directory . "'");
#	return 0;
#    }
#
#    my @items;
#    @items = directory_items($directory, $exclusions_ref, $level);
#    debug($prefix . "Directory items are `@items'");
#
#    $level++;
#
#    my $i = 0;
#    for my $item (sort(@items)) {
#	debug($prefix . "Working on directory item \`" . $item . "'");
#
#	my $child;
#	$child = Sitetool::Data::Tree->new("");
#	assert(defined($child));
#	
#	$child->parent(\$tree);
#	$child->data("href", $item);
#	
#	$tree->child($i, \$child);
#	$i++;
#
#	if (directory_ispresent($item)) {
#	    debug($prefix . "Item \`" . $item . "' is a directory");
#
#	    if (!&tree_create($child, $item, $exclusions_ref, $level)) {
#		return 0;
#	    }
#
#	    if (!$child->rename("")) {
#		bug("A tree node cannot be renamed");
#	    }
#
#	    $child->data("type", "directory");
#	    $child->data("href", $item);
#	} elsif (file_ispresent($item)) {
#	    debug($prefix . "Item \`" . $item . "' is a file");
#
#	    my $page_id;
#	    if (!file_tostring($item, \$page_id)) {
#		error("Cannot read page id from file \`" . $item . "'");
#		return 0;
#	    }
#	    assert(defined($page_id));
#
#	    if (!$child->rename($page_id)) {
#		bug("A tree node cannot be renamed");
#	    }
#
#	    $child->data("type", "file");
#	    $child->data("href", $item);
#	} else {
#	    error("Unknown item \`" . $item . "' type");
#	    return 0;
#	}
#    }
#
#    debug($prefix . "Changing current directory back to \`" . $wd . "'");
#    if (!chdir($wd)) {
#	error("Cannot change directory to \`" . $wd . "'");
#	return 0;
#    }
#
#    return 1;
#}

#sub sitemap_create ($$$$)
#{    
#    my $configuration_ref  = shift;
#    my $input_directory    = shift;
#    my $exclusions_ref     = shift;
#    my $output_file        = shift;
#
#    assert(defined($configuration_ref));
#    assert(defined($input_directory));
#    assert(defined($exclusions_ref));
#    assert(defined($output_file));
#
#    debug("Creating sitemap");
#
#    my %configuration;
#    %configuration = %{ $configuration_ref };
#
#    my @exclusions;
#    @exclusions    = @{ $exclusions_ref };
#
#    #
#    # Create starting data structure
#    #
#    debug("Creating tree for \`$input_directory'");
#    my $tree;
#    $tree = Sitetool::Data::Tree->new("");
#    $tree->data("type", "directory");
#    $tree->data("href", ".");
#    if (!tree_create($tree, $input_directory, \@exclusions, 0)) {
#	error("Cannot create sitemap");
#	return 0;
#    }
#
#    #
#    # Write output to file
#    #
#    debug("Writing output to file \`$output_file'");
#    my $output_handle;
#    if (!open($output_handle, ">", $output_file)) {
#	error("Cannot open \`$output_file' for output");
#	return 0;
#    }
#    print $output_handle Data::Dumper->Dump([\$tree],[qw(tree_ref)]);
#    close($output_handle);
#    
#    return 1;
#}

my %sitemap_tree_check_helper_hash = ();

sub sitemap_tree_check_helper ($)
{
    my $node_ref = shift;
    
    assert(defined($node_ref));
    
    my $node;
    $node = ${$node_ref};

    assert(defined($node));

    if (defined($sitemap_tree_check_helper_hash{$node->id()})) {
	$sitemap_tree_check_helper_hash{$node->id()}++;
    } else {
	$sitemap_tree_check_helper_hash{$node->id()} = 1;
    }
}

sub sitemap_tree_check ($)
{
    my $tree_ref = shift;

    assert(defined($tree_ref));
    
    my $tree;
    $tree = ${$tree_ref};

    assert(defined($tree));

    $tree->foreach(\&sitemap_tree_check_helper);

    for my $key (keys(%sitemap_tree_check_helper_hash)) {
	my $count;

	$count = $sitemap_tree_check_helper_hash{$key};
	if ($count != 1) {
	    error("Wrong data for page \`" . $key . "' (" . $count ." count)");
	    return 0;
	}
    }

    return 1;
}


sub sitemap_create_check ($)
{
    my $configuration_ref = shift;

    assert(defined($configuration_ref));

    my %configuration;
    %configuration = %{ $configuration_ref };

    # Check map cross-linking
    for my $page_id (keys(%{$configuration{MAP}})) {
	assert(defined($page_id));

	if ($page_id eq "") {
	    error("A page id is empty ...");
	    return 0;
	}

	if (!defined($configuration{PAGES}{$page_id}{DESTINATION})) {
	    error("Page \`" . $page_id . "' is defined only in the map");
	    return 0;
	}
    }

    return 1;
}   

sub sitemap_create_prepare ($)
{
    my $configuration_ref = shift;
    
    assert(defined($configuration_ref));

    my %configuration;
    %configuration = %{ $configuration_ref };
    
    # Check map consistency
    for my $page_id (keys(%{$configuration{MAP}})) {
	assert(defined($page_id));
	assert($page_id ne "");
	
	$configuration{MAP}{$page_id}{LINKED} = 0;
    }

    return 1;
}

sub sitemap_create_cleanup ($)
{
    my $configuration_ref = shift;

    assert(defined($configuration_ref));

    my %configuration;
    %configuration = %{ $configuration_ref };

    for my $page_id (keys(%{$configuration{MAP}})) {
	assert(defined($page_id));

	delete($configuration{MAP}{$page_id}{LINKED});
    }
    
    return 1;
}

sub sitemap_create_helper ($$)
{
    my $configuration_ref  = shift;
    my $output_file        = shift;

    assert(defined($configuration_ref));
    assert(defined($output_file));

    my %configuration;
    %configuration = %{ $configuration_ref };

    #
    # NOTE:
    #     On enter we are assured that:
    #       All page ids are defined and not equal to ""
    #       All pages are not linked
    #
    
    my $tree;
    
    # Create the root node
    $tree = Sitetool::Data::Tree->new("");
    if (!defined($tree)) {
	error("Cannot create root for tree");
	return 0;
    }
    $tree->parent(undef);
    $tree->data("href",  ".");
    $tree->data("title", "");

    # Link all fatherless children to the root
    debug("Linking orphaned pages");
    for my $page_id (keys(%{$configuration{MAP}})) {
	if (defined($configuration{MAP}{$page_id}{PARENT})) {
	    next;
	}
	
	warning("Page \`" . $page_id . "' is orphan, adopted now by root");
	    
	my $node;
	$node = Sitetool::Data::Tree->new($page_id);
	if (!defined($node)) {
	    error("Cannot create tree node for page \`" . $page_id . "'");
	    return 0;
	}

	if (!defined($configuration{PAGES}{$page_id})) {
	    error("Page \`" . $page_id . "' " .
		  "is defined inside the sitemap but not as a page");
	    return 0;
	}

	$node->parent(\$tree);

	my @children = $tree->children();
	$tree->child($#children + 1, \$node);

	$configuration{MAP}{$page_id}{LINKED} = 1;
	debug("Page \`" . $page_id . "' has been linked")
    }

    debug("Linking remaining pages");
    my $previous_not_linked;
    my $not_linked;

    $previous_not_linked = -1;
    $not_linked          = -1;
    do  {
	debug("Loop (" . $previous_not_linked . "," . $not_linked . ")");

	for my $page_id (keys(%{$configuration{MAP}})) {
	    if ($configuration{MAP}{$page_id}{LINKED}) {
		next;
	    }
	    
	    my $parent_id;
	    
	    $parent_id = $configuration{MAP}{$page_id}{PARENT};
	    assert(defined($parent_id));
	    
	    debug("Linking page "             .
		  "\`" . $page_id   . "' to " .
		  "\`" . $parent_id . "'");
	    
	    my $parent_ref;
	    $parent_ref = $tree->find($parent_id);
	    if (!defined($parent_ref)) {
		debug("Parent for node "     .
		      "\`" . $page_id . "' " .
		      "not yet available");
		next;
	    }

	    debug("Parent reference is \`" . $parent_ref . "'");

	    my $parent;
	    $parent = ${$parent_ref};

	    assert($parent_id eq $parent->id());

	    debug("Parent for node "          . 
		  "\`" . $page_id . "' "      . 
		  "should be "                . 
		  "\`" . $parent->id() . "'");

	    my $node;
	    $node = Sitetool::Data::Tree->new($page_id);
	    if (!defined($node)) {
		error("Cannot create tree node for page " .
		      "\`" . $page_id . "'");
		return 0;
	    }
	    
	    $node->parent(\$parent);
	    
	    my @children = $parent->children();
	    $parent->child($#children + 1, \$node);
	    
	    $configuration{MAP}{$page_id}{LINKED} = 1;
	}

	$previous_not_linked = $not_linked;
	$not_linked          = 0;
	for my $page_id (keys(%{$configuration{MAP}})) {
	    if (!$configuration{MAP}{$page_id}{LINKED}) {
		debug("Page \`" . $page_id . "' needs to be linked");
		$not_linked++;
	    }
	}
	debug("There are " . $not_linked . " not linked nodes yet");

	# Avoid loops
	assert($previous_not_linked != $not_linked);

    } while ($not_linked != 0);

    debug("All nodes linked successfully");

    debug("Filling node infos");
    for my $page_id (keys(%{$configuration{MAP}})) {

	my $node_ref;
	$node_ref = $tree->find($page_id);
	assert(defined($node_ref));

	my $node;
	$node = ${$node_ref};

	my $href = $configuration{PAGES}{$page_id}{DESTINATION};
	assert(defined($href));
	my $title = $configuration{PAGES}{$page_id}{VARS}{TITLE};
	assert(defined($title));
	
	$node->data("href",  $href);
	$node->data("title", $title);
    }
    debug("All nodes filled with proper infos");

    $tree->pack();

    if (!sitemap_tree_check(\$tree)) {
	error("Bad sitemap");
	return 0;
    }

    #
    # Prepare the output
    #
    my $string;

    $string = Data::Dumper->Dump([\$tree],[qw(tree_ref)]);
    assert(defined($string));

    #
    # Write output to file
    #
    if (!string_tofile($string, $output_file)) {
	return 0;
    }

    return 1;
}

sub sitemap_create ($$)
{
    my $configuration_ref = shift;
    my $output_file       = shift;

    assert(defined($configuration_ref));
    assert(defined($output_file));

    #
    # NOTE:
    #    Sitemap creation is a N stage procedure. The first and last stages
    #    are performed separately in order to avoid running
    #    sitemap_create_cleanup on every error ...
    #

    if (!sitemap_create_check($configuration_ref)) {
	return 0;
    }
    if (!sitemap_create_prepare($configuration_ref)) {
	return 0;
    }

    my $retval;

    # The real work ...
    $retval = sitemap_create_helper($configuration_ref, $output_file);

    if (!sitemap_create_cleanup($configuration_ref)) {
	return 0;
    }

    return ($retval ? 1 : 0);
}

1;
