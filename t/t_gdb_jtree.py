#!/usr/bin/env python3
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2024 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

import vltest_bootstrap
import sysconfig

test.scenarios('vlt')
test.top_filename = "t/t_dump.v"

out = test.run_capture("astsee_verilator -h 2>&1", check=False)
if 'usage:' not in out:
    test.skip("No astsee command installed")

out = test.run_capture("python -c 'import astsee' 2>&1", check=False)
if 'NotFoundError:' in out:
    test.skip("No astsee package file installed")

purelib = sysconfig.get_paths().get("purelib", "")
platlib = sysconfig.get_paths().get("platlib", "")
pythonpaths = [
    p for p in (purelib, platlib, test.getenv_def("PYTHONPATH")) if p
]
test.setenv("PYTHONPATH", os.pathsep.join(pythonpaths))

test.setenv(
    "VERILATOR_GDB", "gdb --return-child-result" +
    (" --batch-silent --quiet" if test.verbose else " --batch") +
    ' -init-eval-command "set auto-load no"' + " --command " +
    os.environ["VERILATOR_ROOT"] + "/src/.gdbinit" + " --command " +
    test.t_dir + "/t_gdb_jtree.gdb")

test.lint(v_flags=["--gdb", "--debug"])

test.passes()
