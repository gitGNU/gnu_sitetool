# Process this file with autoconf to produce a configure script.

#
# configure.ac for sitetool
#
# Copyright (C) 2008, 2009 Francesco Salvestrini
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

AC_INIT([Sitetool],
        m4_esyscmd([tools/maint/git-version-gen .tarball-version]),
        [sitetool-generic@nongnu.org],
        [sitetool],
        [http://www.nongnu.org/sitetool])

# Check for a recent version of autoconf
AC_PREREQ([2.65])

# Place/find all autotools related files in the following directories
AC_CONFIG_AUX_DIR([tools/autotools])
AC_CONFIG_MACRO_DIR([tools/autotools/m4])
AC_CONFIG_SRCDIR([src/sitetool.in])

#
# For automake options (AM_INIT_AUTOMAKE options) see Makefile.am
# file, AUTOMAKE_OPTIONS variable
#
AM_INIT_AUTOMAKE([1.11.1 foreign std-options -Wall color-tests])

#
# Build related programs
#
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PROG_LN_S
AC_PROG_MKDIR_P
AC_PROG_GREP
AC_PROG_SED
AC_PROG_AWK

AX_PATH_MISSING([YAPP],            [yapp])
AX_PATH_MISSING([YAPP_TO_GRAMMAR], [yapp-to-grammar])
AX_PATH_MISSING([HELP2MAN],        [help2man])
AX_PATH_MISSING([DNT],             [dnt])
AX_PATH_MISSING([SORT],            [sort])

#
# Runtime related programs
#
AX_WITH_FCP
AS_IF([test -z "$FCP"],[
	AC_MSG_ERROR([Missing required Filter Chains Processor])
],[
	AX_PROG_FCP_VERSION([0.0.5],[],[
		AC_MSG_ERROR([Missing required Filter Chains Processor version >= 0.0.5])
	])
])

AX_WITH_PERL
AS_IF([test -z "$PERL"],[
	AC_MSG_ERROR([Missing required Perl interpreter])
],[
	AX_PROG_PERL_VERSION([5.8.0],[],[
		AC_MSG_ERROR([Missing required Perl interpreter version >= 5.8.0])
	])

	PERL_AUTOFRISK_CHECKS
	PERL_AUTOFRISK_SUMMARY
])

AX_WITH_GUILE
AS_IF([test -z "$GUILE"],[
	AC_MSG_ERROR([Missing required Guile interpreter])
],[
	AX_PROG_GUILE_VERSION([1.6.4],[],[
		AC_MSG_ERROR([Missing required Guile interpreter version >= 1.6.4])
	])

	guile_modules=yes
	#GUILE_MODULE_REQUIRED([sxml simple])
	GUILE_MODULE_AVAILABLE(guile_module_sxml_simple, (sxml simple))
	AS_IF([test "$guile_module_sxml_simple" = "no"],[
		guile_modules=no
	])

	#GUILE_MODULE_REQUIRED([sxml transform])
	GUILE_MODULE_AVAILABLE(guile_module_sxml_transform, (sxml transform))
	AS_IF([test "$guile_module_sxml_transform" = "no"],[
		guile_modules=no
	])

	AS_IF([test "$guile_modules" = "no"],[
		AC_MSG_WARN([your system seems to be lacking of guile-lib support])
		AC_MSG_WARN([try installing it from http://home.gna.org/guile-lib])
		AC_MSG_WARN([if it is missing, tweak environment variable and/or])
		AC_MSG_WARN([use configure script parameters if it is present or])
		AC_MSG_WARN([report the bug otherwise to:])
		AC_MSG_WARN([])
		AC_MSG_WARN([    <$PACKAGE_BUGREPORT>])
		AC_MSG_WARN([])
		AC_MSG_WARN([Thank you])
		AC_MSG_ERROR([required guile module(s) not found])
	])

	GUILE_AUTOFRISK_CHECKS
	GUILE_AUTOFRISK_SUMMARY
])

AX_WITH_PYTHON
AS_IF([test -z "$PYTHON"],[
	:
],[
	AX_PROG_PYTHON_VERSION([2.4.4],[],[])
])

AX_WITH_RUBY
AS_IF([test -z "$RUBY"],[
	:
],[
	AX_PROG_RUBY_VERSION([1.8.6],[],[])
])

#
# NOTE:
#     The following programs are used inside the libs (which will be installed)
#     directory, no AX_PATH_MISSING use allowed
#
# XXX FIXME:
#     Some programs should be in AX_PATH_MISSING too (WGET is an example)
#
AC_PATH_PROG([TIDY],   [tidy])
AC_PATH_PROG([WPUT],   [wput])
AC_PATH_PROG([WGET],   [wget])

AM_CONDITIONAL([PERL_AVAILABLE],   [ test ! "$PERL" = ""   ])
AM_CONDITIONAL([PYTHON_AVAILABLE], [ test ! "$PYTHON" = "" ])
AM_CONDITIONAL([RUBY_AVAILABLE],   [ test ! "$RUBY" = ""   ])
AM_CONDITIONAL([SCHEME_AVAILABLE], [ test ! "$GUILE" = ""  ])
AM_CONDITIONAL([SHELL_AVAILABLE],  [ test ! "$SHELL" = ""  ])

AX_SPLIT_VERSION($PACKAGE_VERSION, AX_MAJOR_VERSION, AX_MINOR_VERSION, AX_MICRO_VERSION, AX_EXTRA_VERSION)
AX_PACKAGE_API([${AX_MAJOR_VERSION}"."${AX_MINOR_VERSION}])

AC_CONFIG_FILES([
	Makefile

	docs/Makefile
	docs/man/Makefile
	docs/info/Makefile

	data/Makefile

	src/Makefile
	src/filters/Makefile

	libs/Makefile
	libs/perl/Makefile
	libs/perl/Sitetool/Makefile
	libs/perl/Sitetool/Misc/Makefile
	libs/perl/Sitetool/Base/Makefile
	libs/perl/Sitetool/Data/Makefile
	libs/perl/Sitetool/OS/Makefile
	libs/perl/Sitetool/RC/Makefile
	libs/perl/Sitetool/Net/Makefile
	libs/perl/Sitetool/Net/WWW/Makefile
	libs/python/Makefile
	libs/ruby/Makefile
	libs/scheme/Makefile
	libs/shell/Makefile

	site/Makefile
	site/in/Makefile

	tools/Makefile
	tools/maint/Makefile
	tools/autotools/Makefile
	tools/autotools/m4/Makefile

	tests/Makefile
	tests/data-common/Makefile
	tests/data-build-01/Makefile
	tests/data-build-02/Makefile
])

AC_CONFIG_FILES([tools/maint/fetch],               [chmod +x tools/maint/fetch])
AC_CONFIG_FILES([tools/maint/wordwrap-detect],     [chmod +x tools/maint/wordwrap-detect])
AC_CONFIG_FILES([tools/maint/whitespace-detect],   [chmod +x tools/maint/whitespace-detect])
AC_CONFIG_FILES([tools/maint/gitlog-to-committers],[chmod +x tools/maint/gitlog-to-committers])
AC_CONFIG_FILES([tools/maint/gittag-to-date],      [chmod +x tools/maint/gittag-to-date])
AC_CONFIG_FILES([tools/maint/releases-to-news],    [chmod +x tools/maint/releases-to-news])

AC_OUTPUT

# Header
cat <<EOF

  ${PACKAGE_NAME} ${PACKAGE_API} (${PACKAGE_VERSION}) configuration summary

EOF

# Body
if test -n "$PERL" ; then
   echo "    Perl     : ${PERL} (${PERL_VERSION})"
else
   echo "    Perl     : not available"
fi
if test -n "$GUILE" ; then
   echo "    Guile    : ${GUILE} (${GUILE_VERSION})"
else
   echo "    Guile    : not available"
fi
if test -n "$RUBY" ; then
   echo "    Ruby     : ${RUBY} (${RUBY_VERSION})"
else
   echo "    Ruby     : not available"
fi
if test -n "$PYTHON" ; then
   echo "    Python   : ${PYTHON} (${PYTHON_VERSION})"
else
   echo "    Python   : not available"
fi

# Footer
cat <<EOF

EOF
