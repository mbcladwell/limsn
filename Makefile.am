bin_SCRIPTS = 

# Handle substitution of fully-expanded Autoconf variables.
do_subst = $(SED)					\
  -e 's,[@]GUILE[@],$(GUILE),g'				\
  -e 's,[@]guilemoduledir[@],$(guilemoduledir),g'	\
  -e 's,[@]guileobjectdir[@],$(guileobjectdir),g'	\
  -e 's,[@]localedir[@],$(localedir),g'

nodist_noinst_SCRIPTS = pre-inst-env

GOBJECTS = $(SOURCES:%.scm=%.go)

moddir=$(prefix)/share/guile/site/$(GUILE_EFFECTIVE_VERSION)
godir=$(libdir)/guile/$(GUILE_EFFECTIVE_VERSION)/site-ccache
ccachedir=$(libdir)/guile/$(GUILE_EFFECTIVE_VERSION)/site-ccache

nobase_mod_DATA = $(SOURCES) $(NOCOMP_SOURCES)
nobase_go_DATA = $(GOBJECTS)

# Make sure source files are installed first, so that the mtime of
# installed compiled files is greater than that of installed source
# files.  See
# <http://lists.gnu.org/archive/html/guile-devel/2010-07/msg00125.html>
# for details.
guile_install_go_files = install-nobase_goDATA
$(guile_install_go_files): install-nobase_modDATA

EXTRA_DIST = $(SOURCES) $(NOCOMP_SOURCES)
GUILE_WARNINGS = -Wunbound-variable -Warity-mismatch -Wformat
SUFFIXES = .scm .go
.scm.go:
	$(AM_V_GEN)$(top_builddir)/pre-inst-env $(GUILE_TOOLS) compile $(GUILE_WARNINGS) -o "$@" "$<"

