;; Controller project definition of lnservern
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller project) ; DO NOT REMOVE THIS LINE!!!

;; (use-modules (artanis utils) (ice-9 local-eval) (srfi srfi-1)
   ;;          (artanis irregex)(dbi dbi) (ice-9 textual-ports)(web uri)(ice-9 rdelim)(lnserver sys methods))

(use-modules (artanis artanis)(artanis config)(artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (labsolns artass))

(define (prep-project-rows a)
  (fold (lambda (x prev)
          (let (
                (project_sys_name (result-ref x "project_sys_name"))
                (project_name (result-ref x "project_name"))
		(descr (result-ref x "descr")))
            (cons (string-append "<tr><td> <input type=\"radio\" id=\"" project_sys_name  "\" name=\"prjid\" value=\"" (number->string (cdr (car x)))   "\"></td>

<td><a href=\"/plateset/getps?id=" (number->string (cdr (car x))) "\">" project_sys_name "</a></td>


<td>" project_name "</td><td>" descr "</td></tr>")
		  prev)))
        '() a))


;; <th><a href=\"/plateset/getps?id=" (number->string (cdr (car x))) "\" class=\"btn btn-primary btn-sm active\" role=\"button\" aria-pressed=\"true\">" project_sys_name "</a></th>
;; <th><a href=\"/plateset/getps?id=" (number->string (cdr (car x))) "\">" project_sys_name "</a></th>



;; (get "/project/getall" #:conn #t 
;;      #:cookies '(names prjid sid)
;;      #:with-auth "/login" 
;;      (lambda (rc ) 
;;        (let* ( 
;; 	      (help-topic "project")
;; 	      (prjid (get-prjid rc sid))
;; 	      (sid (:cookies-value rc "sid"))
;; 	      (holder   (DB-get-all-rows (:conn rc "select id, project_sys_name, project_name, descr from project" )))  
;; 	      (body (string-concatenate (prep-project-rows holder)))
;; 	      (prjidq (addquotes prjid))
;; 	      (sidq (addquotes sid))
	     
;; 	      )
;; 	 (view-render "/getall" (the-environment)))))

(project-define getall
		(options #:conn #t
			 #:session #t
			 #:cookies '(names prjid sid)
			 #:with-auth (current-myhost) )
			 (lambda (rc ) 
			   (let* ( 
				  (help-topic "project")
				   (sess-check (:session rc 'check))
				  (sid (:cookies-value rc "sid"))
				  (prjid (get-prjid rc sid))
				  (holder   (DB-get-all-rows (:conn rc "select id, project_sys_name, project_name, descr from project" )))  
				  (body (string-concatenate (prep-project-rows holder)))
				  (prjidq (addquotes prjid))
				  (sidq (addquotes sid))				  
				  )
			      (view-render "getall" (the-environment))				 
			     )))


(get "/project/add"
     #:conn #t
     #:cookies '(names prjid lnuser userid group sid)
     (lambda (rc)     
       (let* ((help-topic "project")
	      (sid (:cookies-value rc "sid"))
	      (prjid (get-prjid rc sid))
	      (identity (get-id-name-group-email-for-session rc sid))
	      (username (cadr identity))
	      (group (caddr identity))  
	      ;; (sql "SELECT help_url_prefix,  cust_id, cust_key, cust_email FROM config WHERE id=1")
	      ;; (ret   (car (DB-get-all-rows (:conn rc sql))))
	      ;; (help-url-prefix (assoc-ref ret "help_url_prefix"))
	      ;; (cust_id (assoc-ref ret "cust_id"))
	      ;; (cust_key (assoc-ref ret "cust_key"))
	      ;; (email (assoc-ref ret "cust_email"))
	     ;; (register-url (string-append "http://" help-url-prefix "register"))
	     ;; (licensed? (if (and cust_id cust_key email ) (validate-key cust_id email cust_key) #f))					  
	      ;;(admin? (if (and cust_id cust_key email ) (validate-key cust_id email cust_key) #f))					  
	      (prjidq (addquotes prjid))
	      (sidq (addquotes sid))
	    ;;  (register-urlq (addquotes register-url))
	      (dest (if (equal? group "admin") "add" "notadmin"))
	      )
	 (view-render dest (the-environment)))
	  ))


(project-define addaction
		(options #:conn #t
			 #:cookies '(names prjid lnuser userid group sid))
		(lambda (rc)
		  (let* ((help-topic "project")
			;; (qstr  (:from-post rc 'get))
			 (prj-name (get-from-qstr rc "pname"))
		       	 (descr (get-from-qstr rc "descr"))
			 (sid (:cookies-value rc "sid"))
			 (prjid (get-prjid rc sid))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
			 (prjidq (addquotes prjid))
			 (useridq (addquotes userid))
			 (groupq (addquotes group))
			 (sidq (addquotes sid))
    			 (sql (string-append "select new_project('"  descr "', '" prj-name "', '" sid "')"))
			 (dummy (:conn rc sql))
			 )
		    (redirect-to rc (get-redirect-uri "project/getall"))
  )))

(project-define edit
		(options #:conn #t
			 #:cookies '(names prjid lnuser userid group sid))
		(lambda (rc)
		  (let* ((help-topic "project")			
			 (prjid (get-from-qstr rc "prjid"))
			 (sql (string-append "select project_name, descr from project where id=" prjid ))
			 (holder   (car (DB-get-all-rows (:conn rc sql))))
			 (descr  (object->string (cdadr holder)))
			 (name (object->string (cdar holder)))
			 (sid (:cookies-value rc "sid"))
			 (prjidq (addquotes prjid))
			 (sidq (addquotes sid))
	  			 )
		    (view-render "edit" (the-environment)))))

(project-define editaction
		(options #:conn #t
			 #:cookies '(names prjid lnuser userid group sid))
		(lambda (rc)
		  (let* ((help-topic "project")
			 (prj-name (get-from-qstr rc "pname"))
			 (descr (get-from-qstr rc "descr"))
			 (prjid (get-from-qstr rc "prjid"))
			 (sid (:cookies-value rc "sid"))
			 (prjidq (addquotes prjid))
			 (sidq (addquotes sid))	  
			 (sql (string-append "UPDATE project SET project_name='" prj-name "', descr='" descr "' WHERE id=" prjid))
			 (dummy (:conn rc sql))
			 )
;;		    (view-render "test" (the-environment))
		    (redirect-to rc (get-redirect-uri "project/getall"))
  )))



;;this works
;; (get "/project/test"
;;    ;;  #:with-auth "/login?destination=/project/add"
;;      ;;    #:from-post 'qstr
;;       #:cookies '(names prjid userid group sid)
;;      (lambda (rc)     
;;        (let* ((help-topic "project")
;; 	      (result (:cookies-value rc "sid"))
;; 	      (lnuser (:cookies-value rc "lnuser"))
;; 	      (group (:cookies-value rc "group"))
;; 	      (prjid (get-prjid rc sid))
;; 	      )
;; 	 (view-render "test" (the-environment)))
;; 	  ))

;;this works
;; (project-define test
;;    ;;  #:with-auth "/login/login?destination=/project/add"
;;      ;;    #:from-post 'qstr
;;     (options  #:cookies '(names prjid userid group sid))
;;      (lambda (rc)     
;;        (let* ((help-topic "project")
;; 	      (result (:cookies-value rc "sid"))
;; 	      (lnuser (:cookies-value rc "lnuser"))
;; 	      (group (:cookies-value rc "group"))
;; 	      (prjid (:cookies-value rc "prjid"))
;; 	      )
;; 	 (view-render "test" (the-environment)))
;; 	  ))


(post "/test"
     #:cookies '(names prjid userid username group sid)
     (lambda (rc)     
       (let* ((help-topic "project")
	      (result (:cookies-value rc "sid"))
	      (username (:cookies-value rc "username"))
	      (userid (:cookies-value rc "userid"))
	      (group (:cookies-value rc "group"))
	      (prjid (:cookies-value rc "prjid"))
	      )
	 (view-render "test" (the-environment)))
	  ))


(project-define poster
     (lambda (rc)     
       (let* ((help-topic "project")
	      )
	 (view-render "poster" (the-environment)))
	  ))
