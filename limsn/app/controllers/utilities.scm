;; Controller utilities definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller utilities) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (labsolns artass)
	     (artanis config)  (web response) (rnrs bytevectors)
	     (web request) (web client)
	     (web uri)(ice-9 receive))

(define (process-item x) (string-append "<tr><th>"(car x) "</th><th>" (cadr x) "</th></tr>"))





(utilities-define login
		  (lambda (rc)
		    (let* ((version ln-version)
			   ;;(connection nopwd-conn)
			   (help-topic "login")	)		    
		    (view-render "login" (the-environment)))
  ))


(utilities-define menu
		  (options #:cookies '(names prjid lnuser userid group sid)
			   #:conn #t)
		  (lambda (rc)
		    (let* ((version ln-version)
			   (prjid (:cookies-value rc "prjid"))
			   (sid (:cookies-value rc "sid"))
			   (identity (get-id-name-group-email-for-session rc sid))
			   (username (cadr identity))
			   (group (caddr identity))
			   (dest (if (equal? group "admin") "menu" "notadmin"))

			   ;;(connection nopwd-conn)
			   (help-topic "administrator")	)		    
		    (view-render dest (the-environment)))
  ))


(utilities-define validate
		  (options #:conn #t)
		  (lambda (rc) 
		    (let* ((user (get-from-qstr rc "name"))
			   (pword (get-from-qstr rc "password"))
			   (help-topic "login")
			   (sql  (string-append "select id, password from lnuser where lnuser_name ='" user "'" ))
			   (ret (DB-get-all-rows (:conn rc sql))))
                      (if (result-ref ret "password")
			  (if (string=? pword (result-ref ret "password"))
			      (let* ((userid (get-c1 ret))	   
				      (dummy (DB-get-all-rows (:conn rc (string-append "INSERT INTO lnsession(lnuser_id) VALUES('" userid "')"))))
				      (dummy2 (DB-get-all-rows (:conn rc  "select id from lnsession order by id DESC LIMIT 1")))
				      ;;(sid-candidate (get-c1 (dbi-get_row (:conn rc)))
				      )
				 (begin
				  ;; (set! sid sid-candidate)
				 (redirect-to rc (get-redirect-uri "project/getall" ))))
			       (view-render "login" (the-environment)))))))

(utilities-define help
		  (lambda (rc)
		    (let* ((topic (get-from-qstr rc "topic")))
		    (redirect-to rc  (get-redirect-uri (string-append "../software/" topic "/index.html") )))))



;; register when registering through the labsolns.com website
(utilities-define register
		  (options #:conn #t
			   #:cookies '(names prjid lnuser userid group sid))
		  (lambda (rc)
		    (let* ((help-topic "register")
			   (sql "select cust_id from config where id=1")
			   (prjid (:cookies-value rc "prjid"))
			  (userid (:cookies-value rc "userid"))
			  (group (:cookies-value rc "group"))
			  (sid (:cookies-value rc "sid"))
			  (emptyreg? (equal? "" (cdaar (DB-get-all-rows (:conn rc sql))))))
		      (if emptyreg?
			  (let*((identity (get-id-name-group-email-for-session rc sid))
				(username (cadr identity))
				(group (caddr identity))
				(dest (if (equal? group "admin") "register" "notadmin"))
				)
			  (view-render dest (the-environment)))
			  (let* ((sql "select cust_id, cust_key, cust_email, version from config where id=1")
				 (holder (car (DB-get-all-rows (:conn rc sql))))
				 (vcust (assoc-ref holder "cust_id"))
				 (vkey (assoc-ref holder "cust_key"))
				 (vemail (assoc-ref holder "cust_email"))
				 (version (assoc-ref holder "version"))
				 (alltext (string-append "Customer ID:&nbsp;" vcust "\n\n"
							 "Registration key:&nbsp;" vkey  "\n\n"
							 "Email:&nbsp;" vemail "\n\n"
							 "Version:&nbsp;" version)))			    
			    (view-render "isreg" (the-environment)))
			  ))))

(post "/registeraction"
      #:from-post 'qstr
      #:conn #t
      #:cookies '(names prjid lnuser userid group sid)
		  (lambda (rc)
		    (let* ((help-topic "register")
			   (prjid (:cookies-value rc "prjid"))
			   (userid (:cookies-value rc "userid"))
			   (group (:cookies-value rc "group"))
			   (sid (:cookies-value rc "sid"))
			   (cust-id (stripfix (:from-post rc 'get-vals "custid")))
			   (cust-key (stripfix (:from-post rc 'get-vals "custkey")))
			   (email (stripfix (:from-post rc 'get-vals "email")))
			   (validkey? (validate-key cust-id email cust-key)))
		      (if validkey?
			  (let*((sql (string-append "UPDATE config SET cust_id='" cust-id "', cust_key= '" cust-key "', cust_email='" email "' WHERE id=1"))
				(dummy  (:conn rc sql))
				(sql2 "select cust_id, cust_key, cust_email,version from config where id=1")
				(holder (car (DB-get-all-rows (:conn rc sql2))))
				(vcust (assoc-ref holder "cust_id"))
				(vkey (assoc-ref holder "cust_key"))
				(vemail (assoc-ref holder "cust_email"))
				(version (assoc-ref holder "version"))
				 (alltext (string-append "Customer ID:&nbsp;" vcust "\n\n"
							 "Registration key:&nbsp;" vkey  "\n\n"
							 "Email:&nbsp;" vemail "\n\n"
							 "Version:&nbsp;" version))
				)
			  (view-render "isreg" (the-environment)))
			  (view-render "failreg" (the-environment))))))



;; this does not working because of non-blocking
;; (post "/regformaction"
;;       #:from-post 'qstr
;;       #:conn #t
;;       #:cookies '(names prjid sid)
;; 		  (lambda (rc)
;; 		    (let* ((help-topic "register")
;; 			   (prjid (:cookies-value rc "prjid"))
;; 			   (sid (:cookies-value rc "sid"))
;; 			  ;; (cust-id (stripfix (:from-post rc 'get-vals "custid")))
;; 			  ;; (cust-key (stripfix (:from-post rc 'get-vals "custkey")))
;; 			   (fname (stripfix (:from-post rc 'get-vals "fname")))
;; 			   (lname (stripfix (:from-post rc 'get-vals "lname")))
;; 			   (inst (stripfix (:from-post rc 'get-vals "institution")))
;; 			   (email (stripfix (:from-post rc 'get-vals "email")))
;; 			   (therequest (string-append "http://labsolns.com/software/register/insert.php?fname=" fname "&lname=" lname "&institution=" inst "&email=" email))
;; 			   ;; (validkey? (validate-key cust-id email cust-key))
;; 			   (bv (string->utf8 "test"))
;; 			   (port (open-socket-for-uri "http://labsolns.com/software/register"))
;; 			   (dummy (fcntl port F_SETFL (logior O_NONBLOCK (fcntl port F_GETFL 0))))
;; 			   (header (http-get therequest
;; 					     #:body bv
;; 					     #:port port
;; 					   #:headers `((content-type text/plain (charset . "utf-8"))
;; 						       (content-length . ,(bytevector-length bv)))))
;; 			   (wid      (:cookies-value header "wid")) 
;; 			    )
;; 		      (view-render "test" (the-environment)))))


		      
;; 		      ;; (if validkey?
;; 		      ;; 	  (let*((sql (string-append "UPDATE config SET cust_id='" cust-id "', cust_key= '" cust-key "', cust_email='" email "' WHERE id=1"))
;; 		      ;; 		(dummy  (:conn rc sql))
;; 		      ;; 		(sql2 "select cust_id, cust_key, cust_email,version from config where id=1")
;; 		      ;; 		(holder (car (DB-get-all-rows (:conn rc sql2))))
;; 		      ;; 		(vcust (assoc-ref holder "cust_id"))
;; 		      ;; 		(vkey (assoc-ref holder "cust_key"))
;; 		      ;; 		(vemail (assoc-ref holder "cust_email"))
;; 		      ;; 		(version (assoc-ref holder "version"))
;; 		      ;; 		 (alltext (string-append "Customer ID:&nbsp;" vcust "\n\n"
;; 		      ;; 					 "Registration key:&nbsp;" vkey  "\n\n"
;; 		      ;; 					 "Email:&nbsp;" vemail "\n\n"
;; 		      ;; 					 "Version:&nbsp;" version))
;; 		      ;; 		)
;; 		      ;; 	  (view-render "isreg" (the-environment)))
;; 		      ;; 	  (view-render "failreg" (the-environment))))))
			  



;; (utilities-define regform
;; 		  (options #:conn #t
;; 			   #:cookies '(names prjid lnuser userid group sid))
;; 		  (lambda (rc)
;; 		    (let* ((help-topic "register")
;; 			   (sql "select cust_id from config where id=1")
;; 			   (prjid (:cookies-value rc "prjid"))
;; 			  (userid (:cookies-value rc "userid"))
;; 			  (group (:cookies-value rc "group"))
;; 			  (sid (:cookies-value rc "sid"))
;; 			  (emptyreg? (equal? "" (cdaar (DB-get-all-rows (:conn rc sql))))))
;; 		      (if emptyreg?
;; 			  (let*((identity (get-id-name-group-email-for-session rc sid))
;; 				(username (cadr identity))
;; 				(group (caddr identity))
;; 				(dest (if (equal? group "admin") "regform" "notadmin"))
;; 				)
;; 			  (view-render dest (the-environment)))
;; 			  (let* ((sql "select cust_id, cust_key, cust_email, version from config where id=1")
;; 				 (holder (car (DB-get-all-rows (:conn rc sql))))
;; 				 (vcust (assoc-ref holder "cust_id"))
;; 				 (vkey (assoc-ref holder "cust_key"))
;; 				 (vemail (assoc-ref holder "cust_email"))
;; 				 (version (assoc-ref holder "version"))
;; 				 (alltext (string-append "Customer ID:&nbsp;" vcust "\n\n"
;; 							 "Registration key:&nbsp;" vkey  "\n\n"
;; 							 "Email:&nbsp;" vemail "\n\n"
;; 							 "Version:&nbsp;" version)))			    
;; 			    (view-render "isreg" (the-environment)))
;; 			  ))))

