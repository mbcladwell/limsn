(use-modules
  (guix packages)
  ((guix licenses) #:prefix license:)
  (guix download)
  (guix build-system gnu)
  (gnu packages)
  (gnu packages databases)
;;  (labsolns postgresql-client)
 ;; (labsolns artanis)
  (gnu packages autotools)
  (gnu packages guile)
  (gnu packages guile-xyz)
  (gnu packages pkg-config)
  (gnu packages texinfo)
   (gnu packages maths)
  )

(package
  (name "lnpg")
  (version "0.1")
  (source "./lnpg-0.1.tar.gz")
  (build-system gnu-build-system)
  (arguments `(#:tests? #false ; there are none
			#:phases (modify-phases %standard-phases
    		       (add-after 'unpack 'patch-prefix
			       (lambda* (#:key inputs outputs #:allow-other-keys)
				 (substitute* '("scripts/lnpg.sh"
						"lnpg/lnpg.scm")
						(("abcdefgh")
						(assoc-ref outputs "out" )) )
					#t))		    
		       (add-before 'install 'make-scripts-dir
			       (lambda* (#:key outputs #:allow-other-keys)
				    (let* ((out  (assoc-ref outputs "out"))
					   (scripts-dir (string-append out "/scripts"))
					   (bin-dir (string-append out "/bin"))
					   (dummy (install-file "scripts/lnpg.sh" bin-dir))
					   (dummy (mkdir-p scripts-dir)))            				       
				       (copy-recursively "./scripts" scripts-dir)
				       #t)))
		       (add-after 'install 'wrap-lnpg
				  (lambda* (#:key inputs outputs #:allow-other-keys)
				    (let* ((out (assoc-ref outputs "out"))
					   (bin-dir (string-append out "/bin"))
					    (scm  "/share/guile/site/3.0")
					    (go   "/lib/guile/3.0/site-ccache")
					   (dummy (chmod (string-append out "/bin/lnpg.sh") #o555 ))) ;;read execute, no write
				      (wrap-program (string-append out "/bin/lnpg.sh")
						    `( "PATH" ":" prefix  (,bin-dir) )
						     `("GUILE_LOAD_PATH" prefix
						       (,(string-append out scm)))						
						     `("GUILE_LOAD_COMPILED_PATH" prefix
						       (,(string-append out go)))
						     )		    
				      #t)))	       
		       )))
  (native-inputs
    `( 
    ("autoconf" ,autoconf)
      ("automake" ,automake)
      ("pkg-config" ,pkg-config)
      ("texinfo" ,texinfo) 
     ;; ("util-linux" ,util-linux)   
     ))
  (inputs `(("guile" ,guile-3.0)
	    ("gnuplot" ,gnuplot)))
  (propagated-inputs `( ;("artanis" ,artanis)
			("postgresql" ,postgresql)
			;;("postgresql-client" ,postgresql-client)
			))
  (synopsis "")
  (description "")
  (home-page "www.labsolns.com")
  (license license:gpl3+))

