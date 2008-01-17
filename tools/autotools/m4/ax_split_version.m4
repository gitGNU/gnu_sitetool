# AX_SPLIT_VERSION(VERSION)
#
# Splits a version number in the format MAJOR[.MINOR[.MICRO[-EXTRA]]] into
# its separeate components and sets the variables AX_MAJOR_VERSION,
# AX_MINOR_VERSION, AX_MICRO_VERSION and AX_EXTRA_VERSION.
#
# This macro is based upon AX_SPLIT_VERSION macro by Tom Howard
#
# (C) 2007 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

AC_DEFUN([AX_SPLIT_VERSION],[dnl
    AX_VERSION=$1

    AX_MAJOR_VERSION=`echo "$AX_VERSION" | \
	sed 's/^\([[0-9]]*\).*$/\1/'`
    AX_MINOR_VERSION=`echo "$AX_VERSION" | \
        sed 's/^[[0-9]]*\.\([[0-9]]*\).*$/\1/'`
    AX_MICRO_VERSION=`echo "$AX_VERSION" | \
        sed 's/^[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\).*$/\1/'`
    AX_EXTRA_VERSION=`echo "$AX_VERSION" | \
        sed 's/^[[0-9]]*\.[[0-9]]*\.[[0-9]]*-\?\(.*\)$/\1/'`
])
