#!/usr/bin/perl

use strict;
use warnings;

my $logfile = "tcpdump100.log";
open(my $fh, '<', $logfile) or die "Could not open file '$logfile' $!";
my $ip6_connections = 0;
my %unique_macs;
my %mac_connections;
while (my $line = <$fh>) {
    chomp $line;
    if ($line =~ /IP6\s+([0-9a-f:.]+)\.\d+/i) {
        $ip6_connections++;
        if ($line =~ /([0-9a-f:]+)\.\d+/i) {
            my $mac = $1;
            $unique_macs{$mac}++;
        }
    }
}
close($fh);
print "IP6 Connections: $ip6_connections\n";
my $machine_count = scalar(keys %unique_macs);
print "Machine Count: $machine_count\n";
foreach my $mac (keys %unique_macs) {
    my $count = $unique_macs{$mac};
    $mac_connections{$mac} = $count;
}
print "Connections:\n";
foreach my $mac (keys %mac_connections) {
    my $count = $mac_connections{$mac};
    print " $count\t$mac\n";
}

