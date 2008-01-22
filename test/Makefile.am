##
## Input file for automake
##
## (C) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
##

include $(top_srcdir)/Makefile.sub

SUBDIRS = data

##
## NOTE:
##     In order to debug the tests during the 'distcheck' target use the 
##     following TESTS_ENVIRONMENT:
##     
##       TESTS_ENVIRONMENT = testdir=@abs_builddir@ DEBUG=x VERBOSE=x
##
TESTS_ENVIRONMENT =					\
	testdir=@abs_builddir@				\
	SITETOOL_BINARY_PATH="@abs_top_builddir@/src"	\
	SITETOOL_LIBRARY_PATH="@abs_top_builddir@/libs"	\
	SITETOOL_DATA_PATH="@abs_top_builddir@/data"

EXTRA_DIST =					\
	defs.in					\
	wrapper.in				\
	test-dry-run.in				\
	test-args.in				\
	test-build.in

check_SCRIPTS =					\
	defs					\
	wrapper

TESTS =						\
	test-dry-run				\
	test-args				\
	test-build

noinst_SCRIPTS = $(TESTS)
CLEANFILES = $(noinst_SCRIPTS) $(check_SCRIPTS)

defs: $(srcdir)/defs.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/defs.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

wrapper: $(srcdir)/wrapper.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/wrapper.in > $@.tmp && \
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

clean-local:
	rm -rf test-subDir*
