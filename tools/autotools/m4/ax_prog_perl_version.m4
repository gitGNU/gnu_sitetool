##### http://autoconf-archive.cryp.to/ax_prog_perl_version.html
#
# SYNOPSIS
#
#   AX_PROG_PERL_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
#
# DESCRIPTION
#
#   Makes sure that perl supports the version indicated. If true the
#   shell commands in ACTION-IF-TRUE are executed. If not the shell
#   commands in ACTION-IF-FALSE are run. Note if $PERL is not set (for
#   example by running AC_CHECK_PROG or AC_PATH_PROG),
#   AC_CHECK_PROG(PERL, perl, perl) will be run.
#
#   Example:
#
#     AC_PROG_PERL_VERSION([5.8.0],[ ... ],[ ... ])
#
#   This will check to make sure that the perl you have supports at
#   least version 5.8.0.
#
# LAST MODIFICATION
#
#   2007-12-07
#
# COPYLEFT
#
#   Copyright (c) 2007 Francesco Salvestrini <salvestrini@users.sourceforge.net>
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
#   02111-1307, USA.
#
#   As a special exception, the respective Autoconf Macro's copyright
#   owner gives unlimited permission to copy, distribute and modify the
#   configure scripts that are the output of Autoconf when processing
#   the Macro. You need not follow the terms of the GNU General Public
#   License when using or distributing such scripts, even though
#   portions of the text of the Macro appear in them. The GNU General
#   Public License (GPL) does govern all other use of the material that
#   constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the
#   Autoconf Macro released by the Autoconf Macro Archive. When you
#   make and distribute a modified version of the Autoconf Macro, you
#   may extend this special exception to the GPL to apply to your
#   modified version as well.

AC_DEFUN([AX_PROG_PERL_VERSION],[
    AC_REQUIRE([AX_PROG_PERL])

    AS_IF([test -n "$PERL"],[
        ax_perl_version="$1"

        AC_MSG_CHECKING([for perl version >= $ax_perl_version])

	cat > conftest.pl << EOF
use $ax_perl_version;
EOF
	AC_TRY_COMMAND([$PERL conftest.pl 1>&AS_MESSAGE_LOG_FD])
        AS_IF([ test $? -ne 0 ],[
            AC_MSG_RESULT([no]);
            $3
        ],[
            AC_MSG_RESULT([yes]);
            $2
        ])
	rm -f conftest.pl

    ],[
        AC_MSG_RESULT([could not find perl interpreter])
        $3
    ])
])
