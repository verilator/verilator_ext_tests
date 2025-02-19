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
            os.path.abspath(test.t_dir + "/../submodules/Cores-VeeR-EL2"))
test.setenv('VERILATOR', os.environ["VERILATOR_ROOT"] + "/bin/verilator")


test.run(
    cmd=[
        "make -j4 -C " + test.obj_dir + " -f " + os.environ["RV_ROOT"] +
        "/tools/Makefile",
        ("VERILATOR='" + os.environ["VERILATOR"] +
         " --debug-check -Wno-IMPLICITSTATIC --stats --timing " +
         ' '.join(test.driver_verilator_flags) + "'"),
        "CONF_PARAMS=-iccm_enable=1",
        "GCC_PREFIX=none TEST=cmark_iccm",
        "VERILATOR_MAKE_FLAGS=VM_PARALLEL_BUILDS=1 verilator CFG_CXXFLAGS_WEXTRA=-Wextra"
    ],
    logfile=test.obj_dir + "/sim.log")

test.file_grep(test.obj_dir + "/sim.log", r'\nTEST_PASSED\n')

test.passes()
