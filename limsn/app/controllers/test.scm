;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!
(use-modules (labsolns artass))

(test-define page1
	     (options #:session #t
		       #:cookies '(names prjid sid ))
	     (lambda (rc)
	       (let* ((server-check (:session rc 'check))
		      (client-check (:cookies-value rc "sid"))
		     
		     
		      )
   (view-render "page1" (the-environment)))
  ))

(post "/test/page1action"
      (lambda (rc)
	(let* (
	       (dummy (:cookies-set! rc 'prjid "prjid" "1"))
	      	   
		   )   
	  (redirect-to rc  (get-redirect-uri "/test/page2"))	   
		     )))

;; (post "/test/page1action"
;; 		 (lambda (rc)
;; 		     (redirect-to rc  "/test/page2")
;; 		     ))

(test-define page2
  (lambda (rc)
   (view-render "page2" (the-environment))
  ))

