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
	changelog.page				\
	contents.as				\
	files.as				\
	filters.page				\
	index.page				\
	level1/test1.page			\
	level1/level1/test11-1.page		\
	level1/level1/test11-2.page		\
	level1/level1/test11-3.page		\
	level1/level1/test11.page		\
	level1/level2/level1/test121.page	\
	level1/level2/test12.page		\
	level2/test2.page			\
	map.as					\
	pages.as				\
	site.as					\
	svnlog.page				\
	variables.page				\
	wikitext.page				\
	footer.sxml				\
	header.sxml				\
	site.css				\
	menu.scm

##
## Maintainer related targets
##
maintainer-check: Makefile maintainer-check-local maintainer-check-recursive

maintainer-check-recursive: Makefile
	@for i in $(SUBDIRS) ; do \
		(cd $$i && $(MAKE) $(AM_MAKEFLAGS) maintainer-check) \
	done

maintainer-check-local: Makefile
