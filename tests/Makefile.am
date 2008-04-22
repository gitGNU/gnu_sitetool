##
## Input file for automake
##
## Copyright (C) 2007, 2008 Francesco Salvestrini
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License along
## with this program; if not, write to the Free Software Foundation, Inc.,
## 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
##

include $(top_srcdir)/Makefile.sub

CLEANFILES =
EXTRA_DIST =

SUBDIRS =					\
	data

##
## NOTE:
##     In order to debug the tests during the 'distcheck' target use the
##     following TESTS_ENVIRONMENT:
##
##       TESTS_ENVIRONMENT = testdir=@abs_builddir@ DEBUG=x VERBOSE=x
##
TESTS_ENVIRONMENT = testdir=@abs_builddir@

scripts =					\
	wrapper					\
	defs

all-local: $(scripts)

# wrapper
wrapper: $(srcdir)/wrapper.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/wrapper.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
CLEANFILES += wrapper
EXTRA_DIST += wrapper.in

##
## NOTE:
##   defs should not be made executable because it should be only included by
##   test-cases
##

# defs
defs: $(srcdir)/defs.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/defs.in > $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
CLEANFILES += defs
EXTRA_DIST += defs.in

# Tests
FAIL_TESTS    =
SUCCESS_TESTS =

FAIL_TESTS +=					\
	test-arguments-2			\
	test-arguments-5			\
	test-arguments-long-2			\
	test-fail				\
	test-options-short-3			\
	test-options-short-4			\
	test-options-long-3			\
	test-options-long-4			\
	test-options-abbr-3			\
	test-options-shortargs-3		\
	test-options-shortargs-4		\
	test-options-longargs-3			\
	test-options-longargs-4			\
	test-options-abbrargs-3			\
	test-options-abbrargs-4

SUCCESS_TESTS +=				\
	test-success				\
	test-arguments-1			\
	test-arguments-3			\
	test-arguments-4			\
	test-arguments-long-1			\
	test-arguments-multiple-1		\
	test-arguments-multiple-2		\
	test-arguments-auths			\
	test-arguments-build			\
	test-arguments-check			\
	test-arguments-clean			\
	test-arguments-digest			\
	test-arguments-initialize		\
	test-arguments-install			\
	test-arguments-parse			\
	test-arguments-preprocess		\
	test-arguments-uninstall		\
	test-arguments-validate			\
	test-dry-run				\
	test-helps				\
	test-initialize				\
	test-preprocess				\
	test-parse				\
	test-validate				\
	test-build				\
	test-options-short-1			\
	test-options-short-2			\
	test-options-long-1			\
	test-options-long-2			\
	test-options-abbr-1			\
	test-options-abbr-2			\
	test-options-shortargs-1		\
	test-options-shortargs-2		\
	test-options-longargs-1			\
	test-options-longargs-2			\
	test-options-abbrargs-1			\
	test-options-abbrargs-2			\
	test-options-multi-1			\
	test-options-multi-2			\
	test-options-multi-3			\
	test-options-multi-4			\
	test-options-multi-5			\
	test-options-multi-6			\
	test-options-multi-7			\
	test-options-multi-8


XFAIL_TESTS  = $(FAIL_TESTS)
TESTS        = $(FAIL_TESTS) $(SUCCESS_TESTS)

test-dry-run: $(srcdir)/test-dry-run.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-dry-run.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-dry-run.in
CLEANFILES += test-dry-run

test-success: $(srcdir)/test-success.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-success.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-success.in
CLEANFILES += test-success

test-fail: $(srcdir)/test-fail.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-fail.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-fail.in
CLEANFILES += test-fail

test-arguments-1: $(srcdir)/test-arguments-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-1.in
CLEANFILES += test-arguments-1

test-arguments-2: $(srcdir)/test-arguments-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-2.in
CLEANFILES += test-arguments-2

test-arguments-3: $(srcdir)/test-arguments-3.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-3.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-3.in
CLEANFILES += test-arguments-3

