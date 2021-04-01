;; Controller target definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller target) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(srfi srfi-1)(dbi dbi) (labsolns artass)
	     (ice-9 textual-ports)(ice-9 rdelim)(labsolns artass)(ice-9 pretty-print))


(define (prep-trg-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(target-sys-name (result-ref x "target_sys_name"))
		(prj-id (get-c3 x ))
		(trg-name (result-ref x "target_name"))
		(descr (result-ref x "descr"))
		(accs (result-ref x "accs_id")))	      
	      (cons (string-append "<tr><td>"  target-sys-name "</td><td>" prj-id "</td><td>" trg-name "</td><td>" descr "</td><td>" accs "</td></tr>")
		  prev)))
        '() a))



(target-define getall
	       (options #:conn #t
			 #:cookies '(names prjid lnuser userid group sid))
		(lambda (rc)
		  (let* ((help-topic "targets")
			 (prjid (:cookies-value rc "prjid"))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
			 (sid (:cookies-value rc "sid"))
			 (sql (string-append "select id, target_sys_name, project_id, target_name, descr, accs_id from target" ))
			 (holder (DB-get-all-rows (:conn rc sql)))
			 (body  (string-concatenate  (prep-trg-rows holder)) ))
		    (view-render "getall" (the-environment)))))


(define (prep-trglytname-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(prj-id  (get-c2 x ))
		(trg-lyt-sys-name (result-ref x "target_layout_name_sys_name"))
		(trg-name (result-ref x "target_layout_name_name"))
		(descr (result-ref x "target_layout_name_desc"))
		(reps (get-c6 x)))	      
	    (cons (string-append "<tr><td>"
				 (if (string? prj-id)
				     (string-append "PRJ-" prj-id)
				     '(""))
				 "</td><td><a href=\"gettrglytbyid?id=" id "\">" trg-lyt-sys-name  "</a></td><td>" trg-name "</td><td>" descr "</td><td>" reps "</td></tr>")
		  prev)))
        '() a))


(target-define gettrglyt
	       (options #:conn #t
			#:cookies '(names prjid lnuser userid group sid))
	       (lambda (rc)
		 (let* ((help-topic "target")
			(prjid (:cookies-value rc "prjid"))
			(userid (:cookies-value rc "userid"))
			(group (:cookies-value rc "group"))
			(sid (:cookies-value rc "sid"))
			(sql (string-append "select id, project_id, target_layout_name_sys_name, target_layout_name_name, target_layout_name_desc, reps from target_layout_name" ))
			(holder (DB-get-all-rows (:conn rc sql)))
			(body  (string-concatenate  (prep-trglytname-rows holder)) ))
		   (view-render "gettrglyt" (the-environment)))))



(define (prep-trglytbyid-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(prj-id  (get-c4 x ))
		(trg-sys-name (result-ref x "target_sys_name"))
		(trg-name (result-ref x "target_name"))
		(trg-descr (result-ref x "descr"))		
		(quad (get-c6 x))
		(trg-accs (result-ref x "accs_id")))
	    (cons (string-append "<tr><td>" trg-sys-name  "</td><td>"
				 (if (string? prj-id)
				     (string-append "PRJ-" prj-id)
				     '(""))
				 "</td><td>" trg-name "</td><td>" quad "</td><td>" trg-descr "</td><td>" trg-accs "</td></tr>")
		  prev)))
        '() a))



(target-define gettrglytbyid
	       (options #:conn #t
			#:cookies '(names prjid lnuser userid group sid))
		(lambda (rc)
		  (let* ( (help-topic "targets")
			  (id  (get-from-qstr rc "id"))
			  (prjid (:cookies-value rc "prjid"))
			  (userid (:cookies-value rc "userid"))
			  (group (:cookies-value rc "group"))
			  (sid (:cookies-value rc "sid"))
			 (sql (string-append "select target.id, target.target_sys_name, target.descr, target_layout_name.project_id, target.target_name, target_layout.quad, target_layout_name_sys_name, target_layout_name_name, target_layout_name_desc, target_layout_name.reps, target.accs_id from target_layout_name, target_layout, target WHERE target_layout.target_layout_name_id=target_layout_name.id AND target_layout.target_id=target.id AND target_layout_name.id=" id))
			 (holder (DB-get-all-rows (:conn rc sql)))
			 (trg-lyt-sys-name (result-ref (car holder) "target_layout_name_sys_name"))
			 (trg-lyt-name (result-ref (car holder) "target_layout_name_name"))
			 (trg-lyt-descr (result-ref (car holder) "target_layout_name_desc"))
			 (reps (get-c10 (car holder)))
			 (trg-accs-id (result-ref (car holder) "accs_id"))			 
			 (header (string-append "Targets in " trg-lyt-sys-name "\nName: " trg-lyt-name "\nDescription: " trg-lyt-descr "\nReplication: " reps))
			 (body  (string-concatenate  (prep-trglytbyid-rows holder)) ))
		    (view-render "gettrglytbyid" (the-environment)))))

(define (extract-projects lst all-prj)
   (if (null? (cdr lst))
       (begin
	 (set! all-prj (cons (string-append "<option value=\"" (cdaar lst) "\">"(cdaar lst) "</option>") all-prj))
       all-prj)
       (begin
	 (set! all-prj (cons (string-append "<option value=\"" (cdaar lst) "\">"  (cdaar lst) "</option>") all-prj))
	 (extract-projects (cdr lst) all-prj)) ))




(define (get-sql-bulk-target-file f)
  ;; this is not being used
  ;; used to directly read file
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (message "")
	     (ret (read-line my-port))
	     (header (string-split ret #\tab))
	     (result (if (and (string=? (car header) "project")
			     (string=? (cadr header) "target")
			     (string=? (caddr header) "description")
			     (string=? (cadddr header) "accession")) 			
			  (let* (
				 (ret (read-line my-port))
				 (dummy2 (while (not (eof-object? ret))
					   (set! holder (cons (string-split ret #\tab) holder))
					   (set! ret (read-line my-port))))
				 (holder2 (string-concatenate (map process-list-of-rows holder)))
				 (sql (string-append "select bulk_target_upload('{" (xsubstring holder2 0 (- (string-length holder2) 1))  "}')" ))) ;;trim the final comma
				 
			    sql))))
	result)
      #f))


(define cs (char-set #\space #\tab #\newline #\return))




;; (define (process-trg-row1 lst results)
;;   ;; make a list of strings from objects
;;   (if (null? (cdr lst))
;;         (begin
;; 	 (set! results  (cons   (map object->string (car lst)) results))
;;        results)
;;        (begin
;; 	 (set! results (cons  (map object->string (car lst)) results))
;; 	 (process-trg-row1 (cdr lst) results )) ))

;; select bulk_target_upload('{{"10", "CFL2", "", "1073"},{"10", "CHRNE", "", "1145 "},{"10", "CHRNA1", "", "1134"}}'); is goal

(define (process-trg-row1 lst results)
  ;; make a list of strings from objects
  (if (null? (cdr lst))
        (begin
	 (set! results  (cons   (string-split (caar lst)  #\tab) results))
       results)
       (begin
	 (set! results (cons (string-split (caar lst)  #\tab)  results))
	 (process-trg-row1 (cdr lst) results )) ))


(define (process-trg-row2 lst results)
  ;; results is a string like "'{"2" "3" "4"}'" note the single quotes
  (if (null? (cdr lst))
      (begin
	(cond
	 ((= (length (car lst)) 3) (set! results  (string-append results "{\"" (string-trim-both (caar lst) white-chars) "\", \"" (string-trim-both (cadar lst) white-chars) "\", \"\",  \""  (string-trim-both (caddar lst) white-chars)   "\"}," )))
	  ((= (length (car lst)) 4)(set! results  (string-append results "{\"" (string-trim-both (caar lst) white-chars) "\", \""  (string-trim-both (cadar lst) white-chars)  "\", \""    (string-trim-both (caddar lst) white-chars)   "\", \""  (string-trim-both (car (cdddar lst)) white-chars)   "\"}," )))
	 )
       results)
       (begin
	 (cond
	 ((= (length (car lst)) 3) (set! results  (string-append results "{\"" (caar lst) "\", \"" (cadar lst) "\", \"\",  \""  (caddar lst)   "\"}," )))
	  ((= (length (car lst)) 4)(set! results  (string-append results "{\"" (caar lst) "\", \""  (cadar lst)  "\", \""    (caddar lst)   "\", \""   (car (cdddar lst))   "\"}," ))))
	 (process-trg-row2 (cdr lst) results)) ))


(post "/addbulkaction"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid lnuser userid group sid)
		(lambda (rc)
		  (let* ((help-topic "targets")
			 (prjid (:cookies-value rc "prjid"))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
			 (sid (:cookies-value rc "sid"))
			 (a  (uri-decode (:from-post rc 'get-vals "datatransfer")))
			 (b (map list (cdr (string-split a #\newline))))
			 (c  (process-trg-row1 b '()))
			 (d (process-trg-row2  c ""))
			 (e (substring d 0 (- (string-length d) 1)))  ;;remove final comma
			 (sql (string-append "select bulk_target_upload('{" e "}')"))
		
			 (dummy (:conn rc sql))
			 )
		    (redirect-to rc (get-redirect-uri "/target/getall" ))
		     ;;   (view-render "test" (the-environment))
		  ;;  (pretty-print d)
		    )))


(target-define addbulk
	       (options #:conn #t
			#:cookies '(names prjid lnuser userid group sid))
		(lambda (rc)
		  (let* ((help-topic "targets")
			 (prjid (:cookies-value rc "prjid"))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
			 (sid (:cookies-value rc "sid")))
		    (view-render "addbulk" (the-environment)))))

;; (get "/addbulk" #:conn #t 
;; 		(lambda (rc)
;; 		  (let* ((help-topic "target")
;; 			 (sql (string-append "select new_target(" id ", '" tname "', '" desc "', '" accs "')"))			 
;; 			 (dummy (:conn rc sql))
;; 			 )
;; 		    (redirect-to rc "target/getall")
;;   )))



;;new_target(_project_id INTEGER, _trg_name varchar(30), _descr varchar(250), _accs_id varchar(30))

(get "/addsingleaction" #:conn #t #:cookies '(names prjid lnuser userid group sid)
		(lambda (rc)
		  (let* ((help-topic "targets")
			 (prj-name (get-from-qstr rc "projects"))
			 (id (substring prj-name 4))
			 (prjid (:cookies-value rc "prjid"))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
			 (get-ps-link (string-append "/plateset/getps?id=" prjid))
			 (ps-add-link (string-append "/plateset/add?format=96&type=master&prjid=" prjid))	    
			 (sid (:cookies-value rc "sid"))
			 (tname (get-from-qstr rc "tname"))
			 (desc (get-from-qstr rc "desc"))
			 (accs (get-from-qstr rc "accs"))
			 (sql (string-append "select new_target(" id ", '" tname "', '" desc "', '" accs "')"))			 
			 (dummy (:conn rc sql))
			 )
		    (redirect-to rc (get-redirect-uri "/target/getall"))
  )))


(target-define addsingle
	       (options #:conn #t
			#:cookies '(names prjid lnuser userid group sid))
		(lambda (rc)
		  (let* ((help-topic "targets")
			 (prjid (:cookies-value rc "prjid"))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
			 (sid (:cookies-value rc "sid"))
			 (get-ps-link (string-append "/plateset/getps?id=" prjid))
			 (ps-add-link (string-append "/plateset/add?format=96&type=master&prjid=" prjid))	    
			 (sql  "select project_sys_name from project")
			 (holder  (DB-get-all-rows (:conn rc sql)))
			 (all-projects-pre '())			 
			 (all-projects  (extract-projects holder all-projects-pre)))
		    (view-render "addsingle" (the-environment)))))




(define (extract-targets lst all-trgs)
  (if (null? (cdr lst))
        (begin
	 (set! all-trgs (cons (string-append "<option value=" (object->string (cdaar lst)) ">" (string-append  (cdadar lst) " "  (cdar (cddar lst))) "</option>") all-trgs))
       all-trgs)
       (begin
	 (set! all-trgs (cons (string-append "<option value=\"" (object->string (cdaar lst)) "\">"(string-append  (cdadar lst) " "  (cdar (cddar lst))) "</option>") all-trgs))
	 (extract-targets (cdr lst) all-trgs)) ))



(target-define addtrglyt
	       (options #:conn #t
			#:cookies '(names prjid lnuser userid group sid))
	(lambda (rc)
	  (let* ((help-topic "target")
		 (prjid (:cookies-value rc "prjid"))
		 (userid (:cookies-value rc "userid"))
		 (group (:cookies-value rc "group"))
		 (sid (:cookies-value rc "sid"))
		 (sql  "select project_sys_name from project")
		 (holder  (DB-get-all-rows (:conn rc sql)))
		 (all-projects-pre '())			 
		 (all-projects  (extract-projects holder all-projects-pre))
		 (sql2  "select id, target_sys_name, target_name from target")
		 (holder2    (DB-get-all-rows (:conn rc sql2)))
		 (all-targets-pre '())			 
		 (all-targets  (extract-targets holder2 all-targets-pre))
		 )
		    (view-render "addtrglyt" (the-environment)))))
	       

;; new_target_layout_name(_project_id INTEGER,  _trg_lyt_name varchar(30), _descr varchar(250), _reps INTEGER, q1_id INTEGER, q2_id INTEGER, q3_id INTEGER, q4_id INTEGER)
(get "/addtrglytaction?" #:conn #t #:cookies '(names prjid lnuser userid group sid)
		(lambda (rc)
		  (let* ((help-topic "targets")
			 (prjid (:cookies-value rc "prjid"))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
			 (sid (:cookies-value rc "sid"))
			 (get-ps-link (string-append "/plateset/getps?id=" prjid))
			 (ps-add-link (string-append "/plateset/add?format=96&type=master&prjid=" prjid))	    
			 (prj-name (get-from-qstr rc "projects"))
			 (id (substring prj-name 4))
			 (tlytname (get-from-qstr rc "tlytname"))
			 (desc (get-from-qstr rc "desc"))
			 (reps (get-from-qstr rc "reps"))
			 (q1  (get-from-qstr rc "t1"))
			 (q2 (cond ((equal? reps "1") (get-from-qstr rc "t2"))
				   ((equal? reps "2") (get-from-qstr rc "t2"))
				   ((equal? reps "4") (get-from-qstr rc "t1"))))
			 (q3 (cond ((equal? reps "1") (get-from-qstr rc "t3"))
				   ((equal? reps "2") (get-from-qstr rc "t1"))
				   ((equal? reps "4") (get-from-qstr rc "t1"))))
			 (q4 (cond ((equal? reps "1") (get-from-qstr rc "t4"))
				   ((equal? reps "2") (get-from-qstr rc "t2"))
				   ((equal? reps "4") (get-from-qstr rc "t1"))))
			 (sql (string-append "select new_target_layout_name(" id ", '" tlytname "', '" desc "', '" reps "', '" q1 "', '" q2 "', '" q3 "', '" q4 "')"))
			 (dummy (:conn rc sql)))
		    (redirect-to rc (get-redirect-uri "/target/gettrglyt" )))))
     

