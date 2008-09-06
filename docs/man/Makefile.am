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

dist_man_MANS = sitetool.1
man_aux       = sitetool.x

EXTRA_DIST = $(man_aux)

##
## NOTE:
##     Distributed files should never depend on non-distributed built files
##

# SITETOOL_LIBRARY_PATH="$(top_builddir)/libs@PATH_SEPARATOR@$$PATH";
sitetool.1: $(top_srcdir)/src/sitetool.in $(top_srcdir)/libs/perl/Sitetool/Base/Program.pm $(top_srcdir)/configure.ac
	SITETOOL_LIBRARY_PATH="$(top_builddir)/libs"; \
	export SITETOOL_LIBRARY_PATH;	\
	$(HELP2MAN) \
	    --include=$(srcdir)/sitetool.x \
	    --source="FSF" \
	    --manual="User Commands" \
	    --section=1	\
	    --output=$@	\
	    $(top_builddir)/src/sitetool

##
## Maintainer related targets
##
update-local: Makefile

maintainer-check-local: Makefile
