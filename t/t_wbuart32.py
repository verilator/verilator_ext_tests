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

test.run(cmd=[
    "make -C submodules/wbuart32", "VERILATOR='" +
    os.environ['VERILATOR_ROOT'] + "/bin/verilator --debug-check " +
    ' '.join(test.driver_verilator_flags) + "'", "test"
],
         logfile=test.obj_dir + "/sim.log")

test.file_grep(test.obj_dir + "/sim.log", r'PASS!')

# profiling:
#   (cd submodules/wbuart32/bench/cpp ; gprof linetest > gprof.log )

test.passes()
