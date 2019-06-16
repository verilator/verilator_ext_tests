#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# General Public License or the Perl Artistic License.

use File::Spec;

scenarios(vlt => 1);

$ENV{RV_ROOT} = File::Spec->rel2abs($Self->{t_dir}."/../submodules/swerv_eh1");
$ENV{VERILATOR} = "$ENV{VERILATOR_ROOT}/bin/verilator";

if (!-r "$ENV{RV_ROOT}/configs/snapshots/default/defines.h") {
    run(cmd => ["cd $ENV{RV_ROOT} && $ENV{RV_ROOT}/configs/swerv.config -snapshot=mybuild"],
	logfile => "$Self->{obj_dir}/config.log",
	);
}

run(cmd => ["make -C submodules/swerv_eh1 -j 4 -f $ENV{RV_ROOT}/tools/Makefile"
	    ,"verilator VERILATOR=$ENV{VERILATOR} snapshot=mybuild"],
    logfile => "$Self->{obj_dir}/compile.log",
    );
    
run(cmd => ["make -C submodules/swerv_eh1 -f $ENV{RV_ROOT}/tools/Makefile"
	    ,"verilator-run VERILATOR=$ENV{VERILATOR} snapshot=mybuild"],
    logfile => "$Self->{obj_dir}/sim.log",
    );
    
file_grep("$Self->{obj_dir}/sim.log", qr/.*\nHello World.*\nFinished.*\nEnd of sim\n/is);

ok(1);
1;
