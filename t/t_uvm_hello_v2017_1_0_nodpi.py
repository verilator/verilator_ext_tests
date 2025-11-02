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

if not os.path.exists(uvm_root):
    test.run(cmd=[
        "cd " + uvm_git +
        " && git worktree prune && git worktree add --detach " + uvm_root +
        " 2017-1.0"
    ])

test.compile(
    v_flags2=["+define+UVM_NO_DPI"],
    verilator_flags2=[
        "--binary -j 0 -Wall --dump-inputs",  #
        "-Wno-EOFNEWLINE",  # Temp - need to cleanup UVM repo
        "+incdir+" + uvm_root + "/src"
    ])

test.execute()

test.file_grep(test.run_log_filename, r'Hello World')

test.passes()
