##
## Input file for automake
##
## Copyright (C) 2008, 2009 Francesco Salvestrini
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

SUBDIRS = filters

bin_SCRIPTS =					\
	sitetool				\
	sitetool-config

pkgvbin_SCRIPTS =				\
	sitetool-initialize			\
	sitetool-preprocess			\
	sitetool-parse				\
	sitetool-build				\
	sitetool-clean				\
	sitetool-check				\
	sitetool-validate

##
## XXX FIXME:
##     Replace 'sed' with '$SED' in install-exec-hook and uninstall-hook
##     rules ...
##

## Make versioned links on bin_SCRIPTS.  We only run the transform on the
## root name; then we make a versioned link with the transformed base name.
## This seemed like the most reasonable approach.
install-exec-hook:
	for p in $(bin_SCRIPTS); do \
	  f="`echo $$p|sed '$(transform)'`"; \
	  fv="$$f-$(PACKAGE_API)"; \
	  cd $(DESTDIR)$(bindir) && \
	  rm -f $$fv && \
	  mv -f $$f $$fv && \
	  $(LN_S) $$fv $$f; \
	done

uninstall-hook:
	for p in $(bin_SCRIPTS); do \
	  f="`echo $$p|sed '$(transform)'`"; \
	  fv="$$f-$(PACKAGE_API)"; \
	  rm -f $(DESTDIR)$(bindir)/$$fv; \
	done

SITETOOL_SHELL_SRCS =				\
	sitetool-config.in

SITETOOL_PERL_SRCS =				\
        sitetool.in				\
	sitetool-initialize.in			\
	sitetool-preprocess.in			\
	sitetool-parse.in			\
	sitetool-build.in			\
	sitetool-clean.in			\
	sitetool-check.in			\
	sitetool-validate.in

SITETOOL_SRCS = $(SITETOOL_PERL_SRCS) $(SITETOOL_SHELL_SRCS)

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

sitetool-config: $(srcdir)/sitetool-config.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sitetool-config.in > $@.tmp && \
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

##
## Maintainer related targets
##
update-local: Makefile

maintainer-check-parameters: Makefile $(bin_SCRIPTS) $(pkgvbin_SCRIPTS)
	for i in $(bin_SCRIPTS) $(pkgvbin_SCRIPTS) ; do \
		echo @ECHO_N@ "Checking standard parameters for $$i... " ; \
		SITETOOL_LIBRARY_PATH="$(top_builddir)/libs" ; \
		export SITETOOL_LIBRARY_PATH ;	\
		if ( ./$$i -h 2>&1 > /dev/null ) ; then \
			echo "@ECHO_T@ok" ; \
		else \
			echo "@ECHO_T@error" ; \
			exit 1 ; \
		fi ; \
	done

maintainer-check-whitespaces: Makefile $(SITETOOL_PERL_SRCS)
	$(WHITESPACE_DETECT) $(SITETOOL_PERL_SRCS)

maintainer-check-local: Makefile maintainer-check-parameters maintainer-check-whitespaces
