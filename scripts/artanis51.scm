(use-modules
  (guix packages)
  ((guix licenses) #:prefix license:)
  (guix download)
  (guix build-system gnu)
  (guix profiles)
  (gnu packages)
  (gnu packages autotools)
  (gnu packages guile)
  (gnu packages guile-xyz)
  (gnu packages pkg-config)
  (gnu packages texinfo)
  (gnu packages bash)
  (gnu packages linux)
  (gnu packages databases)
  (gnu packages nss)
  (gnu packages tls)
  (gnu packages libffi)
  (gnu packages crypto)
  (gnutls)
)

(define-public artanis
  (package
    (name "artanis")
    (version "0.5.1")
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
    (synopsis "Web application framework written in Guile")
    (description "GNU Artanis is a web application framework written in Guile
Scheme.  A web application framework (WAF) is a software framework that is
designed to support the development of dynamic websites, web applications, web
services and web resources.  The framework aims to alleviate the overhead
associated with common activities performed in web development.  Artanis
provides several tools for web development: database access, templating
frameworks, session management, URL-remapping for RESTful, page caching, and
more.")
    (home-page "https://www.gnu.org/software/artanis/")
    (license (list license:gpl3+ license:lgpl3+)))) ;dual license

artanis

