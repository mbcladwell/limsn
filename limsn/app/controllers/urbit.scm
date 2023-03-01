;; Controller login definition of postest
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-module (app controllers urbit)
  #:use-module (artanis mvc controller)
  #:use-module (artanis utils)
  #:use-module (artanis artanis)
  #:use-module (artanis cookie)
  #:use-module ((rnrs) #:select (define-record-type))
  #:use-module (artanis irregex)
  #:use-module (srfi srfi-1)
  #:use-module (dbi dbi)
  #:use-module (limsn lib artass)
  #:use-module (rnrs bytevectors)
  #:use-module (ice-9 textual-ports)
  #:use-module (ice-9 rdelim)
  #:use-module (web uri)	     
  #:use-module (ice-9 pretty-print)
  )
  
(define-artanis-controller urbit) ; DO NOT REMOVE THIS LINE!!!

(get "/urbit?"
     #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
     #:cookies '(names prjid userid group sid )
     #:session #t
     #:conn #t     
  (lambda (rc)
    (let* (
	   (prjid "1")
	   (login-failed (if (params rc "login_failed") (params rc  "login_failed") ""))
	   (help-topic "urbit")
	   (dest (params rc "destination"))
	  (name (get-from-qstr rc "name"))
	   ;;(name "zod")
	;;   (dummy  (DEBUG  (string-append "Value of name (in urbit): " name "~%")))				
 	  (dummy  (DEBUG  "%%%%%%%%%%%%%%%%%%%%%%%%%%%Value of name (in urbit): ~a~%" name))				
 	  (dummy  (DEBUG  "%%%%%%%%%%%%%%%%%%%%%%%%%%%Value of name (in urbit): ~a~%" name))				
 	  (dummy  (DEBUG  "%%%%%%%%%%%%%%%%%%%%%%%%%%%Value of name (in urbit): ~a~%" name))				
 	  (dummy  (DEBUG  "%%%%%%%%%%%%%%%%%%%%%%%%%%%Value of name (in urbit): ~a~%" name))				
 	  (dummy  (DEBUG  "%%%%%%%%%%%%%%%%%%%%%%%%%%%Value of name (in urbit): ~a~%" name))				
 	  ;; (sid (:cookies-value rc "sid"))
	   (destinationq (addquotes (if dest dest "/project/getall")))
	   )
      (if name
	  (let* ((sid (:session rc 'spawn))
		 (sql "select id, lnuser, usergroup from person")
		 (ret  (DB-get-all-rows (:conn rc sql)))  ;;this is in artanis/artanis/db.scm
		 (userid (get-id-for-name name ret))
	     	 (dummy  (DEBUG "Value of userid: ~a~%" userid))				

		 (sql2 (string-append "INSERT INTO sess_person ( sid, person_id, prjid) VALUES ('" sid "', " userid ", 1)"))
		 (dummy (:conn rc sql2))
		 (dummy (:cookies-set! rc 'userid "userid" userid))
		 )
	    (redirect-to rc  (get-redirect-uri "/project/getall")))
	  (view-render "urbit" (the-environment)))
  )))




;; (define (get-id-for-name name rows)
;;   (if (and  (null? (cdr rows))  (string=?  (cdadar rows) name))
;;       (number->string (cdaar rows))
;;       (if (string=?  (cdadar rows) name)
;; 	   (number->string (cdaar rows))
;; 	   (get-id-for-name name (cdr rows)))))


;; (post "/auth"
;;       #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
;;       #:session #t
;;       #:conn #t
;;     ;;  #:cookies '(names prjid sid )
;;       #:from-post 'qstr
;;       (lambda (rc)	
;; 	 (if (:session rc 'check)
;; 	     (let* (
;; 		    (dest  (uri-decode (:from-post rc 'get-vals "destination")))
;; 		    (requested-url  (if dest dest  "/project/getall"))
;; 		    )
;; 	       (redirect-to rc  (get-redirect-uri requested-url)))
;; 	     ;; requested url, sid, userid must be available at top level
;; 	     (let* ((sid (:auth rc))		    
;; 		    (userid (if sid (let* (
;; 					   (sql "select id, lnuser, usergroup from person")
;; 					   (ret  (DB-get-all-rows (:conn rc sql)))  ;;this is in artanis/artanis/db.scm
;; 					  ;; (lnuser (:from-post rc 'get-vals "lnuser"))
;; 					   (name (:from-post rc 'get-vals "name"))
;; 					   (dummy  (DEBUG  (string-append "Value of name: " name "~%")))				
;; 					   (lnuser (if name name (:from-post rc 'get-vals "lnuser")))
;; 					   (userid (get-id-for-name lnuser ret))
;; 					   (sql2 (string-append "INSERT INTO sess_person ( sid, person_id, prjid) VALUES ('" sid "', " userid ", 1)"))
;; 					   (dummy (:conn rc sql2))
;; 					   )
;; 				      userid)
;; 				#f))
;; 		    (requested-url (if sid (let* (
;; 						  (dest   (uri-decode (:from-post rc 'get-vals "destination")))				  	      
;; 						  )
;; 					     (if dest dest "/project/getall"))
;; 				       "login?login_failed=Login_Failed!"))
;; 		    )
;; 	       (redirect-to rc (get-redirect-uri requested-url))))))
;; 	     ;;  (view-render requested-url (the-environment))))))



;; old auth
;; (post "/auth"
;;       #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
;;       #:session #t
;;       #:conn #t
;;       #:cookies '(names prjid sid )
;;       #:from-post 'qstr
;;       (lambda (rc)	
;; 	 (if (:session rc 'check)
;; 	     (let* (
;; 		    (dest  (uri-decode (:from-post rc 'get-vals "destination")))
;; 		    (requested-url  (if dest dest  "/project/getall"))
;; 		    )
;; 	       (redirect-to rc  (get-redirect-uri requested-url)))
;; 	     ;; requested url, sid, userid must be available at top level
;; 	     (let* ((sid (:auth rc))		    
;; 		    (userid (if sid (let* (
;; 					   (sql "select id, lnuser, usergroup from person")
;; 					   (ret  (DB-get-all-rows (:conn rc sql)))  ;;this is in artanis/artanis/db.scm
;; 					   (name (:from-post rc 'get-vals "lnuser"))
;; 					   (userid (get-id-for-name name ret))
;; 					   (sql2 (string-append "INSERT INTO sess_person ( sid, person_id, prjid) VALUES ('" sid "', " userid ", 1)"))
;; 					   (dummy (:conn rc sql2))
;; 					   )
;; 				      userid)
;; 				#f))
;; 		    (requested-url (if sid (let* (
;; 						  (dest   (uri-decode (:from-post rc 'get-vals "destination")))				  	      
;; 						  )
;; 					     (if dest dest "/project/getall"))
;; 				       "login?login_failed=Login_Failed!"))
;; 		    )
;; 	       (redirect-to rc (get-redirect-uri requested-url))))))
;; 	     ;;  (view-render requested-url (the-environment))))))



