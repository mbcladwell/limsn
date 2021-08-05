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
  (guix git-download)
  (gnutls)
)

(define-public limsn
  (package
    (name "limsn")
    (version "0.1.0")
    (source (origin
	      (method git-fetch)
	   (uri (git-reference 
		 (url "https://github.com/mbcladwell/limsn.git")
		 (commit "8669fbe0ef30bac94bc86d866b91cffcdd2bf7c1")))    
              (sha256
               (base32
                "1a5lbdby17vdvn67nqrm0k9zq8kpg4wi3s25v9bcn6wp6zxz1936"))
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
   
    (synopsis "Microwell Plate management Software")
    (description "description")
    (home-page "http://www.labsolns.com/")
    (license (list license:gpl3+ license:lgpl3+)))) ;dual license

limsn


