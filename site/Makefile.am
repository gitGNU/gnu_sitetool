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

EXTRA_DIST =					\
	contents.as				\
	files.as				\
	footer.sxml				\
	header.sxml				\
	index.scm				\
	layout.sxml				\
	map.as					\
	pages.as				\
	site.as					\
	site.css

site:
	SITETOOL_LIBRARY_PATH="$(top_builddir)/libs" ; \
	export SITETOOL_LIBRARY_PATH ; \
	SITETOOL_BINARY_PATH="$(top_builddir)/src" ; \
	export SITETOOL_BINARY_PATH ; \
	SITETOOL="$(top_builddir)/src/sitetool" ; \
	$$SITETOOL -v --initialize && \
	$$SITETOOL -v --build || { \
		exit 1 ; \
	}

maintainer-clean-local:
	SITETOOL_LIBRARY_PATH="$(top_builddir)/libs" ; \
	export SITETOOL_LIBRARY_PATH ; \
	SITETOOL_BINARY_PATH="$(top_builddir)/src" ; \
	export SITETOOL_BINARY_PATH ; \
	SITETOOL="$(top_builddir)/src/sitetool" ; \
	$$SITETOOL -v --clean || { \
		exit 1 ; \
	}
