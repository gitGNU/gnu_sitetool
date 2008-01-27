##### 
#
# SYNOPSIS
#
#   AX_PROG_RUBY_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
#
# DESCRIPTION
#
#   Makes sure that ruby supports the version indicated. If true the
#   shell commands in ACTION-IF-TRUE are executed. If not the shell
#   commands in ACTION-IF-FALSE are run. Note if $RUBY is not set (for
#   example by running AC_CHECK_PROG or AC_PATH_PROG),
#
#   Example:
#
#     AC_PATH_PROG([RUBY],[ruby])
#     AC_PROG_RUBY_VERSION([1.8.0],[ ... ],[ ... ])
#
#   This will check to make sure that the ruby you have supports at
#   least version 1.8.0.
#
# NOTE
#
#   This macro uses the RUBY variable to perform the check. The RUBY_VERSION
#   variable will be valorized with the detected version
#
# LAST MODIFICATION
#
#   2008-01-27
#
# COPYLEFT
#
#   Copyright (c) 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

AC_DEFUN([AX_PROG_RUBY_VERSION],[
    AC_REQUIRE([AC_PROG_SED])
    AC_REQUIRE([AC_PROG_GREP])

    AS_IF([test -n "$RUBY"],[
        ax_ruby_version="$1"

        AC_MSG_CHECKING([for ruby version])
        changequote(<<,>>)
        ruby_version=`$RUBY --version 2>&1 | $GREP "^ruby " | $SED -e 's/^.* \([0-9]*\.[0-9]*\.[0-9]*\) .*/\1/'`
        changequote([,])
        AC_MSG_RESULT($ruby_version)

	AC_SUBST([RUBY_VERSION],[$ruby_version])

        AX_COMPARE_VERSION([$ax_ruby_version],[le],[$ruby_version],[
	    :
            $2
        ],[
	    :
            $3
        ])
    ],[
        AC_MSG_WARN([could not find the ruby interpreter])
        $3
    ])
])
