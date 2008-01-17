##
## (C) 2004 - 2007 Francesco Salvestrini <salvestrini@users.sourceforge.net>
##
## Input file for automake
##

dist_man_MANS = sitetool.1
man_aux       = sitetool.x

EXTRA_DIST = $(man_aux)

# SITETOOL_LIBRARY_PATH="$(top_builddir)/libs@PATH_SEPARATOR@$$PATH";
sitetool.1: $(srcdir)/sitetool.x $(top_srcdir)/src/sitetool.in
	SITETOOL_LIBRARY_PATH="$(top_builddir)/libs"; \
	export SITETOOL_LIBRARY_PATH;	\
	$(HELP2MAN) \
	    --include=$(srcdir)/sitetool.x \
	    --source="FSF" \
	    --manual="User Commands" \
	    --section=1	\
	    --output=$@	\
	    $(top_builddir)/src/sitetool
