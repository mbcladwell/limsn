;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!
(add-to-load-path "/home/mbc/projects/limsn")
(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(srfi srfi-19)(dbi dbi) (labsolns artass)
	     (ice-9 pretty-print)(artanis artanis)(artanis cookie)
	     (labsolns artass)
	     (artanis config))

(test-define page1
	     (options
	      ;;#:conn #t
	      #:cookies '(names prjid sid) 
	      #:auth '(table person "lnuser" "passwd" "salt" ,my-hmac)
	      #:session #t
	      )
	     (lambda (rc)
	       (let* (
		      (dummy (:auth rc))
		      (server-check (:session rc 'check))
		     ;; (server-check #f)
		     ;; (dummy (if server-check #f (:session rc 'spawn)))
		      (sid (:cookies-value rc "sid"))
		      (prjid-check (:cookies-value rc "prjid"))
		      (nplates maxnumplates)
		    ;;  (nplates (get-conf '(cookie maxplates)))
		      
		      )
   (view-render "page1" (the-environment)))
	       ))

;; select * from Sessions  where sid='d4eeaa2682faad3295646a287ec431ee' and valid='1' limit 1 ;

(post "/test/page1action"
        #:session #t
	#:cookies '(names prjid sid )
      (lambda (rc)
	(let* (;;note all 3 command required to set cookie
	       (dummy (:cookies-set! rc 'prjid "prjid" (:cookies-value rc "prjid")))
	     ;;  (dummy (:cookies-remove! rc 'prjid ))
	       (dummy (:cookies-set! rc 'prjid "prjid" "123"))
	       (dummy (:cookies-setattr! rc 'prjid #:path "/"))				  	      	   
		   )   
	  (redirect-to rc  (get-redirect-uri "/test/page2"))	   
		     )))

;; (post "/test/page1action"
;; 		 (lambda (rc)
;; 		     (redirect-to rc  "/test/page2")
;; 		     ))

(test-define page2
	     (options  #:session #t
		       #:cookies '(names prjid sid ))
	       (lambda (rc)
	       (let* ((server-check (:session rc 'check))
		      (sid (:cookies-value rc "sid"))
		      (prjid-check (:cookies-value rc "prjid"))
		      (confy  (number->string (get-conf '(cookie expire))))
	   	      )
   (view-render "page2" (the-environment))
  )))

