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
	test-helps.in				\
	test-initialize.in			\
	test-preprocess.in			\
	test-parse.in				\
	test-validate.in			\
	test-build.in

check_SCRIPTS =					\
	defs					\
	wrapper

TESTS =						\
	test-dry-run				\
	test-args				\
	test-helps				\
	test-initialize				\
	test-preprocess				\
	test-parse				\
	test-validate				\
	test-build

noinst_SCRIPTS = $(TESTS)
CLEANFILES = $(noinst_SCRIPTS) $(check_SCRIPTS)

##
## NOTE:
##   defs should not be made executable because it should be only included by
##   test-cases
##
defs: $(srcdir)/defs.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/defs.in > $@.tmp && \
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

test-helps: $(srcdir)/test-helps.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-helps.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

test-initialize: $(srcdir)/test-initialize.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-initialize.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

test-preprocess: $(srcdir)/test-preprocess.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-preprocess.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

test-parse: $(srcdir)/test-parse.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-parse.in > $@.tmp && \
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

test-validate: $(srcdir)/test-validate.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/test-validate.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

clean-local:
	rm -rf testSubDir-*
