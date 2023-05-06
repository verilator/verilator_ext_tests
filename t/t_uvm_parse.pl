#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

use File::Spec;

scenarios(vlt => 1);

my $uvm_root = File::Spec->rel2abs($Self->{t_dir}."/../submodules/uvm");

lint(
    v_flags2 => ["+incdir+${uvm_root}/src",
                 "-Wno-IMPLICITSTATIC -Wno-PKGNODECL -Wno-RANDC -Wno-CONSTRAINTIGN",
                 "--debug-exit-uvm",
    ],
    );

ok(1);
1;
