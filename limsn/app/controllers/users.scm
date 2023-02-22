;; Controller users definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-module (app controllers users)
  #:use-module (artanis mvc controller)
  #:use-module  (artanis utils)
   #:use-module (artanis irregex)
  #:use-module (srfi srfi-1)
  #:use-module (dbi dbi)
  #:use-module (limsn lib artass)
  )
  
(define-artanis-controller users) ; DO NOT REMOVE THIS LINE!!!

;;(use-modules (artanis utils)(artanis mvc controller)(artanis irregex)(srfi srfi-1)(dbi dbi) (limsn lib artass))


(define (default-hmac passwd salt)
  (if passwd
      (substring (string->sha-256 (string-append passwd salt)) 0 16)
      (substring (string->sha-256 (string-append salt)) 0 16)
      ))



(define (prep-user-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(group-name (result-ref x "usergroup"))
                (lnuser-name (result-ref x "lnuser"))
                (email (result-ref x "email"))
		)
            (cons (string-append "<tr><td> <input type=\"radio\" id=\"" id  "\" name=\"id\" value=\"" id   "\"></td><td> " id "</td><td> " group-name "</td><td> " lnuser-name "</td><td> " email "</td></tr>")
		  prev)))
        '() a))


(users-define getall
	      (options #:conn #t
		       #:cookies '(names prjid userid sid))
	      (lambda (rc)
		(let* ((help-topic "users")
		       (prjid (:cookies-value rc "prjid"))
		       (userid (:cookies-value rc "userid"))
		       (sid (:cookies-value rc "sid"))  
		       (identity (get-id-name-group-email-for-session rc sid))
		       (username (cadr identity))
		       (group (caddr identity))  
		       (sql "select person.id, person.usergroup, lnuser, email from person ORDER BY person.id DESC"  )
		       (holder (DB-get-all-rows(:conn rc sql)))
		       (body (string-concatenate (prep-user-rows holder)))
		       (dest (if (equal? group "admin") "getall" "notadmin"))
		       )
		  (view-render dest (the-environment))
		  )))


(users-define add
	      (options
	       #:cookies '(names prjid sid)
	       #:conn #t)

	      (lambda (rc)
		(let* ((help-topic "user")
		       (prjid (:cookies-value rc "prjid"))		       
		       (sid (:cookies-value rc "sid"))
	       ;; (sql "SELECT help_url_prefix,  cust_id, cust_key, cust_email FROM config WHERE id=1")
		       ;; (ret   (car (DB-get-all-rows (:conn rc sql))))
		       ;; (help-url-prefix (assoc-ref ret "help_url_prefix"))
		       ;; (cust_id (assoc-ref ret "cust_id"))
		       ;; (cust_key (assoc-ref ret "cust_key"))
		       ;; (email (assoc-ref ret "cust_email"))
		       ;; (register-url (string-append "http://" help-url-prefix "register"))
		       ;; (licensed? (if (and cust_id cust_key email ) (validate-key cust_id email cust_key) #f))					  
		       (prjidq (addquotes prjid))
		       (sidq (addquotes sid))
		      ;; (register-urlq (addquotes register-url))
		       )
		  (view-render "add" (the-environment)))))



(get "/users/addaction" #:conn #t
  (lambda (rc)
  (let*((salt (get-random-from-dev #:length 8 #:uppercase #f))
	(pre-pwd (get-from-qstr rc  "pw"))
	(name  (get-from-qstr rc "uname"))
	(usergroup (get-from-qstr rc "group"))
	(pwd  (default-hmac pre-pwd salt))
	(email (get-from-qstr rc "email"))
	(sql (string-append "insert into person (lnuser, passwd, salt, email, usergroup ) VALUES ('" name "', '" pwd "', '" salt "', '" email "', '" usergroup "')"))
	(dummy (:conn rc sql)))
    (redirect-to rc (get-redirect-uri "/users/getall" )))
  ))





;; (users-define addaction
;; 		(lambda (rc)
;; 		  (let* ((help-topic "users")
;; 			 (user-name (get-from-qstr rc "uname"))
;; 			 (tags (get-from-qstr rc "tags"))
;; 			 (pw (get-from-qstr rc "pw"))			 
;; 			 (group (get-from-qstr rc "group"))			 
;; 			 (insert-string (string-append "select new_user('"  user-name "', '" tags "', '" pw "', '" group "')"))
;; 			 (dummy (dbi-query ciccio insert-string))
;; 			 )
;; 		    (redirect-to rc "users/getall")
;;   )))
