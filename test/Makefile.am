##
## Input file for automake
##
## (C) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
##

include $(top_srcdir)/Makefile.sub

SUBDIRS = data

EXTRA_DIST = test.in

noinst_SCRIPTS = test
CLEANFILES = $(noinst_SCRIPTS)

TESTS_ENVIRONMENT = \
	SITETOOL_BINARY_PATH="@abs_top_builddir@/src" \
	SITETOOL_LIBRARY_PATH="@abs_top_builddir@/libs" \
	SITETOOL_DATA_PATH="@abs_top_builddir@/data"

TESTS = test

test: $(srcdir)/test.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
