#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# General Public License or the Perl Artistic License.

use File::Spec;

scenarios(vlt => 1);

setenv('RV_ROOT', File::Spec->rel2abs($Self->{t_dir}."/../submodules/Cores-SweRV-EL2"));
setenv('VERILATOR', "$ENV{VERILATOR_ROOT}/bin/verilator");

# This will run the canned CoreMark (even if you have a riscv64-unknown-elf
# toolchain on your path), from ICCM but otherwise using the default core
# configuration. Running from ICCM is faster and hopefully more exciting.
# Note the build happens in $Self->{obj_dir} as the SweRV build system can
# find everything via RV_ROOT. This leaves the submodule clean.
run(cmd => ["make -j4 -C $Self->{obj_dir} -f $ENV{RV_ROOT}/tools/Makefile",
            "VERILATOR='$ENV{VERILATOR} --debug-check ".join(' ',$Self->driver_verilator_flags()),"'",
            "CONF_PARAMS=-iccm_enable=1",
            "GCC_PREFIX=none TEST=cmark_iccm",
            "VERILATOR_MAKE_FLAGS=VM_PARALLEL_BUILDS=1 verilator"],
    logfile => "$Self->{obj_dir}/sim.log",
    );

file_grep("$Self->{obj_dir}/sim.log", qr/.*\nTEST_PASSED\n/is);

ok(1);
1;
