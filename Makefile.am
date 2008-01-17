##
## Input file for automake
##
## (C) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
##

include $(top_srcdir)/Makefile.sub

ACLOCAL_AMFLAGS = -I tools/autotools/m4

SUBDIRS =					\
	tools					\
	data					\
	libs					\
	src					\
	docs					\
	test

# Base directories
TOOLSDIR   = $(top_builddir)/tools
SCRIPTSDIR = $(TOOLSDIR)/scripts

##
## NOTE:
##     Options listed in AUTOMAKE_OPTIONS variable are applied on a
##     per-`Makefile' basis.
##
AUTOMAKE_OPTIONS = check-news

##
## NOTE:
##     ChangeLogs are shipped by this directory Makefile.am even if they lies on
##     child directory ... CHANGELOGS variable is needed here for distribution
##     purposes ...
##
CHANGELOGS =					\
	ChangeLog				\
	$(srcdir)/docs/ChangeLog-2007.1		\
	$(srcdir)/docs/ChangeLog-2007.0

EXTRA_DIST =						\
	TODO README NEWS COPYING AUTHORS INSTALL THANKS	\
	Makefile.sub					\
	$(CHANGELOGS)					\
	configure.ac.in					\
	bootstrap

##
## distribution related target
##
#NEWS: $(SCRIPTSDIR)/CL2NEWS Makefile $(CHANGELOGS)
#        ( input="" ;                                    \
#          for j in $(CHANGELOGS) ; do                   \
#                input="$$input $(srcdir)/$$j" ;         \
#          done ;                                        \
#          $(SCRIPTSDIR)/CL2NEWS -- $$input > NEWS ) ||  \
#        { rm -f NEWS ; exit 1 ; }

ChangeLog: $(srcdir)/NEWS
	HEAD_TAG=`$(SCRIPTSDIR)/NEWS-query $(srcdir)/NEWS 0` ;	\
	PREV_TAG=`$(SCRIPTSDIR)/NEWS-query $(srcdir)/NEWS 1` ;	\
	$(SCRIPTSDIR)/gitlog2ChangeLog $$PREV_TAG..$$HEAD_TAG >	\
		ChangeLog || {					\
		rm -f ChangeLog ;				\
		exit 1;						\
	}

#dist-hook: ChangeLog NEWS
#	cp ChangeLog $(distdir)/ChangeLog || {	\
#		rm -f $(distdir)/ChangeLog ;	\
#		exit 1 ;			\
#	}
#	cp NEWS $(distdir)/NEWS || {		\
#		rm -f $(distdir)/NEWS ;		\
#		exit 1 ;			\
#	}

DISTCLEANFILES =
