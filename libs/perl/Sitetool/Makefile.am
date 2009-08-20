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

SUBDIRS =					\
	Base					\
	Data					\
	OS					\
	RC					\
	Misc					\
	Net

perllibdir = $(pkgvlibsdir)/perl/Sitetool

dist_perllib_DATA =				\
	Configuration.pm			\
	Preprocess.pm				\
	Parse.pm				\
	SXML.pm					\
	XML.pm					\
	Pagemap.pm				\
	Sitemap.pm				\
	Variable.pm				\
	Graphviz.pm

nodist_perllib_DATA =				\
	Autoconfig.pm				\
	Scheme.pm

CLEANFILES = $(nodist_perllib_DATA)
MAINTAINERCLEANFILES =				\
	Parse.pm				\
	Preprocess.pm

Parse.pm: $(srcdir)/Parse.yp
	$(YAPP) -s -m Sitetool::Parse -o $@ $(srcdir)/Parse.yp || { \
		rm -f $@ ; \
		exit 1 ; \
	}

Preprocess.pm: $(srcdir)/Preprocess.yp
	$(YAPP) -s -m Sitetool::Preprocess -o $@ $(srcdir)/Preprocess.yp || { \
		rm -f $@ ; \
		exit 1 ; \
	}

Autoconfig.pm: Makefile $(srcdir)/Autoconfig.pm.in
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
Scheme.pm: Makefile $(srcdir)/Scheme.pm.in
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/Scheme.pm.in > $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

EXTRA_DIST =					\
	Autoconfig.pm.in			\
	Scheme.pm.in				\
	Parse.yp				\
	Parse.pm				\
	Preprocess.yp				\
	Preprocess.pm

##
## Maintainer related targets
##
update-local: Makefile

maintainer-check-whitespaces: Makefile
	$(WHITESPACE_DETECT) $(dist_perllib_DATA) $(nodist_perllib_DATA)

maintainer-check-local: Makefile maintainer-check-whitespaces
