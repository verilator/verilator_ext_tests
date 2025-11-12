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

uvm_root = os.path.abspath(test.t_dir + "/../submodules/uvm-2017-1.0-vlt")

## Make uvm_pkg_all

e_filename = test.obj_dir + "/pp__" + test.name + "__all1.vpp"

test.run(
    cmd=[
        os.environ["VERILATOR_ROOT"] + "/bin/verilator",
        "--E --preproc-defines --no-preproc-comments ",  #
        "+define+UVM_NO_DPI",
        "+incdir+" + uvm_root + "/src",
        test.top_filename,
        "> " + e_filename,
    ],
    verilator_run=True)

packed_filename = test.obj_dir + "/pp__" + test.name + "__all2.vpp"

test.run(cmd=[
    os.environ["VERILATOR_ROOT"] + "/nodist/uvm_pkg_packer",
    "--test-name " + test.name,
    "--uvm-header-filename " + uvm_root + "/src/uvm_pkg.sv",  #
    "< " + e_filename,
    "> " + packed_filename,
])

test.copy_if_golden(
    packed_filename, os.environ["VERILATOR_ROOT"] +
    "/test_regress/t/uvm/uvm_pkg_all_v2017_1_0_nodpi.svh")

## Test

test.compile(
    v_flags2=["+define+UVM_NO_DPI"],
    verilator_flags2=[
        "--binary -j 0 -Wall --dump-inputs",  #
        "-Wno-EOFNEWLINE",  # Temp - need to cleanup UVM repo
        "+incdir+" + uvm_root + "/src",
    ])

test.execute()

test.file_grep(test.run_log_filename, r'Hello World')

test.passes()