test-arguments-4: $(srcdir)/test-arguments-4.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-4.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-4.in
CLEANFILES += test-arguments-4

test-arguments-5: $(srcdir)/test-arguments-5.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-5.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-5.in
CLEANFILES += test-arguments-5

test-arguments-long-1: $(srcdir)/test-arguments-long-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-long-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-long-1.in
CLEANFILES += test-arguments-long-1

test-arguments-long-2: $(srcdir)/test-arguments-long-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-long-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-long-2.in
CLEANFILES += test-arguments-long-2

test-arguments-multiple-1: $(srcdir)/test-arguments-multiple-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-multiple-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-multiple-1.in
CLEANFILES += test-arguments-multiple-1

test-arguments-multiple-2: $(srcdir)/test-arguments-multiple-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-multiple-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-multiple-2.in
CLEANFILES += test-arguments-multiple-2

test-arguments-auths: $(srcdir)/test-arguments-auths.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-auths.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-auths.in
CLEANFILES += test-arguments-auths

test-arguments-build: $(srcdir)/test-arguments-build.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-build.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-build.in
CLEANFILES += test-arguments-build

test-arguments-check: $(srcdir)/test-arguments-check.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-check.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-check.in
CLEANFILES += test-arguments-check

test-arguments-clean: $(srcdir)/test-arguments-clean.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-clean.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-clean.in
CLEANFILES += test-arguments-clean

test-arguments-digest: $(srcdir)/test-arguments-digest.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-digest.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-digest.in
CLEANFILES += test-arguments-digest

test-arguments-initialize: $(srcdir)/test-arguments-initialize.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-initialize.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-initialize.in
CLEANFILES += test-arguments-initialize

test-arguments-install: $(srcdir)/test-arguments-install.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-install.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-install.in
CLEANFILES += test-arguments-install

test-arguments-parse: $(srcdir)/test-arguments-parse.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-parse.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-parse.in
CLEANFILES += test-arguments-parse

test-arguments-preprocess: $(srcdir)/test-arguments-preprocess.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-preprocess.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-preprocess.in
CLEANFILES += test-arguments-preprocess

test-arguments-uninstall: $(srcdir)/test-arguments-uninstall.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-uninstall.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-uninstall.in
CLEANFILES += test-arguments-uninstall

test-arguments-validate: $(srcdir)/test-arguments-validate.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-arguments-validate.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-arguments-validate.in
CLEANFILES += test-arguments-validate

test-helps: $(srcdir)/test-helps.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-helps.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-helps.in
CLEANFILES += test-helps

test-initialize: $(srcdir)/test-initialize.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-initialize.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-initialize.in
CLEANFILES += test-initialize

test-preprocess: $(srcdir)/test-preprocess.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-preprocess.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-preprocess.in
CLEANFILES += test-preprocess

test-parse: $(srcdir)/test-parse.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-parse.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-parse.in
CLEANFILES += test-parse

test-build: $(srcdir)/test-build.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-build.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-build.in
CLEANFILES += test-build

test-validate: $(srcdir)/test-validate.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-validate.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-validate.in
CLEANFILES += test-validate

test-options-short-1: $(srcdir)/test-options-short-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-short-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-short-1.in
CLEANFILES += test-options-short-1

test-options-short-2: $(srcdir)/test-options-short-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-short-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-short-2.in
CLEANFILES += test-options-short-2

test-options-short-3: $(srcdir)/test-options-short-3.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-short-3.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-short-3.in
CLEANFILES += test-options-short-3

test-options-short-4: $(srcdir)/test-options-short-4.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-short-4.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-short-4.in
CLEANFILES += test-options-short-4

test-options-long-1: $(srcdir)/test-options-long-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-long-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-long-1.in
CLEANFILES += test-options-long-1

test-options-long-2: $(srcdir)/test-options-long-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-long-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-long-2.in
CLEANFILES += test-options-long-2

test-options-long-3: $(srcdir)/test-options-long-3.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-long-3.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-long-3.in
CLEANFILES += test-options-long-3

