 
  (define-module (limsn)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages aspell)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages avahi)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages disk)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages gperf)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages hurd)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libunistring)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages man)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mes)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages noweb)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages search)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages slang)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages swig)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system guile)
  #:use-module (guix utils)
  #:use-module ((guix build utils) #:select (alist-replace))
  #:use-module (ice-9 match)
 ; #:use-module (artanis artanis)
 ; #:use-module (artanis utils)
 ; #:use-module (artanis irregex)
 ; #:use-module (artanis config)  
  #:use-module (dbi dbi)    
  #:use-module ((srfi srfi-1) #:select (alist-delete)))




(define-public artanis-052
  (package
    (name "artanis")
    (version "0.5.2")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://gnu/artanis/artanis-0.5.tar.gz"))
              (sha256
               (base32
                "1vk1kp2xhz35xa5n27cxlq9c88wk6qm7fqaac8rb0pb6k9pvsv7v"))
              (modules '((guix build utils)))
              (snippet
               '(begin
                  ;; Unbundle guile-redis and guile-json
                  (delete-file-recursively "artanis/third-party/json.scm")
                  (delete-file-recursively "artanis/third-party/json")
                  (delete-file-recursively "artanis/third-party/redis.scm")
                  (delete-file-recursively "artanis/third-party/redis")
                  (substitute* '("artanis/artanis.scm"
                                 "artanis/lpc.scm"
                                 "artanis/oht.scm")
                    (("(#:use-module \\()artanis third-party (json\\))" _
                      use-module json)
                     (string-append use-module json)))
                  (substitute* '("artanis/lpc.scm"
                                 "artanis/session.scm")
                    (("(#:use-module \\()artanis third-party (redis\\))" _
                      use-module redis)
                     (string-append use-module redis)))
                  (substitute* "artanis/oht.scm"
                    (("([[:punct:][:space:]]+)(->json-string)([[:punct:][:space:]]+)"
                      _ pre json-string post)
                     (string-append pre
                                    "scm" json-string
                                    post)))
		  (substitute* '("artanis/oht.scm"
			       "artanis/session.scm"
			       "artanis/cookie.scm")
			       (("3600") "(get-conf '(cookie expire))"))
		
				  (substitute* "artanis/config.scm"
			       (("   \\(\\('debug rest ...\\) \\(parse-namespace-debug rest\\)\\)")
				"   (('debug rest ...) (parse-namespace-debug rest))\n    (('cookie rest ...) (parse-namespace-cookie rest))"
				))
		  (substitute* "artanis/config.scm"		
			       ((" \\(else \\(error parse-namespace-cache \"Config: Invalid item\" item\\)\\)\\)\\)")
				"(else (error parse-namespace-cache \"Config: Invalid item\" item))))\n\n(define (parse-namespace-cookie item)\n  (match item\n    (('expire expire) (conf-set! '(cookie expire) (->integer expire)))\n    (('maxplates maxplates) (conf-set! '(cookie maxplates) (->integer maxplates)))\n    (else (error parse-namespace-cookie \"Config: Invalid item\" item))))"))

		   (substitute* "artanis/config.scm"
		   	       (("debug.monitor = <PATHs>\")")
		   		"debug.monitor = <PATHs>\")\n ((cookie expire)\n       3600\n      \"Cookie expiration time in seconds.\n       1 hour is 3600\n       6 hours 21600\n       1 month 2592000\n cookie.expire = <integer>\")\n\n ((cookie maxplates)\n       10\n      \"Maximum number of plates per plate-set.\n cookie.maxplates = <integer>\")"))
		  

		   (substitute* "artanis/config.scm"
		   		(("format #f \"http://~a:~a\" \\(get-conf '\\(host addr\\)\\)")
		   	 	 "format #f \"http://~a:~a\" real-host"))
		   
		   (substitute* "artanis/artanis.scm"
		   		(("               static-page-emitter\n")
		   		  "               static-page-emitter\n               current-myhost\n"))
	;;============START forguix mods=========================================================================
	
		   (substitute* "artanis/commands/work.scm"			      			       
				(("\\(let \\(\\(entry \\(string-append \\(current-toplevel\\) \"/\" \\*artanis-entry\\*\\)\\)\\)")
				 "(let ((entry (string-append (original-current-toplevel) \"/\" *artanis-entry*)))")
				(("\\(add-to-load-path \\(current-toplevel\\)\\)")
				 "(add-to-load-path (original-current-toplevel))")
				(("\\(add-to-load-path \\(string-append \\(current-toplevel\\) \"/lib\"\\)\\)")
				 "(add-to-load-path (string-append (original-current-toplevel) \"/lib\"))"))		
		   (substitute* '("artanis/tpl/parser.scm"
				  "artanis/mvc/controller.scm"
				  "artanis/webapi/restful.scm")			      			       
				(("current-toplevel")
				"original-current-toplevel"))				
		   (substitute* "artanis/utils.scm"			      			       
				(("\\(let\\* \\(\\(toplevel \\(current-toplevel\\)\\)")
				 "(let* ((toplevel (original-current-toplevel))")
				(("\\(current-toplevel\\) file\\)\\)\\)")
				"(original-current-toplevel) file)))")
				(("\\(if \\(current-toplevel\\)")
				 "(if (original-current-toplevel)")
				(("\\(format \\#f \"~a/pub/~a\" \\(current-toplevel\\) path\\)")
				 "(format #f \"~a/pub/~a\" (original-current-toplevel) path)"))				
		   (substitute* "artanis/env.scm"			      			       
				(("            current-toplevel\n")
				 "            current-toplevel\n            %original-current-toplevel\n            original-current-toplevel\n")
				(("\\(define \\(current-toplevel\\)\n")
					 "(define %original-current-toplevel (make-parameter #f))\n")
				(("  \\(or \\(%current-toplevel\\)\n")
					 "  (define (original-current-toplevel)\n")
				(("      \\(find-ENTRY-path identity #t\\)\\)\\)\n")
				 "     (or (%original-current-toplevel)\n         (find-ENTRY-path identity #t)))\n\n(define (current-toplevel) \"/tmp/limsn\")"))
	;;============END forguix mods=========================================================================
				   
                   (substitute* "artanis/artanis.scm"
                    (("[[:punct:][:space:]]+->json-string[[:punct:][:space:]]+")
                     ""))
                  #t)
	       )))
    (build-system gnu-build-system)
    (inputs
     `(("guile" ,guile-3.0)
       ("nss" ,nss)
       ("nspr" ,nspr)))
    ;; FIXME the bundled csv contains one more exported procedure
    ;; (sxml->csv-string) than guile-csv. The author is maintainer of both
    ;; projects.
    ;; TODO: Add guile-dbi and guile-dbd optional dependencies.
    (propagated-inputs
     `(("guile-json" ,guile-json-3) 
       ("guile-readline" ,guile-readline)
       ("guile-redis" ,guile-redis)))
    (native-inputs
     `(("bash"       ,bash)         ;for the `source' builtin
       ("pkgconfig"  ,pkg-config)
       ("util-linux" ,util-linux))) ;for the `script' command
    (arguments
     '(#:make-flags
       ;; TODO: The documentation must be built with the `docs' target.
       (let* ((out (assoc-ref %outputs "out"))
              (scm (string-append out "/share/guile/site/3.0"))
              (go  (string-append out "/lib/guile/3.0/site-ccache")))
         ;; Don't use (%site-dir) for site paths.
         (list (string-append "MOD_PATH=" scm)
               (string-append "MOD_COMPILED_PATH=" go)))
       #:test-target "test"
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'patch-site-dir
           (lambda* (#:key outputs #:allow-other-keys)
             (substitute* "artanis/commands/help.scm"
               (("\\(%site-dir\\)")
                (string-append "\""
                               (assoc-ref outputs "out")
                               "/share/guile/site/3.0\"")))))
         (add-after 'unpack 'patch-reference-to-libnss
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* "artanis/security/nss.scm"
               (("ffi-binding \"libnss3\"")
                (string-append
                 "ffi-binding \""
                 (assoc-ref inputs "nss") "/lib/nss/libnss3.so" ;;/lib/nss in original
		 "\""))
               (("ffi-binding \"libssl3\"")
                (string-append "ffi-binding \""
			       (assoc-ref inputs "nss") "/lib/nss/libssl3.so"  ;; /lib/nss in original
                 "\"")))
             #t))
         (add-before 'install 'substitute-root-dir
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((out  (assoc-ref outputs "out")))
               (substitute* "Makefile"   ;ignore the execution of bash.bashrc
                 ((" /etc/bash.bashrc") " /dev/null"))
               (substitute* "Makefile"   ;set the root of config files to OUT
                 ((" /etc") (string-append " " out "/etc")))
               (mkdir-p (string-append out "/bin")) ;for the `art' executable
               #t)))
         (add-after 'install 'wrap-art
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (bin (string-append out "/bin"))
                    (scm (string-append out "/share/guile/site/3.0"))
                    (go  (string-append out "/lib/guile/3.0/site-ccache")))
               (wrap-program (string-append bin "/art")
                 `("GUILE_LOAD_PATH" ":" prefix
                   (,scm ,(getenv "GUILE_LOAD_PATH")))
                 `("GUILE_LOAD_COMPILED_PATH" ":" prefix
                   (,go ,(getenv "GUILE_LOAD_COMPILED_PATH"))))
               #t))))))
    (synopsis "Web application framework written in Guile, modified for LIMS*Nucleus")
    (description "GNU Artanis is a web application framework written in Guile
Scheme.  A web application framework (WAF) is a software framework that is
designed to support the development of dynamic websites, web applications, web
services and web resources.  The framework aims to alleviate the overhead
associated with common activities performed in web development.  Artanis
provides several tools for web development: database access, templating
frameworks, session management, URL-remapping for RESTful, page caching, and
more. v0.5.1 contains feature enhancements required by LIMS*Nucleus")
    (home-page "https://www.gnu.org/software/artanis/")
    (license (list license:gpl3+ license:lgpl3+)))) ;dual license


  (package
    (name "limsn")
    (version "0.1.0")
;   (source "/home/admin/limsn-0.1.tar.gz")
   (source (origin
            (method url-fetch)
            (uri (string-append "file:///home/mbc/syncd/tobedeleted/limsn/limsn-0.1.tar.gz"))
            (sha256
             (base32
              "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i"))))
   (build-system gnu-build-system)
  (arguments `(#:tests? #false ; there are none
			#:phases (modify-phases %standard-phases
    		       (add-after 'unpack 'patch-prefix
			       (lambda* (#:key inputs outputs #:allow-other-keys)
				 (substitute* '("./limsn/lib/labsolns/lnpg.scm"
						"./scripts/start-limsn.sh"
						"./scripts/init-ln.sh"
						"./limsn/ENTRY")						
						(("abcdefgh")
						(assoc-ref outputs "out" )) )
				 #t))		       			       
		(add-after 'unpack 'augment-GUILE_LOAD_PATH
			   (lambda _
			     (setenv "GUILE_LOAD_PATH"
				     (string-append "./limsn/lib:"
						    (getenv "GUILE_LOAD_PATH")))
			     #t))
                       (add-before 'install 'make-lib-dir
			       (lambda* (#:key outputs #:allow-other-keys)
				    (let* ((out  (assoc-ref outputs "out"))
					   (lib-dir (string-append out "/share/guile/site/3.0/limsn/lib"))
					   (dummy (mkdir-p lib-dir)))            				       
				       (copy-recursively "./limsn/lib" lib-dir)
				       #t)))
		       (add-after 'unpack 'make-dir
				   (lambda* (#:key outputs #:allow-other-keys)
				     (let* ((out  (assoc-ref outputs "out"))
					   (labsolns-dir (string-append out "/labsolns"))
					   (mkdir-p labsolns-dir)
					   (dummy (copy-recursively "./limsn/lib/labsolns" labsolns-dir))) 
				       #t)))

                       (add-before 'install 'make-scripts-dir
			       (lambda* (#:key outputs #:allow-other-keys)
				    (let* ((out  (assoc-ref outputs "out"))
					   (scripts-dir (string-append out "/share/guile/site/3.0/limsn/scripts"))
					;;   (scripts-dir (string-append out "/scripts"))
					   (dummy (mkdir-p scripts-dir)))            				       
				       (copy-recursively "./scripts" scripts-dir)
				       #t)))
		       (add-after 'install 'make-bin-dir
				  (lambda* (#:key inputs outputs #:allow-other-keys)
				    (let* ((out (assoc-ref outputs "out"))
					   (bin-dir (string-append out "/share/guile/site/3.0/limsn/bin"))
					   (dummy (install-file "limsn/bin/start-limsn.sh" bin-dir))				
					   (dummy (chmod (string-append bin-dir "/start-limsn.sh") #o555 ))) ;;read execute, no write
				      (wrap-program (string-append bin-dir "/start-limsn.sh")
						    `( "PATH" ":" prefix  (,bin-dir) ))		    
				      #t)))				      				     				      			    		 		             
		       )))
    (inputs
     `(("guile" ,guile-3.0)
       ("gnuplot" ,gnuplot)
       ("guile-dbi" ,guile-dbi)
       ))
       (propagated-inputs
	`(
	  ("artanis" ,artanis-052)
		))
    (native-inputs
     `(("bash"       ,bash)         ;for the `source' builtin
       ("pkgconfig"  ,pkg-config)
       ("autoconf" ,autoconf)
       ("automake" ,automake)
       ("texinfo" ,texinfo)
       ("util-linux" ,util-linux))) ;for the `script' command

    (synopsis "Microwell Plate management Software")
    (description "description")
    (home-page "http://www.labsolns.com/")
    (license (list license:gpl3+ license:lgpl3+))) ;dual license




