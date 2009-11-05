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

schemelibdir = $(pkgvlibsdir)/scheme

schemelib_DATA =				\
	xhtml.scm

schemelib_SRCS =				\
	list.scm				\
	string.scm				\
	menu.scm				\
	tree.scm

lib.scm: Makefile $(schemelib_SRCS)
	{ rm -f lib.scm &&						\
	  touch lib.scm &&						\
	  for i in $(schemelib_SRCS) ; do				\
		cat $(srcdir)/$$i | $(SED) -e '1,/^$$/d' >> lib.scm &&	\
		echo "" >> lib.scm ;					\
	  done ; } || { rm -f lib.scm ; exit 1 ; }
CLEANFILES = lib.scm

nodist_schemelib_DATA =				\
	lib.scm

EXTRA_DIST =					\
	$(schemelib_SRCS)

##
## Maintainer related targets
##
update-local: Makefile

maintainer-check-whitespaces: Makefile $(schemelib_SRCS)
	$(WHITESPACE_DETECT) $(schemelib_SRCS)

maintainer-check-wordwraps: Makefile $(schemelib_SRCS)
	$(WORDWRAP_DETECT) --tab-size 8 --columns 80 $(schemelib_SRCS)

maintainer-check-local: Makefile maintainer-check-whitespaces
