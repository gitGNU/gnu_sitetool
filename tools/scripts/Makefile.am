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
	fetch.in				\
	perl-autofrisk				\
	whitespace-detect.in

noinst_SCRIPTS =				\
	fetch					\
	whitespace-detect

CLEANFILES = $(noinst_SCRIPTS)

fetch: fetch.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/fetch.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

whitespace-detect: whitespace-detect.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/whitespace-detect.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

update: fetch

##
## Maintainer related targets
##
HOST = "http://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=blob_plain;hb=HEAD;f="

update-local: Makefile
	rm -r -f fetch-dir && \
	mkdir fetch-dir && \
	$(FETCH) $(HOST)build-aux/git-version-gen fetch-dir/git-version-gen && \
	chmod a+rx fetch-dir/git-version-gen && \
	chmod u+w  fetch-dir/git-version-gen && \
	$(FETCH) $(HOST)build-aux/gitlog-to-changelog fetch-dir/gitlog-to-changelog && \
	chmod a+rx fetch-dir/gitlog-to-changelog && \
	chmod u+w  fetch-dir/gitlog-to-changelog && \
	mv -f fetch-dir/* ./ || { \
		rm -r -f fetch-dir ; \
		exit 1 ; \
	}
	rm -r -f fetch-dir

EXTRA_DIST +=					\
	git-version-gen				\
	gitlog-to-changelog

maintainer-check-local: Makefile
