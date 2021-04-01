;; Controller sessions definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller sessions) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(srfi srfi-19)(dbi dbi) (labsolns artass)
	     (ice-9 pretty-print))

;; default session is one hour.  Change it in:
;; artanis/artanis/session.scm L388
;; artanis/artanis/cookie.scm L129   to 21600 for 6 hours
;; artanis/artanis/oht.scm L264   to 21600 for 6 hours

(define (prep-session-rows a)
  (fold (lambda (x prev)
          (let* ((id (result-ref x "sid"))
		(lnuser-name (result-ref x "lnuser"))
		(usergroup (result-ref x "usergroup"))
		(expires (result-ref x "expires"))
		(expires-seconds (car (mktime (car (strptime  "%a, %d %b %Y %H:%M:%S %Z" expires)))))
		(now (time-second (current-time)))
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
			  (prjid (:cookies-value rc "prjid"))
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



(get "/sesschk"
     #:session #t
     #:conn #t
		#:cookies '(names prjid userid group sid)
		 (lambda (rc)
		   (let* ((help-topic "session")
			  (check (:session rc 'check))
			  (sid (:cookies-value rc "sid"))
			  (result (get-id-name-group-email-for-session rc sid))
			  )
		     (view-render "sesschk" (the-environment))
		     )))
