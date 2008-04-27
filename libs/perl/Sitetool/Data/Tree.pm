#
# Tree.pm
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

package Sitetool::Data::Tree;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Sitetool::Base::Debug;
use Sitetool::Base::Trace;

sub new ($$) {
    my $class = shift;
    my $id    = shift;

    assert(defined($class));
    assert(defined($id));

#    debug("CREATING node \`" . $id . "'");

    my $self          = {};

    $self->{ID}       = $id;
    $self->{PARENT}   = undef;
    $self->{CHILDREN} = [];
    $self->{DATA}     = {};

    debug("Tree node \`" . $id . "' created successfully");

    return bless($self, $class);
}

sub id ($) {
    my $self = shift;
    my $id   = shift;

    assert(defined($self));

    if (defined($id)) {
	$self->{ID} = $id;
    }

    return $self->{ID};
}

sub is_root ($) {
    my $self = shift;

    assert(defined($self));

    if (!defined($self->{PARENT})) {
	debug("Node \`" . $self->{ID} . "' is a tree root");
	return 1;
    }

    debug("Node \`" . $self->{ID} . "' is not a tree root");

    return 0;
}

sub is_leaf ($) {
    my $self = shift;

    assert(defined($self));

    my @children = $self->children($self);
    my $count    = $#children + 1;

    assert($count >= 0);

    if ($count == 0) {
	return 1;
    }

    return 0;
}

sub rename ($$) {
    my $self = shift;
    my $id   = shift;

    assert(defined($self));
    assert(defined($id));

    $self->{ID} = $id;

    return 1;
}

sub find ($$) {
    my $self = shift;
    my $id   = shift;

    assert(defined($self));
    assert(defined($id));

    debug("Finding node "           .
	  "\`" . $id . "' "         .
	  "into "                   .
	  "\`" . $self->{ID} . "' " .
	  "forest");

    if ($self->{ID} eq $id) {
	debug("Got it in the current node");
	return \$self;
    }

    debug("Children of node "              .
	  "\`" . $self->{ID} . "' "        .
	  "are "                           .
	  "\`" . @{$self->{CHILDREN}} . "'");

    for my $child_ref (@{$self->{CHILDREN}}) {
	debug("Child ref is \`" . $child_ref . "'");

	assert(defined($child_ref));
	assert(ref($child_ref) ne "");

	my $child;
	$child = ${$child_ref};

	debug("Working on "             .
	      "\`" . $self->{ID} . "' " .
	      "child "                  .
	      "\`" . $child->{ID} . "'");

	assert(defined($child));

	my $node_ref;
	$node_ref = $child->find($id);
	if (defined($node_ref)) {
	    debug("Got the node matching id \`" . $id . "'");

	    assert(${$node_ref}->{ID} eq $id);

	    return $node_ref;
	}
    }

    debug("Node "                   .
	  "\`" . $self->{ID} . "' " .
	  "has no child "           .
	  "\`" . $id . "' "         .
	  "in its forest");

    return undef;
}

sub pack ($) {
    my $self = shift;

    assert(defined($self));

    debug("Packing node \`" . $self->{ID} . "'");

    my @tmp = ();

    debug("Self children is \`" . $self->{CHILDREN} . "'");
    for my $child_ref (@{$self->{CHILDREN}}) {
	debug("Child ref is "                                  .
	      "\`"                                             .
	      (defined($child_ref) ? $child_ref : "undefined") .
	      "'");

	if (ref($child_ref)) {
	    assert(UNIVERSAL::isa(${$child_ref}, "Sitetool::Data::Tree"));

	    debug("Packed children are now \`@tmp'");
	    push(@tmp, $child_ref);

	    my $child;
	    $child = ${$child_ref};
	    $child->pack();

	} elsif (!defined($child_ref)) {
	    debug("Removing undefined child on node \`" . $self->{ID} . "'");
	} else {
	    bug("Wrong data structure");
	}
    }

    @{$self->{CHILDREN}} = @tmp;

    debug("Node \`" . $self->{ID} . "' packed");
}

sub child () {
    my $self     = shift;
    my $index    = shift;
    my $node_ref = shift;

    assert(defined($self));
    assert(defined($index));

    return $self->{CHILDREN}->[$index];
}

