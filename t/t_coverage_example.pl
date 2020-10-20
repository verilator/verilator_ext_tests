#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# General Public License or the Perl Artistic License.

use File::Spec;

scenarios(vlt => 1);

setenv('VERILATOR', "$ENV{VERILATOR_ROOT}/bin/verilator");

run(cmd => ["make -j4 -C submodules/example-systemverilog"],
    logfile => "$Self->{obj_dir}/sim.log",
    );

file_grep("$Self->{obj_dir}/sim.log", qr/.*\n-- DONE --/is);

ok(1);
1;