SOURCES = limsn/lib/lnpg.scm \
          limsn/lib/artass.scm \
          limsn/lib/gplot.scm \
          limsn/lib/run-lnpg.scm \
          limsn/app/views/plateset/addstep2.html.tpl \
          limsn/app/views/plateset/add.html.tpl \
          limsn/app/views/plateset/worklist.html.tpl \
          limsn/app/views/plateset/reformatconfirm.html.tpl \
          limsn/app/views/plateset/impdata.html.tpl \
          limsn/app/views/plateset/testcset.html.tpl \
          limsn/app/views/plateset/impbc.html.tpl \
          limsn/app/views/plateset/grouperror.html.tpl \
          limsn/app/views/plateset/editps.html.tpl \
          limsn/app/views/plateset/test2.html.tpl \
          limsn/app/views/plateset/impaccs.html.tpl \
          limsn/app/views/plateset/test.html.tpl \
          limsn/app/views/plateset/reformatps.html.tpl \
          limsn/app/views/plateset/impdataaction.html.tpl \
          limsn/app/views/plateset/groupps.html.tpl \
          limsn/app/views/plateset/getps.html.tpl \
          limsn/app/views/sessions/notadmin.html.tpl \
          limsn/app/views/sessions/getall.html.tpl \
          limsn/app/views/sessions/sesschk.html.tpl \
          limsn/app/views/sessions/get.html.tpl \
          limsn/app/views/project/add.html.tpl \
          limsn/app/views/project/notadmin.html.tpl \
          limsn/app/views/project/getall.html.tpl \
          limsn/app/views/project/unlicensed.html.tpl \
          limsn/app/views/project/poster.html.tpl \
          limsn/app/views/project/test.html.tpl \
          limsn/app/views/project/edit.html.tpl \
          limsn/app/views/login/getfile.html.tpl \
          limsn/app/views/login/collect.html.tpl \
          limsn/app/views/login/test.html.tpl \
          limsn/app/views/login/login.html.tpl \
          limsn/app/views/assayrun/getarid.html.tpl \
          limsn/app/views/assayrun/replot.html.tpl \
          limsn/app/views/assayrun/getalldata.bak \
          limsn/app/views/assayrun/test.html.tpl \
          limsn/app/views/assayrun/getforpsid.html.tpl \
          limsn/app/views/assayrun/getarid.html.bak \
          limsn/app/views/assayrun/getalldata.html.tpl \
          limsn/app/views/hitlist/addtoar.html.tpl \
          limsn/app/views/hitlist/forprj.html.tpl \
          limsn/app/views/hitlist/gethlbyid.html.tpl \
          limsn/app/views/hitlist/rearraystep2.html.tpl \
          limsn/app/views/hitlist/importhl.html.tpl \
          limsn/app/views/hitlist/rearray.html.tpl \
          limsn/app/views/hitlist/test2.html.tpl \
          limsn/app/views/hitlist/test.html.tpl \
          limsn/app/views/hitlist/viewhits.html.tpl \
          limsn/app/views/hitlist/gethlforarid.html.tpl \
          limsn/app/views/layout/lytbyid.html.tpl \
          limsn/app/views/layout/getall.html.tpl \
          limsn/app/views/layout/select.html.tpl \
          limsn/app/views/layout/upload.html.tpl \
          limsn/app/views/layout/viewlayout.html.tpl \
          limsn/app/views/layout/test.html.tpl \
          limsn/app/views/layout/import.html.tpl \
          limsn/app/views/layout/success.html.tpl \
          limsn/app/views/test/add.html.tpl \
          limsn/app/views/test/logtest.html.tpl \
          limsn/app/views/test/sessiontest.html.tpl \
          limsn/app/views/test/page2.html.tpl \
          limsn/app/views/test/authtest.html.tpl \
          limsn/app/views/test/cookietest.html.tpl \
          limsn/app/views/test/page1.html.tpl \
          limsn/app/views/test/test.html.tpl \
          limsn/app/views/test/check.html.tpl \
          limsn/app/views/utilities/isreg.html.tpl \
          limsn/app/views/utilities/menu.html.tpl \
          limsn/app/views/utilities/notadmin.html.tpl \
          limsn/app/views/utilities/regform.html.tpl \
          limsn/app/views/utilities/register.html.tpl \
          limsn/app/views/utilities/test.html.tpl \
          limsn/app/views/utilities/failreg.html.tpl \
          limsn/app/views/utilities/login.html.tpl \
          limsn/app/views/target/addsingle.html.tpl \
          limsn/app/views/target/getall.html.tpl \
          limsn/app/views/target/gettrglytbyid.html.tpl \
          limsn/app/views/target/gettrglyt.html.tpl \
          limsn/app/views/target/addbulk.html.tpl \
          limsn/app/views/target/addtrglyt.js \
          limsn/app/views/target/test.html.tpl \
          limsn/app/views/target/addtrglyt.html.tpl \
          limsn/app/views/plate/getwellsforpplt.html.tpl \
          limsn/app/views/plate/getwellsforplt.html.tpl \
          limsn/app/views/plate/getpltforps.html.tpl \
          limsn/app/views/plate/groupplts.html.tpl \
          limsn/app/views/plate/getwellsforps.html.tpl \
          limsn/app/views/plate/test.html.tpl \
          limsn/app/views/users/add.html.tpl \
          limsn/app/views/users/notadmin.html.tpl \
          limsn/app/views/users/getall.html.tpl \
          limsn/app/views/users/unlicensed.html.tpl \
          limsn/app/views/users/test.html.tpl \
          limsn/app/views/users/entry.html.tpl \
          limsn/app/views/users/get.html.tpl \
          limsn/app/views/.gitkeep \
          limsn/app/controllers/login.scm \
          limsn/app/controllers/sessions.scm \
          limsn/app/controllers/users.scm \
          limsn/app/controllers/target.scm \
          limsn/app/controllers/plate.scm \
          limsn/app/controllers/hitlist.scm \
          limsn/app/controllers/assayrun.scm \
          limsn/app/controllers/.gitkeep \
          limsn/app/controllers/plateset.scm \
          limsn/app/controllers/utilities.scm \
          limsn/app/controllers/layout.scm \
          limsn/app/controllers/project.scm \
          limsn/app/api/v1.scm \
          limsn/app/.gitkeep \
          limsn/sys/pages/301.html \
          limsn/sys/pages/warn-the-client.tpl \
          limsn/sys/pages/408.html \
          limsn/sys/pages/405.html \
          limsn/sys/pages/400.html \
          limsn/sys/pages/502.html \
          limsn/sys/pages/403.html \
          limsn/sys/pages/.gitkeep \
          limsn/sys/pages/205.html \
          limsn/sys/pages/500.html \
          limsn/sys/pages/504.html \
          limsn/sys/pages/503.html \
          limsn/sys/pages/419.html \
          limsn/sys/pages/401.html \
          limsn/sys/pages/updating.html \
          limsn/sys/pages/404.html \
          limsn/sys/pages/426.html \
          limsn/sys/.gitkeep \
          limsn/pub/plateset/addpsstep2.js \
          limsn/pub/plateset/impdata.js \
          limsn/pub/plateset/getps.js \
          limsn/pub/plateset/reformatps.js \
          limsn/pub/plateset/impbc.js \
          limsn/pub/plateset/addps.js \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.foundation.min.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.bootstrap.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.dataTables.min.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.bootstrap.min.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.semanticui.min.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.bootstrap4.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.jqueryui.min.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.dataTables.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.bootstrap4.min.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.semanticui.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.jqueryui.css \
          limsn/pub/FixedHeader-3.1.8/css/fixedHeader.foundation.css \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.bootstrap4.min.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.jqueryui.min.js \
          limsn/pub/FixedHeader-3.1.8/js/dataTables.fixedHeader.min.js \
          limsn/pub/FixedHeader-3.1.8/js/dataTables.fixedHeader.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.semanticui.min.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.jqueryui.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.dataTables.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.semanicui.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.bootstrap.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.bootstrap4.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.foundation.min.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.bootstrap.min.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.semanticui.js \
          limsn/pub/FixedHeader-3.1.8/js/fixedHeader.foundation.js \
          limsn/pub/JSZip-2.5.0/jszip.min.js \
          limsn/pub/JSZip-2.5.0/jszip.js \
          limsn/pub/Bootstrap-4-4.1.1/css/bootstrap.css \
          limsn/pub/Bootstrap-4-4.1.1/css/bootstrap.min.css.map \
          limsn/pub/Bootstrap-4-4.1.1/css/bootstrap.min.css \
          limsn/pub/Bootstrap-4-4.1.1/css/bootstrap.css.map \
          limsn/pub/Bootstrap-4-4.1.1/js/bootstrap.min.js \
          limsn/pub/Bootstrap-4-4.1.1/js/bootstrap.js \
          limsn/pub/img/upload/.gitkeep \
          limsn/pub/img/arrow-left-circle-green-512.png \
          limsn/pub/img/checkmark.png \
          limsn/pub/img/las-walpha.png \
          limsn/pub/img/sort_desc.png \
          limsn/pub/img/sort_both.png \
          limsn/pub/img/las-nav-bar.png \
          limsn/pub/img/notallowed.png \
          limsn/pub/img/sort_desc_disabled.png \
          limsn/pub/img/.gitkeep \
          limsn/pub/img/las.png \
          limsn/pub/img/sort_asc.png \
          limsn/pub/img/sort_asc_disabled.png \
          limsn/pub/hitlist/showfile.js \
          limsn/pub/tmp/.gitkeep \
          limsn/pub/Buttons-1.6.5/css/buttons.bootstrap4.min.css \
          limsn/pub/Buttons-1.6.5/css/buttons.dataTables.min.css \
          limsn/pub/Buttons-1.6.5/css/mixins.scss \
          limsn/pub/Buttons-1.6.5/css/buttons.semanticui.css \
          limsn/pub/Buttons-1.6.5/css/buttons.foundation.min.css \
          limsn/pub/Buttons-1.6.5/css/buttons.semanticui.min.css \
          limsn/pub/Buttons-1.6.5/css/buttons.jqueryui.css \
          limsn/pub/Buttons-1.6.5/css/buttons.bootstrap.min.css \
          limsn/pub/Buttons-1.6.5/css/buttons.jqueryui.min.css \
          limsn/pub/Buttons-1.6.5/css/buttons.foundation.css \
          limsn/pub/Buttons-1.6.5/css/buttons.bootstrap4.css \
          limsn/pub/Buttons-1.6.5/css/common.scss \
          limsn/pub/Buttons-1.6.5/css/buttons.dataTables.css \
          limsn/pub/Buttons-1.6.5/css/buttons.bootstrap.css \
          limsn/pub/Buttons-1.6.5/swf/flashExport.swf \
          limsn/pub/Buttons-1.6.5/js/buttons.bootstrap.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.foundation.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.print.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.flash.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.bootstrap4.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.print.js \
          limsn/pub/Buttons-1.6.5/js/buttons.semanticui.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.html5.js \
          limsn/pub/Buttons-1.6.5/js/buttons.jqueryui.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.bootstrap4.js \
          limsn/pub/Buttons-1.6.5/js/buttons.colVis.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.bootstrap.js \
          limsn/pub/Buttons-1.6.5/js/buttons.colVis.js \
          limsn/pub/Buttons-1.6.5/js/dataTables.buttons.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.semanticui.js \
          limsn/pub/Buttons-1.6.5/js/dataTables.buttons.js \
          limsn/pub/Buttons-1.6.5/js/buttons.jqueryui.js \
          limsn/pub/Buttons-1.6.5/js/buttons.flash.js \
          limsn/pub/Buttons-1.6.5/js/buttons.html5.min.js \
          limsn/pub/Buttons-1.6.5/js/buttons.foundation.js \
          limsn/pub/layout/upload.js \
          limsn/pub/layout/select.js \
          limsn/pub/css/navbar.css \
          limsn/pub/css/.gitkeep \
          limsn/pub/css/common.scss \
          limsn/pub/pdfmake-0.1.36/pdfmake.js \
          limsn/pub/pdfmake-0.1.36/pdfmake.min.js.map \
          limsn/pub/pdfmake-0.1.36/pdfmake.min.js \
          limsn/pub/pdfmake-0.1.36/vfs_fonts.js \
          limsn/pub/target/addtrglyt.js \
          limsn/pub/target/showfile.js \
          limsn/pub/DataTables-1.10.23/images/sort_desc.png \
          limsn/pub/DataTables-1.10.23/images/sort_both.png \
          limsn/pub/DataTables-1.10.23/images/sort_desc_disabled.png \
          limsn/pub/DataTables-1.10.23/images/sort_asc.png \
          limsn/pub/DataTables-1.10.23/images/sort_asc_disabled.png \
          limsn/pub/DataTables-1.10.23/css/jquery.dataTables.min.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.jqueryui.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.bootstrap.min.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.semanticui.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.foundation.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.bootstrap4.min.css \
          limsn/pub/DataTables-1.10.23/css/jquery.dataTables.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.bootstrap4.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.bootstrap.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.semanticui.min.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.jqueryui.min.css \
          limsn/pub/DataTables-1.10.23/css/dataTables.foundation.min.css \
          limsn/pub/DataTables-1.10.23/js/dataTables.jqueryui.min.js \
          limsn/pub/DataTables-1.10.23/js/jquery.dataTables.js \
          limsn/pub/DataTables-1.10.23/js/jquery.dataTables.min.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.bootstrap.min.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.foundation.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.semanticui.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.jqueryui.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.bootstrap4.min.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.bootstrap.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.foundation.min.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.semanticui.min.js \
          limsn/pub/DataTables-1.10.23/js/dataTables.bootstrap4.js \
          limsn/pub/js/.gitkeep \
          limsn/pub/js/clipboard.min.js \
          limsn/pub/js/menufunctions.js \
          limsn/pub/js/js.cookie.min.js \
          limsn/pub/jQuery-3.3.1/jquery-3.3.1.min.js \
          limsn/pub/jQuery-3.3.1/jquery-3.3.1.js \
          limsn/pub/footer.tpl \
          limsn/pub/loginfooter.tpl \
          limsn/pub/header.tpl \
          limsn/pub/loginheader.tpl \
          limsn/pub/.gitkeep \
          limsn/pub/favicon.ico \
          limsn/conf/README \
          limsn/conf/.gitkeep \
          limsn/conf/artanis.conf \
          limsn/postgres/initdb.sql \
          limsn/postgres/pg_hba.conf \
          limsn/postgres/example-data.sql \
          limsn/postgres/drop-func-tables.sql \
          limsn/postgres/postgresql.conf \
          limsn/postgres/initdba.sql \
          limsn/postgres/pg_ident.conf \
          limsn/postgres/initdbb.sql \
          limsn/postgres/create-db.sql \
          limsn/.route \
          limsn/README \
          limsn/Rplots.pdf \
          limsn/ENTRY \
          limsn.scm

