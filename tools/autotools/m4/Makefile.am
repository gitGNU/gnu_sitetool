##
## Input file for automake
##
## (C) 2007, 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

HOST="http://autoconf-archive.cryp.to"

MACROS =					\
	ax_compare_version.m4			\
	ax_missing_prog.m4			\
	ax_path_missing.m4			\
	ax_prog_guile_version.m4		\
	ax_prog_perl_modules.m4			\
	ax_prog_perl_version.m4			\
	ax_prog_python_version.m4		\
	ax_prog_ruby_version.m4			\
	ax_split_version.m4			\
	ax_with_guile.m4			\
	ax_with_perl.m4				\
	ax_with_prog.m4				\
	ax_with_python.m4			\
	ax_with_ruby.m4

WGET_FLAGS = -r --no-verbose

update:
	rm -r -f fetch > /dev/null 2>&1 && \
	mkdir fetch && \
	(cd fetch && \
	for i in $(MACROS) ; do \
		$(WGET) $(WGET_FLAGS) $(HOST)/$$i ; \
	done) && \
	rm -r -f fetch || { \
		rm -r -f fetch ; \
		exit 1 ; \
	}
