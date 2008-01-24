##
## (C) 2003-2005 Francesco Salvestrini <salvestrini@users.sourceforge.net>
##
## Input file for automake
##

include $(top_srcdir)/Makefile.sub

EXTRA_DIST =					\
	gitlog2ChangeLog.in			\
	NEWS-query.in				\
	perl-autofrisk.in

noinst_SCRIPTS =				\
	gitlog2ChangeLog			\
	NEWS-query				\
	perl-autofrisk

CLEANFILES = $(noinst_SCRIPTS)

NEWS-query: NEWS-query.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/NEWS-query.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

gitlog2ChangeLog: gitlog2ChangeLog.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/gitlog2ChangeLog.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}

perl-autofrisk: perl-autofrisk.in Makefile
	( rm -f $@ $@.tmp && \
	  $(do_subst) < $(srcdir)/perl-autofrisk.in > $@.tmp && \
	  chmod +x $@.tmp && \
	  chmod a-w $@.tmp && \
	  mv -f $@.tmp $@ ) || { \
		rm -f $@ $@.tmp ; \
		exit 1 ; \
	}
