##### http://autoconf-archive.cryp.to/ax_gcc_option.html
#
# SYNOPSIS
#
#   AX_PROG_PERL
#
# This macro looks for perl interpreter
# 
# Use it in your configure.ac as:
#
#   AX_PROG_PERL
#
# LAST MODIFICATION
#
#   2007-12-10
#
# COPYLEFT
#
#  Copyright (c) 2007 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

AC_DEFUN([AX_PROG_PERL],[dnl
    AC_PREREQ([2.61])

    AC_ARG_WITH([perl],
        [AS_HELP_STRING([--with-perl-interpreter],
                        [override autodetected perl interpreter])], [
        PERL=$withval
	AC_SUBST([PERL],[$PERL])
    ],[
        AC_PATH_PROG([PERL],[perl])
    ])
])
