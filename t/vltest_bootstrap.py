#!/usr/bin/env python3
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2024 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

import os
import re
import sys

if 'VERILATOR_ROOT' not in os.environ:
    sys.exit("%Error: setenv VERILATOR_ROOT required for site tests")

if 'VERILATOR_TESTS_SITE' not in os.environ:
    os.environ['VERILATOR_TESTS_SITE'] = ''
else:
    os.environ['VERILATOR_TESTS_SITE'] += ':'
os.environ['VERILATOR_TESTS_SITE'] += os.path.dirname(
    os.path.realpath(__file__))

os.environ['PWD'] = os.getcwd()
args = list(map(lambda arg: re.sub(r'.*/test_regress/', '', arg), sys.argv))
os.execl(os.environ['VERILATOR_ROOT'] + "/test_regress/driver.py",
         "--bootstrapped", *args)
