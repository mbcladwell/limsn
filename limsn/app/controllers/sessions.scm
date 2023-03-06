;; Controller sessions definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-module (app controllers sessions)
  #:use-module (artanis mvc controller)
  #:use-module  (artanis utils)
   #:use-module (artanis irregex)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-19)
  #:use-module (dbi dbi)
  #:use-module (limsn lib artass)
 #:use-module (ice-9 pretty-print)
  )

(define-artanis-controller sessions) ; DO NOT REMOVE THIS LINE!!!

;(use-modules (artanis utils)(artanis mvc controller)(artanis irregex)(srfi srfi-1)(srfi srfi-19)(dbi dbi) (limsn lib artass)
;	     (ice-9 pretty-print))

;; default session is one hour.  Change it in:
;; artanis/artanis/session.scm L388
;; artanis/artanis/cookie.scm L129     to 21600 for 6 hours
;; artanis/artanis/oht.scm L264        to 21600 for 6 hours  2592000 for 1 month

(define (prep-session-rows a)
  (fold (lambda (x prev)
          (let* ((id (result-ref x "sid"))
		(lnuser-name (result-ref x "lnuser"))
		(usergroup (result-ref x "usergroup"))
		(expires (result-ref x "expires"))
		(expires-seconds (car (mktime (car (strptime  "%a, %d %b %Y %H:%M:%S %Z" expires)))))
		(now (time-second (current-time)))
		;;(now (tm:sec (current-time)))
		(expired? (if (> (- now expires-seconds) 0) #t #f ))
		(expire-text (if expired? expires (string-append "<font style=\"color:red\">" expires "</font>" ))))      
	      (cons (string-append "<tr><td>" id  "</td><td>" lnuser-name "</td><td>" usergroup "</td><td>" expire-text  "</td></tr>")
		    prev)
	      ))
        '() a))




;; person_id must be populated
(sessions-define getall
		 (options #:conn #t
			   #:cookies '(names prjid userid group sid))
		 (lambda (rc)
		   (let* ((help-topic "session")
			  (prjid (if (:cookies-value rc "prjid") (:cookies-value rc "prjid") "1"))		       
			  (sid (:cookies-value rc "sid"))
			  (identity (get-id-name-group-email-for-session rc sid))
		  (username (cadr identity))
			  (group (caddr identity))
			  (sql  "select sessions.sid, person.lnuser, person.usergroup, sessions.expires  from sessions, person, sess_person where sessions.sid=sess_person.sid AND person.id=sess_person.person_id")
			  (holder (DB-get-all-rows (:conn rc sql)))
			  (body (string-concatenate (prep-session-rows holder)))				
			  (dest  (if (equal? group "admin") "getall"  "notadmin")) )
		     (view-render dest (the-environment))
		     )))



(get "/sessions/sesschk"
     #:session #t
     #:conn #t
     #:session #t
     #:cookies '(names prjid userid group sid)
     (lambda (rc)
       (let* ((help-topic "session")
	      (check (:session rc 'check))
	      (sid (:cookies-value rc "sid"))
	      ;;(result (get-id-name-group-email-for-session rc sid))
	      (result (:session rc 'spawn))
	      )
	 (view-render "sesschk" (the-environment))
	 )))
