##
## Input file for automake
##
## (C) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
##

include $(top_srcdir)/Makefile.sub

SUBDIRS = filters

bin_SCRIPTS =					\
	sitetool

pkgvbin_SCRIPTS =				\
	sitetool-initialize			\
	sitetool-preprocess			\
	sitetool-parse				\
	sitetool-build				\
	sitetool-clean				\
	sitetool-install			\
	sitetool-uninstall			\
	sitetool-check				\
	sitetool-validate			\
	sitetool-digest

## Make versioned links on bin_SCRIPTS.  We only run the transform on the
## root name; then we make a versioned link with the transformed base name.
## This seemed like the most reasonable approach.
install-exec-hook:
	for p in $(bin_SCRIPTS); do \
	  f="`echo $$p|sed '$(transform)'`"; \
	  fv="$$f-$(API_VERSION)"; \
	  cd $(DESTDIR)$(bindir) && \
	  rm -f $$fv && \
	  mv -f $$f $$fv && \
	  $(LN_S) $$fv $$f; \
	done

uninstall-hook:
	for p in $(bin_SCRIPTS); do \
	  f="`echo $$p|sed '$(transform)'`"; \
	  fv="$$f-$(API_VERSION)"; \
	  rm -f $(DESTDIR)$(bindir)/$$fv; \
	done

SITETOOL_PERL_SRCS =				\
        sitetool.in				\
	sitetool-initialize.in			\
	sitetool-build.in			\
	sitetool-clean.in			\
	sitetool-install.in			\
	sitetool-uninstall.in			\
	sitetool-check.in			\
	sitetool-validate.in			\
	sitetool-digest.in

SITETOOL_SRCS = $(SITETOOL_PERL_SRCS)

EXTRA_DIST = $(SITETOOL_SRCS) 

CLEANFILES = $(bin_SCRIPTS) $(pkgvbin_SCRIPTS)

sitetool: $(srcdir)/sitetool.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-initialize: $(srcdir)/sitetool-initialize.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-initialize.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-preprocess: $(srcdir)/sitetool-preprocess.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-preprocess.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-parse: $(srcdir)/sitetool-parse.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-parse.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-build: $(srcdir)/sitetool-build.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-build.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-clean: $(srcdir)/sitetool-clean.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-clean.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-install: $(srcdir)/sitetool-install.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-install.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-uninstall: $(srcdir)/sitetool-uninstall.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-uninstall.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-check: $(srcdir)/sitetool-check.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-check.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-validate: $(srcdir)/sitetool-validate.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-validate.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sitetool-digest: $(srcdir)/sitetool-digest.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-digest.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
