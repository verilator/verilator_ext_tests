#!/usr/bin/env python3
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2024 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

import vltest_bootstrap

test.scenarios('dist')


def check(a, b, basename):
    cmd = "diff -u " + a + "/" + basename + " " + b + "/" + basename + " 2>&1"
    if test.verbose:
        print("\t" + cmd)
    out = test.run_capture(cmd, check=False)
    if out != "":
        print(out)
        test.error_keep_going("Differences in " + basename)
        test.copy_if_golden(a + "/" + basename, b + "/" + basename)


if 'VERILATOR_TEST_UPSTREAM' not in os.environ:
    test.skip("Skipping due to no VERILATOR_TEST_UPSTREAM")

print(os.getcwd)
g = "submodules/gtkwave"
v = os.environ['VERILATOR_ROOT']

check(g + "/src/helpers", v + "/include/gtkwave", "wavealloca.h")
check(g + "/lib/libfst", v + "/include/gtkwave", "fastlz.h")
check(g + "/lib/libfst", v + "/include/gtkwave", "fastlz.c")
check(g + "/lib/libfst", v + "/include/gtkwave", "fstapi.h")
check(g + "/lib/libfst", v + "/include/gtkwave", "fstapi.c")
check(g + "/lib/libfst", v + "/include/gtkwave", "lz4.h")
check(g + "/lib/libfst", v + "/include/gtkwave", "lz4.c")

test.passes()
