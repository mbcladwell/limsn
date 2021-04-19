;; Controller login definition of postest
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.

(define-artanis-controller login) ; DO NOT REMOVE THIS LINE!!!

(use-modules (labsolns artass)(artanis cookie))
	     

;;(use-modules (artanis artanis)(artanis utils)(artanis irregex)
;;	     ((rnrs) #:select (define-record-type))	     
;;	     (srfi srfi-1)(dbi dbi) 
;;	     (ice-9 textual-ports)(ice-9 rdelim)(rnrs bytevectors)
;;	     (web uri)(ice-9 pretty-print))

(get "/login"
      #:cookies '(names prjid sid )
   ;;   #:from-post #t
  (lambda (rc)
    (let* (
	  ;; (login-failed (if (:from-post rc 'get-vals "login_failed") (:from-post rc 'get-vals "login_failed") ""))
	   (login-failed (if (params rc "login_failed") (params rc  "login_failed") ""))
	   (help-topic "login")
	;;   (dest (:from-post rc 'get-vals "destination"))
	   (dest (params rc "destination"))
	   (destinationq (addquotes (if dest dest "/project/getall")))
	 )
    (view-render "login" (the-environment))
  )))



(define (get-id-for-name name rows)
  (if (and  (null? (cdr rows))  (string=?  (cdadar rows) name))
      (number->string (cdaar rows))
      (if (string=?  (cdadar rows) name)
	   (number->string (cdaar rows))
	   (get-id-for-name name (cdr rows)))))


;; (define (get-group-for-name name rows)
;;   (if (and  (null? (cdr rows))  (string=?   (cdadar rows) name))
;;        (cdr (caddar rows))
;;       (if (string=?   (cdadar rows) name)
;; 	   (cdr (caddar rows))
;; 	   (get-group-for-name name (cdr rows)))))

(post "/auth"
      #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
      #:session #t
      #:conn #t
      #:cookies '(names prjid sid )
      #:from-post 'qstr
      (lambda (rc)	
	 (if (:session rc 'check)
	     (let* (
		    (dest  (uri-decode (:from-post rc 'get-vals "destination")))
		    (requested-url  (if dest dest  "/project/getall"))
		    )
	       (redirect-to rc  (get-redirect-uri requested-url)))
	     ;; requested url, sid, userid must be available at top level
	     (let* ((sid (:auth rc))		    
		    (userid (if sid (let* (
					   (sql "select id, lnuser, usergroup from person")
					   (ret  (DB-get-all-rows (:conn rc sql)))  ;;this is in artanis/artanis/db.scm
					   (name (:from-post rc 'get-vals "lnuser"))
					   (userid (get-id-for-name name ret))
					   (dummy (:cookies-set! rc 'prjid "prjid" (:cookies-value rc "prjid")))
					   (dummy (:cookies-remove! rc 'prjid ))
					   (dummy (:cookies-set! rc 'prjid "prjid" "1"))
					   (dummy (:cookies-setattr! rc 'prjid #:path "/"))
					   ;;(dummy (:cookies-set! rc 'sid "sid" sid))
					   (sql2 (string-append "INSERT INTO sess_person ( sid, person_id) VALUES ('" sid "', " userid ")"))
					   (dummy (:conn rc sql2))
					   )
				      userid)
				#f))
		    (prjid "1")
		    (requested-url (if sid (let* (
						  (dest   (uri-decode (:from-post rc 'get-vals "destination")))				  	      
						  )
					     (if dest dest "/project/getall"))
				       "login?login_failed=Login_Failed!"))
		    )
	       (redirect-to rc (get-redirect-uri requested-url))))))
	      ;; (view-render requested-url (the-environment))))))



