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

SITE_SRCS =					\
	contents.as				\
	files.as				\
	footer.sxml				\
	header.sxml				\
	index.scm				\
	grammar.scm				\
	layout.sxml				\
	map.as					\
	pages.as				\
	site.as					\
	site.css

EXTRA_DIST = $(SITE_SRCS)

grammar.scm: $(top_srcdir)/docs/grammar.txt
	rm -f grammar.scm &&					\
	touch grammar.scm &&					\
	echo "(p (kbd (pre \"" >> grammar.scm &&		\
	cat $(top_srcdir)/docs/grammar.txt >> grammar.scm &&	\
	echo "\") ) )" >> grammar.scm || {			\
		rm -f grammar.scm ;				\
		exit 1 ;					\
	}

site: $(SITE_SRCS)
	SITETOOL_LIBRARY_PATH="$(top_builddir)/libs" ; \
	export SITETOOL_LIBRARY_PATH ; \
	SITETOOL_BINARY_PATH="$(top_builddir)/src" ; \
	export SITETOOL_BINARY_PATH ; \
	SITETOOL="$(top_builddir)/src/sitetool" ; \
	$$SITETOOL -v --mode initialize && \
	$$SITETOOL -v --mode build && \
	touch site.stamp || { \
		$$SITETOOL -v --mode clean ; \
		rm -f site.stamp \
		exit 1 ; \
	}

maintainer-clean-local:
	if test -e site.stamp ; then \
		SITETOOL_LIBRARY_PATH="$(top_builddir)/libs" ; \
		export SITETOOL_LIBRARY_PATH ; \
		SITETOOL_BINARY_PATH="$(top_builddir)/src" ; \
		export SITETOOL_BINARY_PATH ; \
		SITETOOL="$(top_builddir)/src/sitetool" ; \
		$$SITETOOL -v --mode clean || exit 1 ; \
		rm -f site.stamp ; \
	fi

##
## Maintainer related targets
##
update-local: Makefile

maintainer-check-local: Makefile
