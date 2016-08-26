#!/usr/bin/perl -w
# -*- perl -*-

use Test::More;
#use Test::MockCommand record => 'commands.db';

my $list;

$list = `./bin/setup-storage -f t/setup-storage/01syntax-simple.txt -D"sda" -s -d`;
ok ($? == 0, "Config failed: simple");

#ok (-f "t/setup-storage/01syntax-disk-partitioned.txt");
#ok (-f "t/setup-storage/01syntax-raid1.txt");
#ok (-f "t/setup-storage/01syntax-cryptsetup.txt");
#ok (-f "t/setup-storage/01syntax-lvm.txt");

$list = `./bin/setup-storage -f t/setup-storage/01syntax-lvm.txt -D"sda sdb" -s -d`;
ok ($? == 0, "Config failed: lvm ");

#$list = `./bin/setup-storage -f t/setup-storage/01syntax-complex.txt -D"sda sdb" -s -d`;
#ok ($? == 0, "Config failed: complex");

done_testing();
