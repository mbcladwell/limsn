(use-modules
  (guix packages)
  ((guix licenses) #:prefix license:)
  (guix download)
  (guix build-system gnu)
;;  (guix build-system guile)
  (guix profiles)
  (gnu packages)
  (gnu packages autotools)
  (gnu packages guile)
  ;;  (gnu packages guile-xyz)
  (artanis artanis)
  (artanis utils)
  (gnu packages pkg-config)
  (gnu packages texinfo)
  (gnu packages bash)
  (gnu packages linux)
  (gnu packages databases)
;;  (gnu packages nss)
;;  (gnu packages tls)
;;  (gnu packages libffi)
;;  (gnu packages crypto)
  (guix git-download)
  (gnutls)
 
)

(define-public limsn
  (package
    (name "limsn")
    (version "0.1.0")
    (source (origin
	     ;; (method git-fetch)
	     ;; (uri (git-reference 
	     ;; 	   (url "https://github.com/mbcladwell/limsn.git")
	     ;; 	   (commit "8669fbe0ef30bac94bc86d866b91cffcdd2bf7c1")))    
             ;; (sha256
             ;;  (base32
             ;;   "11p4bgi8fvnzhxb1x73sndkrhr7yyj4hyhx8s8zf2f1mdvkd4ahs"))
	     
	      (method url-fetch)
	     (uri "file:///home/mbc/projects/limsn/limsn-0.1.tar.gz")    
             (sha256
	     
              (base32
               "1a5lbdby17vdvn67nqrm0k9zq8kpg4wi3s25v9bcn6wp6zxz1936"))

             (modules '((guix build utils)))
              ))
    (build-system gnu-build-system)
    (inputs
     `(("guile" ,guile-3.0)
  ;;     ("nss" ,nss)
   ;;    ("nspr" ,nspr)
       ))
       (propagated-inputs
	      `(
	;;(guile-readline" ,guile-readline)
             ("artanis@0.5.1" ,artanis)
      
          ))
    (native-inputs
     `(("bash"       ,bash)         ;for the `source' builtin
       ("pkgconfig"  ,pkg-config)
       ("util-linux" ,util-linux))) ;for the `script' command


 ;; (arguments
 ;;     '(#:make-flags
 ;;       ;; TODO: The documentation must be built with the `docs' target.
 ;;       (let* ((out (assoc-ref %outputs "out"))
 ;;              (scm (string-append out "/share/guile/site/3.0"))
 ;;              (go  (string-append out "/lib/guile/3.0/site-ccache")))
 ;;         ;; Don't use (%site-dir) for site paths.
 ;;         (list (string-append "MOD_PATH=" scm)
 ;;               (string-append "MOD_COMPILED_PATH=" go)))
 ;;       #:test-target "test"
 ;;       #:phases
 ;;       (modify-phases %standard-phases
            
 ;;         (add-before 'install 'substitute-root-dir
 ;;           (lambda* (#:key outputs #:allow-other-keys)
 ;;             (let ((out  (assoc-ref outputs "out")))
 ;;               (substitute* "Makefile"   ;ignore the execution of bash.bashrc
 ;;                 ((" /etc/bash.bashrc") " /dev/null"))
 ;;               (substitute* "Makefile"   ;set the root of config files to OUT
 ;;                 ((" /etc") (string-append " " out "/etc")))
 ;;               (mkdir-p (string-append out "/bin")) ;for the `art' executable
 ;;               #t)))
 ;; 	 ;; (add-after 'set-paths 'mod-paths
 ;; 	 ;; 	    (lambda* (#:key inputs outputs #:allow-other-keys)
 ;; 	 ;; 	      (let (
 ;; 	 ;; 		    (dummy (set "/gnu/store/yk3zw1pqbs5wlf1lapf25986yjd0g736-autoconf-2.69/bin")))		
 ;; 	 ;; 		#true)))
 ;;         (add-after 'install 'wrap-art
 ;;           (lambda* (#:key inputs outputs #:allow-other-keys)
 ;;             (let* ((out (assoc-ref outputs "out"))
 ;;                    (bin (string-append out "/bin"))
 ;;                    (scm (string-append out "/share/guile/site/3.0"))
 ;;                    (go  (string-append out "/lib/guile/3.0/site-ccache")))
 ;;               (wrap-program (string-append bin "/art")
 ;;                 `("GUILE_LOAD_PATH" ":" prefix
 ;;                   (,scm ,(getenv "GUILE_LOAD_PATH")))
 ;;                 `("GUILE_LOAD_COMPILED_PATH" ":" prefix
 ;;                   (,go ,(getenv "GUILE_LOAD_COMPILED_PATH"))))
 ;;               #t))))))

    
    (synopsis "Microwell Plate management Software")
    (description "description")
    (home-page "http://www.labsolns.com/")
    (license (list license:gpl3+ license:lgpl3+)))) ;dual license

limsn


