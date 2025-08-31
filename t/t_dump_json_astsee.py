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
test.top_filename = os.environ["VERILATOR_ROOT"] + "/test_regress/t/t_dump.v"

out = test.run_capture("astsee_verilator -h 2>&1", check=False)
if 'usage:' not in out:
    test.skip("No astsee installed")

test.lint(v_flags=["--lint-only --dump-tree-json"])

test.run(cmd=[
    "cd " + test.obj_dir + " && astsee_verilator *002*.json > astsee.log"
],
         logfile=test.obj_dir + "/astsee.log")

test.passes()
