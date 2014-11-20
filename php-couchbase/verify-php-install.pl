#!/usr/bin/perl
use strict;
use warnings;

sub uninstall_couchbase_php() {
	my $run_command = "pecl uninstall couchbase";
	my $out = `$run_command`;
	if (index($out,"Successfully uninstalled") != -1) {
		print "Uninstalled existing php couchbase\n";
		return;
	}
	if (index($out, "not installed") != -1) {
		print "No couchbase php couchbase\n";
		return;
	}
	die "Error uninstalling ".$run_command." \n"
} 

sub install_couchbase_php() {
	my $run_command = "pecl install couchbase";
	my $out = `$run_command`;

	if (index($out, "Successfully installed") != -1) {
		print "Installed php couchbase\n";
	} else {
		die "Failed to install\n";
	}
}

# Uninstall any existing versions
uninstall_couchbase_php();

install_couchbase_php();


