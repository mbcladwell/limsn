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

(define-public limsn
  (package
    (name "limsn")
    (version "0.1.0")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://gnu/artanis/artanis-0.5.tar.gz"))
              (sha256
               (base32
                "1vk1kp2xhz35xa5n27cxlq9c88wk6qm7fqaac8rb0pb6k9pvsv7v"))
              (modules '((guix build utils)))
              ))
    (build-system gnu-build-system)
    (inputs
     `(("guile" ,guile-3.0)
     
       ))
  
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
    (synopsis "Microwell Plate management Software")
    (description "description")
    (home-page "http://www.labsolns.com/")
    (license (list license:gpl3+ license:lgpl3+)))) ;dual license

limsn


