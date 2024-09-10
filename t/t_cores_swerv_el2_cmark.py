#!/usr/bin/env python3
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2024 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

import vltest_bootstrap

test.scenarios('vlt')

test.setenv('RV_ROOT',
            os.path.abspath(test.t_dir + "/../submodules/Cores-SweRV-EL2"))
test.setenv('VERILATOR', os.environ["VERILATOR_ROOT"] + "/bin/verilator")

# Find compiler flag needed
fc = test.file_contents(os.environ["VERILATOR_ROOT"] + "/include/verilated.mk")
m = re.search(r'CFG_CXXFLAGS_STD_NEWEST = (\S+)', fc)
if not m:
    test.error("Couldn't determine CFG_CXXFLAGS_STD_NEWEST")
CFG_CXXFLAGS_STD_NEWEST = m.group(1)

# This will run the canned CoreMark (even if you have a riscv64-unknown-elf
# toolchain on your path), from ICCM but otherwise using the default core
# configuration. Running from ICCM is faster and hopefully more exciting.
# Note the build happens in test.obj_dir as the SweRV build system can
# find everything via RV_ROOT. This leaves the submodule clean.
test.run(
    cmd=[
        "make -j4 -C " + test.obj_dir + " -f " + os.environ["RV_ROOT"] +
        "/tools/Makefile",
        "VERILATOR='" + os.environ["VERILATOR"] +
        " --debug-check -Wno-IMPLICITSTATIC " +
        ' '.join(test.driver_verilator_flags),
        "'",
        # Because Cores-SweRV-EH2/tools/Makefile has -std=c++11 which is too old
        # Unfortunately it's too late in the Makefile to pass in VERILATOR above
        "VERILATOR_DEBUG='-CFLAGS " + CFG_CXXFLAGS_STD_NEWEST + "'",  #
        "CONF_PARAMS=-iccm_enable=1",  #
        "GCC_PREFIX=none TEST=cmark_iccm",  #
        "VERILATOR_MAKE_FLAGS=VM_PARALLEL_BUILDS=1 verilator"
    ],  #
    logfile=test.obj_dir + "/sim.log")

test.file_grep(test.obj_dir + "/sim.log", r'\nTEST_PASSED\n')

test.passes()
