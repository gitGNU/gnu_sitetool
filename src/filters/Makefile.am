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

filtersdir = $(pkgvbindir)/filters

filters_SCRIPTS =
filters_SRCS    =

if PERL_AVAILABLE
filters_SCRIPTS +=				\
	changelog-wikitext			\
	svnlog-wikitext				\
	wikitext-sxml
filters_SRCS    +=				\
	changelog-wikitext.in			\
	svnlog-wikitext.in			\
	wikitext-sxml.in
endif

if PYTHON_AVAILABLE
filters_SCRIPTS +=
filters_SRCS    +=
endif

if RUBY_AVAILABLE
filters_SCRIPTS +=
filters_SRCS    +=
endif

if SCHEME_AVAILABLE
filters_SCRIPTS +=
filters_SRCS    +=
endif

if SHELL_AVAILABLE
filters_SCRIPTS +=				\
	map-sxml				\
	news-wikitext				\
	sxml-sxml
filters_SRCS    +=				\
	map-sxml.in				\
	news-wikitext.in			\
	sxml-sxml.in
endif

CLEANFILES = $(filters_SCRIPTS)
EXTRA_DIST = $(filters_SRCS)

changelog-wikitext: changelog-wikitext.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/changelog-wikitext.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

svnlog-wikitext: svnlog-wikitext.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/svnlog-wikitext.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

wikitext-sxml: wikitext-sxml.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/wikitext-sxml.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

map-sxml: map-sxml.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/map-sxml.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

news-wikitext: news-wikitext.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/news-wikitext.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

sxml-sxml: sxml-sxml.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/sxml-sxml.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
