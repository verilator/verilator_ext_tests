#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# General Public License or the Perl Artistic License.

scenarios(vlt => 1);

run(cmd => ["make -C submodules/wbuart32",
            "VERILATOR='$ENV{VERILATOR_ROOT}/bin/verilator --debug-check ".join(' ',$Self->driver_verilator_flags())."'",
            "test"],
    logfile => "$Self->{obj_dir}/sim.log",
    );

file_grep("$Self->{obj_dir}/sim.log", qr/.*\nPASS!\n.*\nPASS\n.*\nPASS!\n/is);

ok(1);
1;
