#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# General Public License or the Perl Artistic License.

use File::Spec;

scenarios(vlt => 1);

$ENV{RV_ROOT} = File::Spec->rel2abs($Self->{t_dir}."/../submodules/Cores-SweRV");
$ENV{VERILATOR} = "$ENV{VERILATOR_ROOT}/bin/verilator";

if (!-r "$ENV{RV_ROOT}/configs/snapshots/default/defines.h") {
    run(cmd => ["cd $ENV{RV_ROOT} && $ENV{RV_ROOT}/configs/swerv.config -snapshot=mybuild"],
	logfile => "$Self->{obj_dir}/config.log",
	);
}

run(cmd => ["cp $ENV{RV_ROOT}/testbench/hex/cmark.data.hex $ENV{RV_ROOT}/data.hex"]);
run(cmd => ["cp $ENV{RV_ROOT}/testbench/hex/cmark.program.hex $ENV{RV_ROOT}/program.hex"]);

run(cmd => ["make -C submodules/Cores-SweRV -j 4 -f $ENV{RV_ROOT}/tools/Makefile"
	    ,"verilator VERILATOR=$ENV{VERILATOR} snapshot=mybuild"],
    logfile => "$Self->{obj_dir}/sim.log",
    );
    
file_grep("$Self->{obj_dir}/sim.log", qr/.*\nTEST_PASSED\n/is);

ok(1);
1;
