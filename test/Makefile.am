##
## Input file for automake
##
## (C) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
##

include $(top_srcdir)/Makefile.sub

SUBDIRS = data

noinst_SCRIPTS = $(TESTS)
CLEANFILES = $(noinst_SCRIPTS)

TESTS_ENVIRONMENT =					\
	SITETOOL_BINARY_PATH="@abs_top_builddir@/src"	\
	SITETOOL_LIBRARY_PATH="@abs_top_builddir@/libs"	\
	SITETOOL_DATA_PATH="@abs_top_builddir@/data"

EXTRA_DIST =					\
	test-dry-run.in				\
	test-args.in				\
	test-build.in

TESTS =						\
	test-dry-run				\
	test-args				\
	test-build

test-dry-run: $(srcdir)/test-dry-run.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-dry-run.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

test-args: $(srcdir)/test-args.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-args.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

test-build: $(srcdir)/test-build.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-build.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

