#!/usr/bin/perl
# DESCRIPTION: Verilator: Verilog Test driver bootstrapper
#
# Copyright 2008 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

# This is exec'ed by every test that is run standalone (called from the
# shell as ./t_test_name.pl)

use FindBin;
use Cwd qw(chdir);

$ENV{VERILATOR_ROOT} or die "%Error: VERILATOR_ROOT required for site tests,";

$ENV{VERILATOR_TESTS_SITE} ||= '';
$ENV{VERILATOR_TESTS_SITE} .= ':' if $ENV{VERILATOR_TESTS_SITE};
$ENV{VERILATOR_TESTS_SITE} .= $FindBin::Bin;

my @args = @ARGV;
#chdir("$ENV{VERILATOR_ROOT}/test_regress");

@args = map { s!.*/!!; $_; } @args;

print "cd $ENV{PWD} && $ENV{VERILATOR_ROOT}/test_regress/driver.pl ",join(' ',@args),"\n";
exec("$ENV{VERILATOR_ROOT}/test_regress/driver.pl", @args);
die;
