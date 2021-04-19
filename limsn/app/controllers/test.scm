;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!
(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(srfi srfi-19)(dbi dbi) (labsolns artass)
	     (ice-9 pretty-print))

(test-define page1
	     (options #:session #t
		       #:cookies '(names prjid sid ))
	     (lambda (rc)
	       (let* ((server-check (:session rc 'check))
		      
		      (sid (:cookies-value rc "sid"))
		      (prjid-check (:cookies-value rc "prjid"))
		      )
   (view-render "page1" (the-environment)))
  ))

(post "/test/page1action"
      (lambda (rc)
	(let* (
	       (dummy (:cookies-set! rc 'prjid "prjid" (:cookies-value rc "prjid")))
	       (dummy (:cookies-remove! rc 'prjid ))
	       (dummy (:cookies-set! rc 'prjid "prjid" "1"))
	       (dummy (:cookies-setattr! rc 'prjid #:path "/"))				  	      	   
		   )   
	  (redirect-to rc  (get-redirect-uri "/test/page2"))	   
		     )))

;; (post "/test/page1action"
;; 		 (lambda (rc)
;; 		     (redirect-to rc  "/test/page2")
;; 		     ))

(test-define page2
	       (lambda (rc)
	       (let* ((server-check (:session rc 'check))
		      (sid (:cookies-value rc "sid"))
		      (prjid-check (:cookies-value rc "prjid"))
		      )
   (view-render "page2" (the-environment))
  )))

