##
## Input file for automake
##
## (C) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
##

include $(top_srcdir)/Makefile.sub

SUBDIRS = data

EXTRA_DIST = test-build.in test-dry-run.in

noinst_SCRIPTS = $(TESTS)
CLEANFILES = $(noinst_SCRIPTS)

TESTS_ENVIRONMENT =					\
	SITETOOL_BINARY_PATH="@abs_top_builddir@/src"	\
	SITETOOL_LIBRARY_PATH="@abs_top_builddir@/libs"	\
	SITETOOL_DATA_PATH="@abs_top_builddir@/data"

TESTS =						\
	test-dry-run				\
	test-build

test-build: $(srcdir)/test-build.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-build.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

test-dry-run: $(srcdir)/test-dry-run.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-dry-run.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
