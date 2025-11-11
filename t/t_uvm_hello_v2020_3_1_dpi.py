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
test.top_filename = "t/t_uvm_hello.v"

uvm_git = os.path.abspath(test.t_dir + "/../submodules/uvm")
uvm_root = os.path.abspath(test.obj_dir + "/uvm-worktree")

test.pli_filename = uvm_root + "/src/dpi/uvm_dpi.cc"

if not os.path.exists(uvm_root):
    test.run(cmd=[
        "cd " + uvm_git +
        " && git worktree prune && git worktree add --detach " + uvm_root +
        " origin/uvm-2020-3.1-vlt"
    ])

## Test

test.compile(verilator_flags2=[
    "--binary -j 0 -Wall --dump-inputs",  #
    "--vpi",  #
    "+incdir+" + uvm_root + "/src",
    test.pli_filename,
])

test.execute()

test.file_grep(test.run_log_filename, r'Hello World')

test.passes()
