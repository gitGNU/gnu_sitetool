##
## Input file for automake
##
## (C) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
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
