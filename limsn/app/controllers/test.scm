;; Controller test definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller test) ; DO NOT REMOVE THIS LINE!!!
(add-to-load-path "/home/mbc/projects/limsn")
(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(srfi srfi-19)(dbi dbi) (labsolns artass)
	     (ice-9 pretty-print)(artanis artanis)(artanis cookie)
	     (labsolns artass)
	     (artanis config))


(test-define logtest
	     (options
	      #:session #t)
	     (lambda (rc)
	       (let* (
		      (server-check (:session rc 'check))
		      (cookies (rc-cookie rc))
		      (sid  (:cookies-check rc "sid"))
		      (prjid  (:cookies-check rc "prjid"))
		      (sid2  (:cookies-value rc "sid"))
		      (prjid2  (:cookies-value rc "prjid"))

		      )
		 (view-render "logtest" (the-environment)))
	       ))

(post "/test/loginaction"
        #:auth `(table person "lnuser" "passwd" "salt" ,my-hmac)
	#:conn #t
        #:session #t
	#:cookies '(names prjid sid )
      (lambda (rc)
	(let* (;;note all 3 command required to set cookie
	       ;; (dummy (:cookies-remove! rc 'prjid ))
	       (sid (:session rc 'spawn))
	      ;; (sql2 (string-append "INSERT INTO sess_person ( sid, person_id) VALUES ('" sid "', '1')"))
	      ;; (dummy (:conn rc sql2))
	       (dummy (:cookies-set! rc 'prjid "prjid" (:cookies-value rc "prjid")))
	       (dummy (:cookies-remove! rc 'prjid))
	       (dummy (:cookies-set! rc 'prjid "prjid" "1234"))	      
	       (dummy (:cookies-setattr! rc 'prjid #:path "/"))
	     
		   )   
	  (redirect-to rc  (get-redirect-uri "/test/page1"))	   
		     )))


(test-define page1
	     (options
	      #:session #t)
	     (lambda (rc)
	       (let* (
		      (server-check (:session rc 'check))
		      (cookies (rc-cookie rc))
		      (sid  (:cookies-check rc "sid"))
		      (prjid  (:cookies-check rc "prjid"))
		      (sid2  (:cookies-value rc "sid"))
		      (prjid2  (:cookies-value rc "prjid"))
		      (cmyhost (current-myhost))
		      (wauth (#:with-auth cmyhost))
		      )
		 (view-render "page1" (the-environment)))
	       ))

;; select * from Sessions  where sid='d4eeaa2682faad3295646a287ec431ee' and valid='1' limit 1 ;

(post "/test/page1action"
        #:session #t
	#:cookies '(names prjid sid )
      (lambda (rc)
	(let* (;;note all 3 command required to set cookie
	       (dummy (:cookies-remove! rc 'prjid ))
	      ;; (dummy (:cookies-set! rc 'prjid "prjid" (:cookies-value rc "prjid")))
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
		     ;;  #:with-auth  "/login"
		       #:cookies '(names prjid sid ))
	       (lambda (rc)
		 (let* ( (server-check (:session rc 'check))
		      (cookies (rc-cookie rc))
		      (sid  (:cookies-check rc "sid"))
		      (prjid  (:cookies-check rc "prjid"))
		      (sid2  (cookie-has-key? cookies "sid"))
		      (prjid2  (cookie-has-key? cookies "prjid"))
		      (sid3  (:cookies-value rc "sid"))
		      (prjid3  (:cookies-value rc "prjid"))
		      

		     
	   	      )
   (view-render "page2" (the-environment))
  )))


;;https://lists.gnu.org/archive/html/artanis/2021-01/msg00003.html

;; In the current design of Artanis, these APIs are used for controling the
;; cookies for the client:
;; :cookies-ref
;; :cookies-set!
;; :cookies-setattr!
;; :cookies-update!
;; And :cookies-update! is automatically triggered by the hook each time
;; the server resonse to the cilent. So users never call it directly.
;;
;; For server-side, the correct function to fetch the cookie from client is
;; `cookie-has-key?' in (artanis cookie). So your code should look like this:
;; -------------------cut-----------------------
;; (import (artanis cookie))
;;
;; (plateset-define
;; test
;; (lambda (rc)
;; (let* ((cookies (rc-cookie rc))
;; (acookie (cookie-has-key? cookies "prjid")))
;; (view-render "test" (the-environment)))))
;; -------------------end--------------------------
;;
;; Please notice that you don't have to set
;; (options #:cookies '(names prjid sid))
;; if you only want to handle the cookie in the server-side. This option is
;; to create and modify the cookie and pass them to the client. So it
;; should be used in your `add' and `delete' controller.
;;
;; It's my mistake to forget to add this function to the API, now I've
;; added :cookies-check, so you can rewrite your code as:
;; ----------------------cut--------------------------
;; (plateset-define
;; test
;; (lambda (rc)
;; (let* ((cookies (rc-cookie rc))
;; (acookie (:cookies-check rc "prjid")))
;; (view-render "test" (the-environment)))))
;; ----------------------end--------------------------
;;
;; Please notice that the key is a string.