test-options-long-4: $(srcdir)/test-options-long-4.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-long-4.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-long-4.in
CLEANFILES += test-options-long-4

test-options-abbr-1: $(srcdir)/test-options-abbr-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-abbr-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-abbr-1.in
CLEANFILES += test-options-abbr-1

test-options-abbr-2: $(srcdir)/test-options-abbr-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-abbr-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-abbr-2.in
CLEANFILES += test-options-abbr-2

test-options-abbr-3: $(srcdir)/test-options-abbr-3.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-abbr-3.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-abbr-3.in
CLEANFILES += test-options-abbr-3

test-options-shortargs-1: $(srcdir)/test-options-shortargs-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-shortargs-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-shortargs-1.in
CLEANFILES += test-options-shortargs-1

test-options-shortargs-2: $(srcdir)/test-options-shortargs-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-shortargs-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-shortargs-2.in
CLEANFILES += test-options-shortargs-2

test-options-shortargs-3: $(srcdir)/test-options-shortargs-3.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-shortargs-3.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-shortargs-3.in
CLEANFILES += test-options-shortargs-3

test-options-shortargs-4: $(srcdir)/test-options-shortargs-4.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-shortargs-4.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-shortargs-4.in
CLEANFILES += test-options-shortargs-4

test-options-longargs-1: $(srcdir)/test-options-longargs-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-longargs-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-longargs-1.in
CLEANFILES += test-options-longargs-1

test-options-longargs-2: $(srcdir)/test-options-longargs-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-longargs-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-longargs-2.in
CLEANFILES += test-options-longargs-2

test-options-longargs-3: $(srcdir)/test-options-longargs-3.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-longargs-3.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-longargs-3.in
CLEANFILES += test-options-longargs-3

test-options-longargs-4: $(srcdir)/test-options-longargs-4.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-longargs-4.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-longargs-4.in
CLEANFILES += test-options-longargs-4

test-options-abbrargs-1: $(srcdir)/test-options-abbrargs-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-abbrargs-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-abbrargs-1.in
CLEANFILES += test-options-abbrargs-1

test-options-abbrargs-2: $(srcdir)/test-options-abbrargs-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-abbrargs-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-abbrargs-2.in
CLEANFILES += test-options-abbrargs-2

test-options-abbrargs-3: $(srcdir)/test-options-abbrargs-3.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-abbrargs-3.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-abbrargs-3.in
CLEANFILES += test-options-abbrargs-3

test-options-abbrargs-4: $(srcdir)/test-options-abbrargs-4.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-abbrargs-4.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-abbrargs-4.in
CLEANFILES += test-options-abbrargs-4

test-options-multi-1: $(srcdir)/test-options-multi-1.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-multi-1.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-multi-1.in
CLEANFILES += test-options-multi-1

test-options-multi-2: $(srcdir)/test-options-multi-2.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-multi-2.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-multi-2.in
CLEANFILES += test-options-multi-2

test-options-multi-3: $(srcdir)/test-options-multi-3.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-multi-3.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-multi-3.in
CLEANFILES += test-options-multi-3

test-options-multi-4: $(srcdir)/test-options-multi-4.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-multi-4.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-multi-4.in
CLEANFILES += test-options-multi-4

test-options-multi-5: $(srcdir)/test-options-multi-5.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-multi-5.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-multi-5.in
CLEANFILES += test-options-multi-5

test-options-multi-6: $(srcdir)/test-options-multi-6.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-multi-6.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-multi-6.in
CLEANFILES += test-options-multi-6

test-options-multi-7: $(srcdir)/test-options-multi-7.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-multi-7.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-multi-7.in
CLEANFILES += test-options-multi-7

test-options-multi-8: $(srcdir)/test-options-multi-8.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-options-multi-8.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
EXTRA_DIST += test-options-multi-8.in
CLEANFILES += test-options-multi-8

clean-local:
	rm -rf testSubDir-*
