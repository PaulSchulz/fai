#!/usr/bin/perl -w
# -*- perl -*-

package FAI;
use Init;
use Volumes;
use Parser;
use Sizes;
use Commands;
use Fstab;
use Exec;

use Data::Dumper;

use Test::More;
#use Test::MockCommand record => 'commands.db';

##############################################################################
# Running 'setup-storage' and check syntax of example files

my $list;

$list = `./bin/setup-storage -f t/setup-storage/01syntax-simple.txt -D"sda" -s -d 2>&1`;
ok ($? == 0, "Configuration: simple");

$list = `./bin/setup-storage -f t/setup-storage/01syntax-raid1.txt -D"sda sdb" -s -d 2>&1`;
ok ($? == 0, "Configuration: raid1");

$list = `./bin/setup-storage -f t/setup-storage/01syntax-lvm.txt -D"sda sdb" -s -d 2>&1`;
ok ($? == 0, "Configuration: lvm ");

$list = `./bin/setup-storage -f t/setup-storage/01syntax-luks.txt -D"sda" -s -d 2>&1`;
ok ($? == 0, "Configuration: luks");

$list = `./bin/setup-storage -f t/setup-storage/01syntax-complex.txt -D"sda sdb" -s -d 2>&1`;
ok ($? == 0, "Configuration: complex");


##############################################################################
@FAI::disks = ["sda", "sdb"];

my $opt_f = "t/setup-storage/01syntax-simple.txt";
my $config_file;
ok (-f $opt_f);
open($config_file, $opt_f);

print STDERR &FAI::run_parser($config_file);
# &FAI::run_parser($config_file);
print STDERR &FAI::check_config();

&FAI::get_current_disks;
print Dumper \%FAI::current_config;

&FAI::compute_partition_sizes;
print STDERR Dumper(\%FAI::configs);
print STDERR Dumper(\%FAI::dev_children);

#&FAI::build_disk_commands;

done_testing();
