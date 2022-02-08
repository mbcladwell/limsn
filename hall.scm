(hall-description
  (name "limsn")
  (prefix "")
  (version "0.1")
  (author "mbc")
  (copyright (2022))
  (synopsis "")
  (description "")
  (home-page "www.labsolns.com")
  (license gpl3+)
  (dependencies `())
  (skip ())
  (files (libraries
           ((directory
              "limsn"
              ((directory
                 "lib"
                 ((directory
                    "labsolns"
                    ((scheme-file "lnpg")
                     (scheme-file "artass")
                     (scheme-file "gplot")))))
               (directory
                 "app"
                 ((directory
                    "views"
                    ((directory
                       "plateset"
                       ((template-file "addstep2.html")
                        (template-file "add.html")
                        (template-file "worklist.html")
                        (template-file "reformatconfirm.html")
                        (template-file "impdata.html")
                        (template-file "testcset.html")
                        (template-file "impbc.html")
                        (template-file "grouperror.html")
                        (template-file "editps.html")
                        (template-file "test2.html")
                        (template-file "impaccs.html")
                        (template-file "test.html")
                        (template-file "reformatps.html")
                        (template-file "impdataaction.html")
                        (template-file "groupps.html")
                        (template-file "getps.html")))
                     (directory
                       "sessions"
                       ((template-file "notadmin.html")
                        (template-file "getall.html")
                        (template-file "sesschk.html")
                        (template-file "get.html")))
                     (directory
                       "project"
                       ((template-file "add.html")
                        (template-file "notadmin.html")
                        (template-file "getall.html")
                        (template-file "unlicensed.html")
                        (template-file "poster.html")
                        (template-file "test.html")
                        (template-file "edit.html")))
                     (directory
                       "login"
                       ((template-file "getfile.html")
                        (template-file "collect.html")
                        (template-file "test.html")
                        (template-file "login.html")))
                     (directory
                       "assayrun"
                       ((template-file "getarid.html")
                        (template-file "replot.html")
                        (unknown-type "getalldata.bak")
                        (template-file "test.html")
                        (template-file "getforpsid.html")
                        (unknown-type "getarid.html.bak")
                        (template-file "getalldata.html")))
                     (directory
                       "hitlist"
                       ((template-file "addtoar.html")
                        (template-file "forprj.html")
                        (template-file "gethlbyid.html")
                        (template-file "rearraystep2.html")
                        (template-file "importhl.html")
                        (template-file "rearray.html")
                        (template-file "test2.html")
                        (template-file "test.html")
                        (template-file "viewhits.html")
                        (template-file "gethlforarid.html")))
                     (directory
                       "layout"
                       ((template-file "lytbyid.html")
                        (template-file "getall.html")
                        (template-file "select.html")
                        (template-file "upload.html")
                        (template-file "viewlayout.html")
                        (template-file "test.html")
                        (template-file "import.html")
                        (template-file "success.html")))
                     (directory
                       "test"
                       ((template-file "add.html")
                        (template-file "logtest.html")
                        (template-file "sessiontest.html")
                        (template-file "page2.html")
                        (template-file "authtest.html")
                        (template-file "cookietest.html")
                        (template-file "page1.html")
                        (template-file "test.html")
                        (template-file "check.html")))
                     (directory
                       "utilities"
                       ((template-file "isreg.html")
                        (template-file "menu.html")
                        (template-file "notadmin.html")
                        (template-file "regform.html")
                        (template-file "register.html")
                        (template-file "test.html")
                        (template-file "failreg.html")
                        (template-file "login.html")))
                     (directory
                       "target"
                       ((template-file "addsingle.html")
                        (template-file "getall.html")
                        (template-file "gettrglytbyid.html")
                        (template-file "gettrglyt.html")
                        (template-file "addbulk.html")
                        (javascript-file "addtrglyt")
                        (template-file "test.html")
                        (template-file "addtrglyt.html")))
                     (directory
                       "plate"
                       ((template-file "getwellsforpplt.html")
                        (template-file "getwellsforplt.html")
                        (template-file "getpltforps.html")
                        (template-file "groupplts.html")
                        (template-file "getwellsforps.html")
                        (template-file "test.html")))
                     (directory
                       "users"
                       ((template-file "add.html")
                        (template-file "notadmin.html")
                        (template-file "getall.html")
                        (template-file "unlicensed.html")
                        (template-file "test.html")
                        (template-file "entry.html")
                        (template-file "get.html")))
                     (text-file ".gitkeep")))
                  (directory
                    "controllers"
                    ((scheme-file "login")
                     (scheme-file "sessions")
                     (scheme-file "users")
                     (scheme-file "target")
                     (scheme-file "plate")
                     (scheme-file "hitlist")
                     (scheme-file "assayrun")
                     (text-file ".gitkeep")
                     (scheme-file "plateset")
                     (scheme-file "test")
                     (scheme-file "utilities")
                     (scheme-file "layout")
                     (scheme-file "project")))
                  (directory
                    "api"
                    ((compiled-scheme-file "v1") (scheme-file "v1")))
                  (text-file ".gitkeep")))
               (directory
                 "sys"
                 ((directory
                    "pages"
                    ((html-file "301")
                     (template-file "warn-the-client")
                     (html-file "408")
                     (html-file "405")
                     (html-file "400")
                     (html-file "502")
                     (html-file "403")
                     (text-file ".gitkeep")
                     (html-file "205")
                     (html-file "500")
                     (html-file "504")
                     (html-file "503")
                     (html-file "419")
                     (html-file "401")
                     (html-file "updating")
                     (html-file "404")
                     (html-file "426")))
                  (text-file ".gitkeep")))
               (directory
                 "pub"
                 ((directory
                    "plateset"
                    ((javascript-file "addpsstep2")
                     (javascript-file "impdata")
                     (javascript-file "getps")
                     (javascript-file "reformatps")
                     (javascript-file "impbc")
                     (javascript-file "addps")))
                  (directory
                    "FixedHeader-3.1.8"
                    ((directory
                       "css"
                       ((css-file "fixedHeader.foundation.min")
                        (css-file "fixedHeader.bootstrap")
                        (css-file "fixedHeader.dataTables.min")
                        (css-file "fixedHeader.bootstrap.min")
                        (css-file "fixedHeader.semanticui.min")
                        (css-file "fixedHeader.bootstrap4")
                        (css-file "fixedHeader.jqueryui.min")
                        (css-file "fixedHeader.dataTables")
                        (css-file "fixedHeader.bootstrap4.min")
                        (css-file "fixedHeader.semanticui")
                        (css-file "fixedHeader.jqueryui")
                        (css-file "fixedHeader.foundation")))
                     (directory
                       "js"
                       ((javascript-file "fixedHeader.bootstrap4.min")
                        (javascript-file "fixedHeader.jqueryui.min")
                        (javascript-file "dataTables.fixedHeader.min")
                        (javascript-file "dataTables.fixedHeader")
                        (javascript-file "fixedHeader.semanticui.min")
                        (javascript-file "fixedHeader.jqueryui")
                        (javascript-file "fixedHeader.dataTables")
                        (javascript-file "fixedHeader.semanicui")
                        (javascript-file "fixedHeader.bootstrap")
                        (javascript-file "fixedHeader.bootstrap4")
                        (javascript-file "fixedHeader.foundation.min")
                        (javascript-file "fixedHeader.bootstrap.min")
                        (javascript-file "fixedHeader.semanticui")
                        (javascript-file "fixedHeader.foundation")))))
                  (directory
                    "JSZip-2.5.0"
                    ((javascript-file "jszip.min")
                     (javascript-file "jszip")))
                  (directory
                    "Bootstrap-4-4.1.1"
                    ((directory
                       "css"
                       ((css-file "bootstrap")
                        (unknown-type "bootstrap.min.css.map")
                        (css-file "bootstrap.min")
                        (unknown-type "bootstrap.css.map")))
                     (directory
                       "js"
                       ((javascript-file "bootstrap.min")
                        (javascript-file "bootstrap")))))
                  (directory
                    "img"
                    ((directory "upload" ((text-file ".gitkeep")))
                     (png-file "arrow-left-circle-green-512")
                     (png-file "checkmark")
                     (png-file "las-walpha")
                     (png-file "sort_desc")
                     (png-file "sort_both")
                     (png-file "las-nav-bar")
                     (png-file "notallowed")
                     (png-file "sort_desc_disabled")
                     (text-file ".gitkeep")
                     (png-file "las")
                     (png-file "sort_asc")
                     (png-file "sort_asc_disabled")))
                  (directory
                    "hitlist"
                    ((javascript-file "showfile")))
                  (directory "tmp" ((text-file ".gitkeep")))
                  (directory
                    "Buttons-1.6.5"
                    ((directory
                       "css"
                       ((css-file "buttons.bootstrap4.min")
                        (css-file "buttons.dataTables.min")
                        (unknown-type "mixins.scss")
                        (css-file "buttons.semanticui")
                        (css-file "buttons.foundation.min")
                        (css-file "buttons.semanticui.min")
                        (css-file "buttons.jqueryui")
                        (css-file "buttons.bootstrap.min")
                        (css-file "buttons.jqueryui.min")
                        (css-file "buttons.foundation")
                        (css-file "buttons.bootstrap4")
                        (unknown-type "common.scss")
                        (css-file "buttons.dataTables")
                        (css-file "buttons.bootstrap")))
                     (directory
                       "swf"
                       ((unknown-type "flashExport.swf")))
                     (directory
                       "js"
                       ((javascript-file "buttons.bootstrap.min")
                        (javascript-file "buttons.foundation.min")
                        (javascript-file "buttons.print.min")
                        (javascript-file "buttons.flash.min")
                        (javascript-file "buttons.bootstrap4.min")
                        (javascript-file "buttons.print")
                        (javascript-file "buttons.semanticui.min")
                        (javascript-file "buttons.html5")
                        (javascript-file "buttons.jqueryui.min")
                        (javascript-file "buttons.bootstrap4")
                        (javascript-file "buttons.colVis.min")
                        (javascript-file "buttons.bootstrap")
                        (javascript-file "buttons.colVis")
                        (javascript-file "dataTables.buttons.min")
                        (javascript-file "buttons.semanticui")
                        (javascript-file "dataTables.buttons")
                        (javascript-file "buttons.jqueryui")
                        (javascript-file "buttons.flash")
                        (javascript-file "buttons.html5.min")
                        (javascript-file "buttons.foundation")))))
                  (directory
                    "layout"
                    ((javascript-file "upload")
                     (javascript-file "select")))
                  (directory
                    "css"
                    ((css-file "navbar")
                     (text-file ".gitkeep")
                     (unknown-type "common.scss")))
                  (directory
                    "pdfmake-0.1.36"
                    ((javascript-file "pdfmake")
                     (unknown-type "pdfmake.min.js.map")
                     (javascript-file "pdfmake.min")
                     (javascript-file "vfs_fonts")))
                  (directory
                    "target"
                    ((javascript-file "addtrglyt")
                     (javascript-file "showfile")))
                  (directory
                    "DataTables-1.10.23"
                    ((directory
                       "images"
                       ((png-file "sort_desc")
                        (png-file "sort_both")
                        (png-file "sort_desc_disabled")
                        (png-file "sort_asc")
                        (png-file "sort_asc_disabled")))
                     (directory
                       "css"
                       ((css-file "jquery.dataTables.min")
                        (css-file "dataTables.jqueryui")
                        (css-file "dataTables.bootstrap.min")
                        (css-file "dataTables.semanticui")
                        (css-file "dataTables.foundation")
                        (css-file "dataTables.bootstrap4.min")
                        (css-file "jquery.dataTables")
                        (css-file "dataTables.bootstrap4")
                        (css-file "dataTables.bootstrap")
                        (css-file "dataTables.semanticui.min")
                        (css-file "dataTables.jqueryui.min")
                        (css-file "dataTables.foundation.min")))
                     (directory
                       "js"
                       ((javascript-file "dataTables.jqueryui.min")
                        (javascript-file "jquery.dataTables")
                        (javascript-file "jquery.dataTables.min")
                        (javascript-file "dataTables.bootstrap.min")
                        (javascript-file "dataTables.foundation")
                        (javascript-file "dataTables.semanticui")
                        (javascript-file "dataTables.jqueryui")
                        (javascript-file "dataTables.bootstrap4.min")
                        (javascript-file "dataTables.bootstrap")
                        (javascript-file "dataTables.foundation.min")
                        (javascript-file "dataTables.semanticui.min")
                        (javascript-file "dataTables.bootstrap4")))))
                  (directory
                    "js"
                    ((text-file ".gitkeep")
                     (javascript-file "clipboard.min")
                     (javascript-file "menufunctions")
                     (javascript-file "js.cookie.min")))
                  (directory
                    "jQuery-3.3.1"
                    ((javascript-file "jquery-3.3.1.min")
                     (javascript-file "jquery-3.3.1")))
                  (template-file "footer")
                  (template-file "loginfooter")
                  (template-file "header")
                  (template-file "loginheader")
                  (text-file ".gitkeep")
                  (icon-file "favicon")))
               (directory
                 "conf"
                 ((text-file "README")
                  (text-file ".gitkeep")
                  (configuration-file "artanis")))
               (text-file ".route")
               (scheme-file "manifest")
               (text-file "README")
               (unknown-type "Rplots.pdf")
               (text-file "ENTRY")))
            (scheme-file "limsn")))
         (tests ((directory "tests" ())))
         (programs ((directory "scripts" ())))
         (documentation
           ((text-file "AUTHORS")
            (text-file "NEWS")
            (directory
              "doc"
              ((org-file "syscrat")
               (org-file "overview")
               (texi-file "version")
               (info-file "version")
               (png-file "las")
               (texi-file "limsn")
               (text-file ".dirstamp")
               (text-file "stamp-vti")
               (info-file "lnserver")))
            (text-file "COPYING")
            (text-file "HACKING")
            (symlink "README" "README.org")
            (org-file "README")))
         (infrastructure
           ((scheme-file "hall")
            (text-file ".gitignore")
            (scheme-file "guix")))))
