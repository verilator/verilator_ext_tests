#!/usr/bin/env python3
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2024 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

import vltest_bootstrap

test.scenarios('simulator')
test.top_filename = "t/t_math_synmul.v"

cycles = 100
test.sim_time = cycles * 100

test.compile(v_flags2=[
    "+define+SIM_CYCLES=" + str(cycles), "--stats", "-Wno-UNOPTTHREADS"
], )

test.execute(check_finished=True)

test.passes()
