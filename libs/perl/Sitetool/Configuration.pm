#
# Configuration.pm
#
# (C) 2007, 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

package Sitetool::Configuration;

use 5.8.0;

use warnings;
use strict;
use diagnostics;

use Data::Dumper;

use Sitetool::Autoconfig;
use Sitetool::Base::Debug;
use Sitetool::Base::Trace;
use Sitetool::OS::Shell;
use Sitetool::OS::File;
use Sitetool::OS::Filename;
use Sitetool::OS::String;
use Sitetool::Preprocess;
use Sitetool::Parse;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT);
    
    @ISA    = qw(Exporter);
    @EXPORT = qw(&configuration_freeze
		 &configuration_melt);
}

sub configuration_freeze ($$)
{
    my $configuration_ref = shift;
    my $output_filename   = shift;

    assert(defined($output_filename));
    assert($output_filename ne "");
    assert(defined($configuration_ref));

    if (!configuration_check($configuration_ref)) {
	return 0;
    }

    verbose("Freezing configuration in file \`" . $output_filename . "'");

    my %configuration;

    %configuration = %{ $configuration_ref };
    
    my $string;
    $string = Data::Dumper->Dump([ \%configuration ], [ qw(*configuration) ]);

    if (!string_tofile($string, $output_filename)) {
	return 0;
    }

    debug("Configuration frozen successfully");

    return 1;
}

sub configuration_check ($)
{
    my $configuration_ref = shift;

    assert(defined($configuration_ref));

    debug("Checking configuration");

    my %configuration;
    %configuration = %{ $configuration_ref };

    {
	my @keys;
	@keys = keys(%configuration);
	debug("Configuration keys are \`@keys'");
    }

    if (!defined($configuration{INTERNAL})) {
	error("Wrong freezed configuration file, internal data missing ...");
	return 0;
    }

    if (!defined($configuration{INTERNAL}{PACKAGE_NAME})) {
	error("Wrong freezed configuration file, name is missing ...");
	return 0;
    }

    debug("Configuration was freezed with package name " .
	  "\`" . $configuration{INTERNAL}{PACKAGE_NAME} . "'");
    if ($configuration{INTERNAL}{PACKAGE_NAME} ne 
	$Sitetool::Autoconfig::PACKAGE_NAME) {
	error("Configuration was freezed with a wrong package ...");
	return 0;
    }

    if (!defined($configuration{INTERNAL}{PACKAGE_VERSION})) {
	error("Wrong freezed configuration file, version is missing ...");
	return 0;
    }

    debug("Configuration was freezed with package version " .
	  "\`" . $configuration{INTERNAL}{PACKAGE_VERSION} . "'");
    if ($configuration{INTERNAL}{PACKAGE_VERSION} ne 
	$Sitetool::Autoconfig::PACKAGE_VERSION) {
	error("Configuration was freezed with package version "      .
	      "\`" . $configuration{INTERNAL}{PACKAGE_VERSION} . "'" .
	      ", this  is version "                                  .
	      "\`" . $Sitetool::Autoconfig::PACKAGE_VERSION . "' "   .
	      "...");
	return 0;
    }

    if (!defined($configuration{MAP})) {
	error("Missing MAP key in configuration");
	return 0;
    }
    if (!defined($configuration{FILES})) {
	error("Missing FILES key in configuration");
	return 0;
    }
    if (!defined($configuration{VARS})) {
	error("Missing VARS key in configuration");
	return 0;
    }
    if (!defined($configuration{COMMON})) {
	error("Missing COMMON key in configuration");
	return 0;
    }
    if (!defined($configuration{PAGES})) {
	error("Missing PAGES key in configuration");
	return 0;
    }
    if (!defined($configuration{CONTENTS})) {
	error("Missing CONTENTS key in configuration");
	return 0;
    }

    debug("Configuration seems correct");

    return 1;
}

sub configuration_melt ($$)
{
    my $input_filename    = shift;
    my $configuration_ref = shift;

    assert(defined($input_filename));
    assert($input_filename ne "");

    verbose("Melting configuration from file \`" . $input_filename . "'");

    my %configuration;
    my $string;

    if (!file_tostring($input_filename, \$string)) {
	return 0;
    }
    
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

    if (!configuration_check(\%configuration)) {
	return 0;
    }

    debug("Configuration melted successfully");

    %{ $configuration_ref } = %configuration;
    
    return 1;
}

1;
