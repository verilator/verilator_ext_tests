#*****************************************************************************
# DESCRIPTION: Verilator external tests: Top Makefile
#
# This file is part of the Verilator external tests package.
#
#*****************************************************************************
#
# Copyright 2019-2023 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
#
# Verilator is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
#****************************************************************************/
# Please see docs/README.md for most information.
#
# make test
#      To run all tests
# make clean  or  make mostlyclean
#      Delete all files from the current directory that are normally
#      created by building the tests.
#****************************************************************************/

default:
	@echo See docs/README.md for information on using these tests.

######################################################################

DRIVER_FLAGS ?= -j 0 --quiet --rerun
SCENARIOS ?= --vlt --vltmt --dist

test:
	t/vltest_bootstrap.py $(DRIVER_FLAGS) $(SCENARIOS) t/t_*.py

######################################################################

git-update git-pull pull:
	git pull
	git submodule update --remote --merge

######################################################################

git-clean:
	git clean -xfd
	git submodule foreach git clean -xfd

clean mostlyclean distclean maintainer-clean::
	rm -rf */obj_*
	rm -rf obj_*
	for p in submodules/* ; do \
	   test -e $$p/Makefile && $(MAKE) -C $$p --no-print-directory clean ; \
	done
