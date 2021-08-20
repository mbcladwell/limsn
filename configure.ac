#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.65])
AC_INIT([limsn],
m4_esyscmd([build-aux/git-version-gen .tarball-version]),
[info@labsolns.com])
AC_CONFIG_SRCDIR([limsn/app/controllers])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])




AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET

# Check for Guile
GUILE_PKG(3.0)
GUILE_PROGS

AC_CONFIG_FILES([Makefile])
AC_OUTPUT