sub add_child ($$$) {
    my $self     = shift;
    my $index    = shift;
    my $node_ref = shift;

    assert(defined($self));
    assert(defined($index));
    assert(defined($node_ref));
    assert(ref($node_ref) ne "");
    assert(UNIVERSAL::isa(${$node_ref}, "Sitetool::Data::Tree"));

    $self->{CHILDREN}->[$index] = $node_ref;

    return 1;
}

sub remove_child ($$) {
    my $self     = shift;
    my $index    = shift;

    assert(defined($self));
    assert(defined($index));

    $self->{CHILDREN}->[$index] = undef;

    return 1;
}

sub children ($) {
    my $self = shift;

    assert(defined($self));

    return @{$self->{CHILDREN}};
}

sub root ($$) {
    my $self = shift;

    assert(defined($self));

    debug("Looking for \`" . $self->{ID} . "' root");

    if ($self->is_root()) {
	debug("Node \`" . $self->{ID} . "' is the root");
	return \$self;
    }

    debug("Node \`" . $self->{ID} . "' is not root, going back to parent ...");

    my $parent_ref;
    $parent_ref = $self->parent();
    assert(defined($parent_ref));

    debug("Parent ref is \`" . $parent_ref . "'");

    my $parent;
    $parent = ${$parent_ref};
    assert(defined($parent));

    debug("Parent is \`" . $parent->{ID} . "'");

    debug("Looking for root into \`" . $parent->{ID} . "'");
    return $parent->root();
}

sub parent () {
    my $self   = shift;
    my $parent = shift;

    assert(defined($self));

    if (defined($parent)) {
	debug("Passed parent is \`" . $parent . "'");

	assert(ref($parent) eq "REF");
	assert(UNIVERSAL::isa(${$parent}, "Sitetool::Data::Tree"));

	$self->{PARENT} = $parent;

	debug("Parent for node "                   .
	      "\`" . $self->{ID} . "' "            .
	      "is node "                           .
	      "\`" . ${$self->{PARENT}}->{ID} . "'");
    }

    if (defined($self->{PARENT})) {
	debug("Node "                    .
	      "\`" . $self->{ID} . "' "  .
	      "parent is "               .
	      "\`" . $self->{PARENT}. "'");
    }

    return $self->{PARENT};
}

sub data () {
    my $self  = shift;
    my $key   = shift;
    my $value = shift;

    assert(defined($self));
    assert(defined($key));

    if (defined($value)) {
	$self->{DATA}->{$key} = $value;
    }

    return $self->{DATA}->{$key};
}

sub foreach ($$) {
    my $self         = shift;
    my $callback_ref = shift;

    assert(defined($self));
    assert(defined($callback_ref));

    # Call the callback for this node
    debug("Calling callback "         .
	  "\`" . $callback_ref . "' " .
	  "for node "                 .
	  "\`" . $self->{ID}. "'");
    $callback_ref->(\$self);

    # And for all its children
    for my $child_ref (@{$self->{CHILDREN}}) {
	if (ref($child_ref)) {
	    assert(UNIVERSAL::isa(${$child_ref}, "Sitetool::Data::Tree"));

	    my $child;
	    $child = ${$child_ref};

	    $child->foreach($callback_ref);
	} elsif (!defined($child_ref)) {
	    debug("No child");
	} else {
	    bug("Unreacheable code");
	}
    }
}

sub relink ($$) {
    my $self = shift;

    assert(defined($self));

    debug("Relinking node \`" . $self->{ID} . "'");

    for my $child_ref (@{$self->{CHILDREN}}) {
	if (ref($child_ref)) {
	    assert(UNIVERSAL::isa(${$child_ref}, "Sitetool::Data::Tree"));

	    my $child;
	    $child = ${$child_ref};

	    $child->{PARENT} = \$self;
	    if (!$child->relink()) {
		return 0;
	    }
	}
    }

    return 1;
}

sub DESTROY {
    my $self = shift;

    assert(defined($self));

#    debug("DESTROYING node \`" . $self->{ID} . "'");
}

1;
