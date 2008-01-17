##
## Input file for automake
##
## (C) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
##

include $(top_srcdir)/Makefile.sub

SUBDIRS =					\
	Base					\
	Misc					\
	OS					\
	WWW

perllibdir = $(pkgvlibsdir)/perl/Sitetool

dist_perllib_DATA =				\
	Configuration.pm			\
	Preprocess.pm				\
	Parse.pm				\
	Digest.pm				\
	SXML.pm					\
	XML.pm					\
	Pagemap.pm				\
	Sitemap.pm				\
	Variable.pm				\
	Tree.pm					\
	Graphviz.pm				\
	Stack.pm				\
	Array.pm

nodist_perllib_DATA =				\
	Autoconfig.pm				\
	Filterchain.pm				\
	Scheme.pm

CLEANFILES     = $(nodist_perllib_DATA)
DISTCLEANFILES = Parse.pm

Parse.pm: Makefile $(srcdir)/Parse.yp
	$(YAPP) -s -m Sitetool::Parse -o $@ $(srcdir)/Parse.yp || { \
		rm -f $@ ; \
		exit 1 ; \
	}

Autoconfig.pm: Makefile Autoconfig.pm.in
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/Autoconfig.pm.in > $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

##
## This module needs @PATH_SEPARATOR@ ...
##
Filterchain.pm: Makefile Filterchain.pm.in
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/Filterchain.pm.in > $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

##
## This module needs @PATH_SEPARATOR@ ...
##
Scheme.pm: Makefile Scheme.pm.in
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/Scheme.pm.in > $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

EXTRA_DIST =					\
	Autoconfig.pm.in			\
	Filterchain.pm.in			\
	Scheme.pm.in				\
	Parse.yp
