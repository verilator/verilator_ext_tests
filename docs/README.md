[![Build Status](https://travis-ci.com/verilator/verilator_ext_tests.svg?branch=master)](https://travis-ci.com/verilator/verilator_ext_tests)

# Purpose

This project contains additional tests for Verilator. These are generally
tests that run for a long time, and/or use source code from other projects.

To file issues, etc, please see https://verilator.org.

# Usage

* Initial prep

    git submodule update

* Run an individual test:

    export VERILATOR_ROOT=location   # if your shell is bash
    setenv VERILATOR_ROOT location   # if your shell is csh
    t/t_a_hello.pl

* Automatically run these tests as part of normal Verilator "make test"

    export VERILATOR_ROOT=$VERILATOR_TESTS_SITE:`pwd`   # if your shell is bash
    setenv VERILATOR_ROOT $VERILATOR_TESTS_SITE:`pwd`   # if your shell is csh

* Cleanup

    make clean

# Adding additional tests

To add additional tests, add a t/t_{name}.pl file.  See the Verilator
internals documentation for instructions on the test file format.

To be accepted in this package, an external submodule tested here must:

* Be under an open source license.
* Be available as a git repository.
* Be self checking (potentially checked by the t/ script you write).
* Be Verilator lint clean (using lint_off pragmas in code is fine).
* Be willing to consider patches as needed (i.e. not a "dead project").
* Already run CI against a fixed version of Verilator

# License

Tests and submodules under this package may have different licenses, please
see the appropriate submodules.  As to this package itself it is under the
same license as Verilator:

Copyright 2019-2019 by Wilson Snyder.  This program is free software; you
can redistribute it and/or modify it under the terms of either the GNU
Lesser General Public License Version 3 or the Perl Artistic License
Version 2.0.
