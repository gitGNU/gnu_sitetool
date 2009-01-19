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

EXTRA_DIST = fcp.in
CLEANFILES = fcp

## We need an file for our fcp-related rules. This file will be used directly
## from the build_dir (tests and local site) and from the $(DESTDIR)(datadir)
## (when installed). In order to cope with such problem we will build an input
## rule file for the tests/local case while we will use a install-data-hook to
## build it in the destination directory in the install case.
fcp: Makefile fcp.in
	cat fcp.in | \
	$(SED) -e 's,[@]RELDIR[@],$(abs_top_builddir)/src/filters,' > fcp || { \
		rm -f fcp ; \
		exit 1 ; \
	}

all-local: fcp

install-data-hook:
	$(MKDIR_P) $(pkgvdatadir) && \
	cat fcp.in | \
		$(SED) -e 's,[@]RELDIR[@],$(pkgvbindir)/filters,' > $(pkgvdatadir)/fcp || { \
			rm -f $(pkgvdatadir)/fcp ; \
			exit 1 ; \
	}

##
## Maintainer related targets
##
update-local: Makefile

maintainer-check-local: Makefile
