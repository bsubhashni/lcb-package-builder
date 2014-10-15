#!/usr/bin/perl
use strict;
use warnings;

sub uninstall_couchbase_gem() {
	my $run_command = "gem uninstall couchbase";
	my $out = `$run_command`;
	if (index($out,"Successfully uninstalled") != -1) {
		print "Uninstalled existing ruby gem\n";
		return;
	}
	if (index($out, "not installed") != -1) {
		print "No couchbase gem installed\n";
		return;
	}
	die "Error uninstalling ".$run_command." \n"
} 

sub install_couchbase_gem() {
	my $run_command = "gem install couchbase";
	my $out = `$run_command`;

	if (index($out, "Successfully installed") != -1) {
		print "Installed ruby gem\n";
	} else {
		die "Failed to install\n";
	}
}

# Uninstall any existing versions
uninstall_couchbase_gem();

install_couchbase_gem();
