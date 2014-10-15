#!/usr/bin/perl
use strict;
use warnings;


#Install the dependies required by lcb-package - dh_make and dpkg-
my @deps = ("build-essential", "fakeroot", "devscripts", "dpkg-dev", "gnupg", "debhelper", "cowbuilder", "approx", "libgtest-dev", "rubygems", "libevent-dev" );

my $installedStr = "Status: install ok installed\n";

foreach (@deps) {
	my $command1 = "dpkg-query -s ".$_." 2>/dev/null";
	my $command2 = "grep Status";
	my $verifycommand = $command1."|".$command2;
	my $output = `$verifycommand`;
	print "DEBUG: ".$output;
	if ($output ne $installedStr) {
		my $updatecmd = `"echo couchbase | sudo -S apt-get install $_"`;
		print $updatecmd;	
	} 
}