TESTS = 

TEST_EXTENSIONS = .scm
SCM_LOG_DRIVER =                                \
  $(top_builddir)/pre-inst-env                  \
  $(GUILE) --no-auto-compile -e main            \
      $(top_srcdir)/build-aux/test-driver.scm

# Tell 'build-aux/test-driver.scm' to display only source file names,
# not indivdual test names.
AM_SCM_LOG_DRIVER_FLAGS = --brief=yes

AM_SCM_LOG_FLAGS = --no-auto-compile -L "$(top_srcdir)"

AM_TESTS_ENVIRONMENT = abs_top_srcdir="$(abs_top_srcdir)"

info_TEXINFOS = doc/version.texi \
                doc/limsn.texi
dvi: # Don't build dvi docs

EXTRA_DIST += AUTHORS \
              NEWS \
              doc/syscrat.org \
              doc/overview.org \
              doc/version.info \
              doc/las.png \
              doc/.dirstamp \
              doc/stamp-vti \
              doc/lnserver.info \
              COPYING \
              HACKING \
              README \
              README.org \
              hall.scm \
              .gitignore \
              guix.scm \
              build-aux/test-driver.scm \
              ./scripts/*.sh \
              $(TESTS)

ACLOCAL_AMFLAGS = -I m4

clean-go:
	-$(RM) $(GOBJECTS)
.PHONY: clean-go

CLEANFILES =					\
  $(GOBJECTS)					\
  $(TESTS:tests/%.scm=%.log)
