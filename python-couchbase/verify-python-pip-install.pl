#!/usr/bin/perl
use strict;
use warnings;

sub uninstall_couchbase_python() {
	my $run_command = "pip uninstall couchbase";
	my $out = `$run_command`;
	if (index($out,"Successfully uninstalled") != -1) {
		print "Uninstalled existing python\n";
		return;
	}
	if (index($out, "not installed") != -1) {
		print "No couchbase python installed\n";
		return;
	}
	die "Error uninstalling ".$run_command." \n"
} 

sub install_couchbase_python() {
	my $run_command = "pip install couchbase";
	my $out = `$run_command`;

	if (index($out, "Successfully installed") != -1) {
		print "Installed python\n";
	} else {
		die "Failed to install\n";
	}
}

# Uninstall any existing versions
uninstall_couchbase_python();

install_couchbase_python();
