
;; Controller plateset definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller plateset) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)(artanis cookie)
	     (srfi srfi-1)(dbi dbi)(web uri)
	     (srfi srfi-19)   ;; date time
	     (labsolns artass)(ice-9 match)
	     (srfi srfi-11) ;; let-values
	     (ice-9 textual-ports)(ice-9 rdelim)
	     (labsolns artass))

(define (prep-ps-for-prj-rows a)
  (fold (lambda (x prev)
          (let* (
                (plate_set_sys_name (result-ref x "plate_set_sys_name"))
                (plate_set_name (result-ref x "plate_set_name"))
		(descr (result-ref x "descr"))
		(type (result-ref x "plate_type_name"))
		(numplates (get-c6 x))
		(format  (result-ref x "format"))
		(layout (result-ref x "sys_name"))
		(layoutid (get-c9 x))
		(reps (get-c10 x))
		(worklist (if (equal? (get-c11 x) "0") "" (get-c11 x)))
		(worklist-for-data (if (equal? (get-c11 x) "0") "0" (get-c11 x)))
		(idval (string-append (number->string (cdr (car x))) "+" numplates "+" format "+" layoutid "+" reps "+" worklist-for-data))
		)
            (cons (string-append "<tr><td> <input type=\"checkbox\" id=\"" plate_set_sys_name  "\" name=\"plateset-id\" value=\"" idval "\" onclick=\"handleChkbxClick()\"></td><td><a href=\"/plate/getpltforps?id=" (number->string (cdr (car x))) "\">" plate_set_sys_name "</a></td><td>" plate_set_name "</td><td>" descr "</td><td>" type "</td><td>" numplates "</td><td>" format "</td><td><a href=\"/layout/lytbyid?id="  layoutid "\">" layout "</a></td><td>" reps "</td><td>" worklist "</td></tr>")
		  prev)))
        '() a))




(define (get-assay-runs-for-prjid id rc)
  (let* ((sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_run.descr, assay_type.assay_type_name, plate_layout_name.sys_name, plate_layout_name.name FROM assay_run, assay_type, plate_set, plate_layout_name WHERE assay_run.plate_layout_name_id=plate_layout_name.id AND assay_run.assay_type_id=assay_type.id AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id =" id ))
	(holder (DB-get-all-rows (:conn rc sql))))
	 (string-concatenate (prep-ar-rows holder))))

(define (prep-hl-for-prj-rows a)
  (fold (lambda (x prev)
          (let* ((id (get-c1 x))
                (assay-run-sys-name (result-ref x "assay_run_sys_name"))
                (assay-run-name (result-ref x "assay_run_name"))
		(assay-type-name (result-ref x "assay_type_name"))
		(hit-list-sys-name (result-ref x "hitlist_sys_name"))
		(hit-list-id (substring hit-list-sys-name 3))
		(hit-list-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		(nhits (get-c8 x))
		)
	      (cons (string-append "<tr><td><a href=\"/assayrun/getarid?arid=" id  "\">" assay-run-sys-name "</a></td><td>" assay-run-name "</td><td>" assay-type-name "</td><td><a href=\"/hitlist/gethlbyid?id=" hit-list-id  "\">" hit-list-sys-name "</a></td><td>" hit-list-name "</td><td>" descr "</td><td>" nhits "</td></tr>")
		    prev)
	      ))
        '() a))



(define (get-hit-lists-for-prjid id rc)
  (let* ((sql (string-append "select assay_run.id, assay_run.assay_run_sys_name, assay_run.assay_run_name, assay_type.assay_type_name, hit_list.hitlist_sys_name, hit_list.hitlist_name, hit_list.descr, hit_list.n  FROM assay_run, plate_set, hit_list, assay_type WHERE assay_type.id=assay_run.assay_type_id AND hit_list.assay_run_id=assay_run.id  AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id =" id ))
	(holder (DB-get-all-rows (:conn rc sql))))
	(string-concatenate (prep-hl-for-prj-rows holder))))



;;    (display holder)))

;; (get-hit-lists-for-prjid "1")

(get "/plateset/getps"
     #:conn #t
     #:session #t
;;     #:with-auth "login"
     #:cookies '(names sid)			  
		 (lambda (rc)
		   (let* (			 
			  (help-topic "plateset")
			  (prjid  (get-from-qstr rc "id"))
			 ;; (dummy (:cookies-set! rc 'prjid "prjid" (get-prjid rc sid)))
			 ;; (dummy (:cookies-remove! rc 'prjid ))
			 ;; (dummy (:cookies-set! rc 'prjid "prjid" prjid))
			 ;; (dummy (:cookies-setattr! rc 'prjid #:path "/"))
			  (sid (:cookies-value rc "sid"))
			  (dummy (update-prjid rc sid prjid))
		;;	  (sql (string-append "select plate_set.id, plate_set_sys_name, plate_set_name, plate_set.descr, plate_type_name, num_plates, plate_set.plate_format_id, plate_layout_name_id, plate_layout_name.replicates from plate_set, plate_type, plate_layout_name where plate_set.plate_type_id=plate_type.id AND plate_set.plate_layout_name_id=plate_layout_name.id AND plate_set.project_id =" prjid ))

(sql (string-append "SELECT plate_set.id, plate_set.plate_set_sys_name, plate_set_name, plate_set.descr,  plate_type.plate_type_name, num_plates, format,  plate_layout_name.sys_name,  plate_layout_name.id, plate_layout_name.replicates, rearray_pairs.ID FROM  plate_format, plate_type, plate_layout_name, plate_set FULL outer JOIN rearray_pairs ON plate_set.id= rearray_pairs.dest WHERE plate_format.id = plate_set.plate_format_id AND plate_set.plate_layout_name_id = plate_layout_name.id  AND plate_set.plate_type_id = plate_type.id  AND project_id =" prjid " ORDER BY plate_set.id"))
			  
			  (holder (DB-get-all-rows (:conn rc sql)))
			  (body  (string-concatenate  (prep-ps-for-prj-rows holder)) )
			  (assay-runs (get-assay-runs-for-prjid prjid rc))
			  (hit-lists (get-hit-lists-for-prjid prjid rc))
			  (prjidq (addquotes prjid))
			  )      
		     (view-render "getps" (the-environment))
		     )))



(post "/plateset/editps"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid userid group sid)
		  (lambda (rc)
		    (let* ((help-topic "plateset")
			   ;;(prjid (get-prjid rc sid))
			   (sid (:cookies-value rc "sid"))
			   (prjid (get-prjid rc sid))
			 	   ;;(qstr  (:from-post rc 'get))
			  ;; (a (delete #f (map (match-lambda (("plateset-id" x) x)(_ #f))  qstr)))
			  ;; (b (map uri-decode  a))
			  ;; (a   (:from-post rc 'get-vals "plateset-id"))
			   (b  (list (uri-decode (:from-post rc 'get-vals "plateset-id"))))
			   (activity (:from-post rc 'get-vals "activity"))							
			   (start (map string-split b (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
			   (psid (caar start))
			   (sql (string-append "select plate_set_name, descr from plate_set where id=" psid ))
			   (holder   (car (DB-get-all-rows (:conn rc sql))))
			   (descr  (object->string (cdadr holder)))
			   (name (object->string (cdar holder))))
		      (view-render "editps" (the-environment)))			   
		   ))


(plateset-define editaction
		(options #:conn #t #:cookies '(names prjid userid group sid))
		(lambda (rc)
		  (let* ((help-topic "plateset")
			 (sid (:cookies-value rc "sid"))
			 (prjid (get-prjid rc sid))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
			 (ps-name (get-from-qstr rc "psname"))
			 (descr (get-from-qstr rc "descr"))
			 (psid (get-from-qstr rc "psid"))			 
			 (sql (string-append "UPDATE plate_set SET plate_set_name='" ps-name "', descr='" descr "' WHERE id=" psid))
			 (dummy (:conn rc sql))
			 )
;;		    (view-render "test" (the-environment))
		    (redirect-to rc (get-redirect-uri (string-append "plateset/getps?id="  prjid)))
  )))



(post "/plateset/group"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
		  (lambda (rc)
		    (let* ((help-topic "group")
			   (today (date->string  (current-date) "~Y-~m-~d"))
		;;	 (prjid (:cookies-ref rc 'prjid "prjid"))
			 (sid (:cookies-value rc "sid"))
			 (prjid (get-prjid rc sid))
			 (qstr  (:from-post rc 'get))
			 (a (delete #f (map (match-lambda (("plateset-id" x) x)(_ #f))  qstr)))
			 (b (map uri-decode  a))
			 (start (map string-split b (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
			 (c (map string-append (circular-list "PS-")  (map car start) ))
			 (d (map string-append c (circular-list " (")  ))
			 (ps-num-text  (string-join (map string-append d (map cadr start) (circular-list ");"))))
			 (tot-plates (apply + (map string->number (map cadr start))))
			 (username (cadr (get-id-name-group-email-for-session rc sid)))		    
			 (format-equal? (apply equal? (map caddr start)))
			 (layout-equal? (apply equal? (map cadddr start)))
			 (format (car (map caddr start)))
			 (lyt-id (car (map cadddr start)))
			 (sql2 (string-append "SELECT name, descr from plate_layout_name where id =" lyt-id))
			 (holder2    (car  (DB-get-all-rows (:conn rc sql2))))
			 (lyt-txt (string-append  (cdar  holder2)  "; "  (cdadr  holder2)) )			     			   
			 (sql3 (string-append "SELECT id, plate_type_name from plate_type"))
			 (holder3  (DB-get-all-rows (:conn rc sql3)))
			 (plate-types-pre '())
			 (plate-types (dropdown-contents-with-id holder3 plate-types-pre))
			 (totplatesq (addquotes (number->string tot-plates)))
			 (formatq (addquotes format))
			 (lytidq (addquotes lyt-id))
			 )
		      (if (and format-equal? layout-equal?)
			  (view-render "groupps" (the-environment))
			  (view-render "grouperror" (the-environment))))))
		      

(post  "/plateset/addaction"
       #:conn #t
       #:cookies '(names prjid lnuser userid group sid)
       #:from-post 'qstr
       (lambda (rc)
	 (let* ((help-topic "plateset")
		(psname (:from-post rc 'get-vals "psname"))
		(psdescr (:from-post rc 'get-vals "psdescr"))
 		(numplates (:from-post rc 'get-vals "numplates"))
		(format (:from-post  rc 'get-vals "format"))
		(plttypeid (:from-post  rc 'get-vals "plttypeid"))
		(sid (:cookies-value rc "sid"))
		(prjid (get-prjid rc sid))
		(spllytid (:from-post rc 'get-vals "samplelyt"))
		(trglytid (if (:from-post rc 'get-vals "trglyt") (:from-post rc 'get-vals "trglyt") "1"))
		(sql (string-append "select new_plate_set('" psdescr "', '" psname  "', " numplates ", " format ", " plttypeid ", " prjid ", " spllytid ", '" sid "', true, " trglytid  ")"))
		(holder  (DB-get-all-rows (:conn rc sql)))		
		(dest (string-append "/plateset/getps?id=" prjid))
		)
	  ;; (view-render "test2" (the-environment))
	   (redirect-to rc (get-redirect-uri dest ))
	   )))


;; (post  "/plateset/addstep2"
;;        #:conn #t
;;        #:cookies '(names prjid lnuser userid group sid)
;;        #:from-post 'qstr
;;        (lambda (rc)
;; 	 (let* ((help-topic "plateset")
;; 		(psname (uri-decode (:from-post rc 'get-vals "psname")))
;; 		(psdescr (uri-decode (:from-post rc 'get-vals "psdescr")))
;;  	;;	(numplates (:from-post rc 'get-vals "numplates"))
;;  		(numplates-pre (:from-post rc 'get-vals "numplates"))
;; 		(gt10? (> (string->number numplates-pre) 10))
;; 		(numplates (if gt10?
;; 			       (let*(
;; 				     (sql "SELECT  cust_id, cust_key, cust_email FROM config WHERE id=1")
;; 				     (ret   (car (DB-get-all-rows (:conn rc sql))))
;; 				     (cust_id (assoc-ref ret "cust_id"))
;; 				     (cust_key (assoc-ref ret "cust_key"))
;; 				     (email (assoc-ref ret "cust_email"))
;; 				     (licensed? (if (and cust_id cust_key email ) (validate-key cust_id email cust_key) #f))
;; 				     )
;; 				 (if licensed? numplates-pre "10") )
;;        		   numplates-pre))		

;; 		(format (:from-post  rc 'get-vals "format"))
;; 		(typeid (:from-post  rc 'get-vals "type"))
;; 		(plttype (cond
;; 		       ((equal? typeid "1") "assay")
;; 		       ((equal? typeid "2") "rearray")
;; 		       ((equal? typeid "3") "master")
;; 		       ((equal? typeid "4") "daughter")
;; 		       ((equal? typeid "5") "archive")
;; 		       ((equal? typeid "6") "replicate")))
;; 		(prjid (get-prjid rc sid))
;; 		(sid (:cookies-value rc "sid"))
;; 		(reps 1)  ;;new plate sets never have replicates
;; 		(sql (string-append "select id, name from plate_layout_name WHERE source_dest = 'source' AND plate_format_id =" format))
;; 		(holder  (DB-get-all-rows (:conn rc sql)))
;; 		(sample-layout-pre '())
;; 		(sample-layouts (string-concatenate (dropdown-contents-with-id holder sample-layout-pre)))
		
;; 		;; (sql2 (if (= reps 0)				    
;; 		;; 	  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid "  OR project_id IS NULL )")   
;; 		;; 	  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid " AND reps = " (number->string reps) ") OR (project_id IS NULL AND reps = " (number->string reps) ")")))
;; 		 (sql2 (if (equal? format "96")				    
;; 			  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid " AND reps = 1) OR (project_id IS NULL AND reps =1)")
;; 			  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid "  OR project_id IS NULL )")   
;; 			  ))

;; 		(holder2  (DB-get-all-rows (:conn rc sql2)))
;; 		(target-layout-pre '())
;; 		(target-layouts  (string-concatenate (dropdown-contents-with-id holder2 target-layout-pre)))
		
;; 		(trg-desc (cond
;; 			   ((equal? plttype "assay")
;; 			    (if (equal? format "96") "(only singlicates)" "(optional)")
;; 			    )
;; 			    (else "(disabled -- for assay plates only)")))
;; 		(prjidq (addquotes prjid))
;; 		(sidq (addquotes sid))
;; 		(psnameq (addquotes psname))
;; 		(psdescrq (addquotes psdescr))
;; 		(formatq (addquotes format))
;; 		(plttypeidq (addquotes typeid))
;; 		(plttypeq (addquotes plttype))
;; 		(numplatesq (addquotes numplates))
		
;; 		)      
;; 	   (view-render "addstep2" (the-environment)))))


;; old version above
;; this version makes use of (labsolns artass) maxnumplates variable
;; (post  "/plateset/addstep2"
;;        #:conn #t
;;        #:cookies '(names prjid lnuser userid group sid)
;;        #:from-post 'qstr
;;        (lambda (rc)
;; 	 (let* ((help-topic "plateset")
;; 		(psname (uri-decode (:from-post rc 'get-vals "psname")))
;; 		(psdescr (uri-decode (:from-post rc 'get-vals "psdescr")))
;;  	;;	(numplates (:from-post rc 'get-vals "numplates"))
;;  		(numplates-pre (:from-post rc 'get-vals "numplates"))
;; 		(toobig? (> (string->number numplates-pre) (string->number maxnumplates)))
;; 		(numplates (if toobig? maxnumplates numplates-pre))		
;; 		(format (:from-post  rc 'get-vals "format"))
;; 		(typeid (:from-post  rc 'get-vals "type"))
;; 		(plttype (cond
;; 		       ((equal? typeid "1") "assay")
;; 		       ((equal? typeid "2") "rearray")
;; 		       ((equal? typeid "3") "master")
;; 		       ((equal? typeid "4") "daughter")
;; 		       ((equal? typeid "5") "archive")
;; 		       ((equal? typeid "6") "replicate")))
;; 		(prjid (:cookies-value rc "prjid"))
;; 		(sid (:cookies-value rc "sid"))
;; 		(reps 1)  ;;new plate sets never have replicates
;; 		(sql (string-append "select id, name from plate_layout_name WHERE source_dest = 'source' AND plate_format_id =" format))
;; 		(holder  (DB-get-all-rows (:conn rc sql)))
;; 		(sample-layout-pre '())
;; 		(sample-layouts (string-concatenate (dropdown-contents-with-id holder sample-layout-pre)))
		
;; 		;; (sql2 (if (= reps 0)				    
;; 		;; 	  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid "  OR project_id IS NULL )")   
;; 		;; 	  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid " AND reps = " (number->string reps) ") OR (project_id IS NULL AND reps = " (number->string reps) ")")))
;; 		 (sql2 (if (equal? format "96")				    
;; 			  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid " AND reps = 1) OR (project_id IS NULL AND reps =1)")
;; 			  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid "  OR project_id IS NULL )")   
;; 			  ))

;; 		(holder2  (DB-get-all-rows (:conn rc sql2)))
;; 		(target-layout-pre '())
;; 		(target-layouts  (string-concatenate (dropdown-contents-with-id holder2 target-layout-pre)))
		
;; 		(trg-desc (cond
;; 			   ((equal? plttype "assay")
;; 			    (if (equal? format "96") "(only singlicates)" "(optional)")
;; 			    )
;; 			    (else "(disabled -- for assay plates only)")))
;; 		(prjidq (addquotes prjid))
;; 		(sidq (addquotes sid))
;; 		(psnameq (addquotes psname))
;; 		(psdescrq (addquotes psdescr))
;; 		(formatq (addquotes format))
;; 		(plttypeidq (addquotes typeid))
;; 		(plttypeq (addquotes plttype))
;; 		(numplatesq (addquotes numplates))
		
;; 		)      
;; 	   (view-render "addstep2" (the-environment)))))

;; this is 3rd version where registration allows the use of maxplates otherwise max is 10
;; need new variable allowedplates passed from form
(post  "/plateset/addstep2"
       #:conn #t
       #:cookies '(names prjid sid)
       #:from-post 'qstr
       (lambda (rc)
	 (let* ((help-topic "plateset")
		(psname (uri-decode (:from-post rc 'get-vals "psname")))
		(psdescr (uri-decode (:from-post rc 'get-vals "psdescr")))
		(allowedplates (uri-decode (:from-post rc 'get-vals "allowedplates")))
		
 	;;	(numplates (:from-post rc 'get-vals "numplates"))
 		(numplates-pre (:from-post rc 'get-vals "numplates"))
		(toobig? (> (string->number numplates-pre) (string->number allowedplates)))	
		(numplates  (if toobig? allowedplates numplates-pre))
		(format (:from-post  rc 'get-vals "format"))
		(typeid (:from-post  rc 'get-vals "type"))
		(plttype (cond
		       ((equal? typeid "1") "assay")
		       ((equal? typeid "2") "rearray")
		       ((equal? typeid "3") "master")
		       ((equal? typeid "4") "daughter")
		       ((equal? typeid "5") "archive")
		       ((equal? typeid "6") "replicate")))
		(sid (:cookies-value rc "sid"))
		(prjid (get-prjid rc sid))
		(reps 1)  ;;new plate sets never have replicates
		(sql (string-append "select id, name from plate_layout_name WHERE source_dest = 'source' AND plate_format_id =" format))
		(holder  (DB-get-all-rows (:conn rc sql)))
		(sample-layout-pre '())
		(sample-layouts (string-concatenate (dropdown-contents-with-id holder sample-layout-pre)))
		
		;; (sql2 (if (= reps 0)				    
		;; 	  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid "  OR project_id IS NULL )")   
		;; 	  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid " AND reps = " (number->string reps) ") OR (project_id IS NULL AND reps = " (number->string reps) ")")))
		 (sql2 (if (equal? format "96")				    
			  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid " AND reps = 1) OR (project_id IS NULL AND reps =1)")
			  (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id= " prjid "  OR project_id IS NULL )")   
			  ))

		(holder2  (DB-get-all-rows (:conn rc sql2)))
		(target-layout-pre '())
		(target-layouts  (string-concatenate (dropdown-contents-with-id holder2 target-layout-pre)))
		
		(trg-desc (cond
			   ((equal? plttype "assay")
			    (if (equal? format "96") "(only singlicates)" "(optional)")
			    )
			    (else "(disabled -- for assay plates only)")))
		(prjidq (addquotes prjid))
		(sidq (addquotes sid))
		(psnameq (addquotes psname))
		(psdescrq (addquotes psdescr))
		(formatq (addquotes format))
		(plttypeidq (addquotes typeid))
		(plttypeq (addquotes plttype))
		(numplatesq (addquotes numplates))
		
		)      
	   (view-render "addstep2" (the-environment)))))




		      
(plateset-define add
      (options #:conn #t
      #:cookies '(names prjid lnuser userid group sid))
      (lambda (rc)
	(let* ((help-topic "plateset")
	       (format (get-from-qstr rc "format"))
	       (plttype (get-from-qstr rc "type"))
	       (prjid (get-from-qstr rc "prjid"))
	       (sid (:cookies-value rc "sid"))
	       (sql3 (string-append "SELECT id, plate_type_name from plate_type"))
	       (holder3  (DB-get-all-rows (:conn rc sql3)))
	       (plate-types-pre '())
	       (plate-types (string-concatenate (dropdown-contents-with-id holder3 plate-types-pre)))
	       
	       
	       ;; (numplates-pre (if toobig? maxnumplates numplates-pre-pre))
	       
	       (gt10? (>  maxnumplates 10))
	       (registered? (if gt10?
				(let*(
				      (sql "SELECT  cust_id, cust_key, cust_email FROM config WHERE id=1")
				      (ret   (car (DB-get-all-rows (:conn rc sql))))
				      (cust_id (assoc-ref ret "cust_id"))
				      (cust_key (assoc-ref ret "cust_key"))
				      (email (assoc-ref ret "cust_email")))
				  (if (and cust_id cust_key email ) (validate-key cust_id email cust_key) #f)) #f))
	       (allowedplates  (if registered? (number->string maxnumplates) "10"))
	       (prjidq (addquotes prjid))
	       (allowedplatesq (addquotes allowedplates))
	       (sidq (addquotes sid)))      
	  (view-render "add" (the-environment)))))



(post "/plateset/createbygroup"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
		  (lambda (rc)
		    (let* ((help-topic "plateset")
			   (today (date->string  (current-date) "~Y-~m-~d"))
			   (qstr  (:from-post rc 'get))
			   (sid (:cookies-value rc "sid"))
			   (prjid (:cookies-value rc  "prjid"))
			   (userid (:cookies-value rc "userid"))
			   (group (:cookies-value rc "group"))
			   (username (cadr (get-id-name-group-email-for-session rc sid)))		    
			   (psname (uri-decode (:from-post rc 'get-vals "psname")))
			   (descr (uri-decode (:from-post rc 'get-vals "descr")))
			   (tot-plates (:from-post rc 'get-vals "totplates"))
			   (format (:from-post rc 'get-vals "format"))
			   (type (:from-post rc 'get-vals "type"))
			   (lyt-id (:from-post rc 'get-vals "lytid"))

			   ;; see dbi.groupPlateSetsIntoNewPlateSet
			   ;;CREATE OR REPLACE FUNCTION new_plate_set_from_group(_descr VARCHAR(30),_plate_set_name VARCHAR(30), _num_plates INTEGER, _plate_format_id INTEGER, _plate_type_id INTEGER, _project_id INTEGER, _plate_layout_name_id INTEGER, _sessions_id VARCHAR(32))
			   ;; returns plate-set-id
			   (sql (string-append "SELECT new_plate_set_from_group('" descr "', '" psname "', " tot-plates ", " format ", " type ", " prjid ", " lyt-id ", '" sid "')"))

       			   (psid (DB-get-all-rows (:conn rc sql)))
			  ;; (sql2 (string-append "select plate_set.id, plate_set_sys_name, plate_set_name, plate_set.descr, plate_type_name, num_plates, plate_set.plate_format_id, plate_layout_name_id, plate_layout_name.replicates from plate_set, plate_type, plate_layout_name where plate_set.plate_type_id=plate_type.id AND plate_set.plate_layout_name_id=plate_layout_name.id AND plate_set.project_id =" prjid ))

;; with worklist
			   (sql2 (string-append "SELECT plate_set.id, plate_set.plate_set_sys_name, plate_set_name, plate_set.descr,  plate_type.plate_type_name, num_plates, format,  plate_layout_name.name,  plate_layout_name.id, plate_layout_name.replicates, rearray_pairs.ID FROM  plate_format, plate_type, plate_layout_name, plate_set FULL outer JOIN rearray_pairs ON plate_set.id= rearray_pairs.dest WHERE plate_format.id = plate_set.plate_format_id AND plate_set.plate_layout_name_id = plate_layout_name.id  AND plate_set.plate_type_id = plate_type.id  AND project_id =" prjid " ORDER BY plate_set.id"))

			  (holder (DB-get-all-rows (:conn rc sql2)))
			  (body  (string-concatenate  (prep-ps-for-prj-rows holder)) )
			  (assay-runs (get-assay-runs-for-prjid prjid rc))
			  (hit-lists (get-hit-lists-for-prjid prjid rc))
			  (prjidq (addquotes prjid))
			   )
		      (view-render "getps" (the-environment))
		     ;; (view-render "test2" (the-environment))
		      
		      )))


(define (transfer-data-to-server d)
  ;;this accepts a data transfer e.g. (:from-post rc 'get-vals "datatransfer")
  ;;which must be uri-decoded
  ;;the datatransfer is read by javascript on the client
  (let* (
	 (a (uri-decode d))
	;; (b (map list (cdr (string-split a #\newline))))
	 (temp-f (string-append "pub/" (get-rand-file-name "rnd" "txt")))
	 (p  (open-output-file temp-f))
	 (dummy (begin
		  (put-string p a )
		  (force-output p))))
    temp-f))



(define (process-ar-row lst results arid)
  (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results "(" (number->string arid) ", " (caar lst) ", " (cadar lst) ", "  (caddar lst)   ")" ))
       results)
       (begin
	 (set! results (string-append results "("  (number->string arid) ", " (caar lst) ", " (cadar lst) ", "  (caddar lst)   ")," ))
	 (process-ar-row (cdr lst) results arid)) ))

    
(define (get-sql-assay-results-file f arid)
  ;;for processing the tab delimitted file on the server
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (message "")
	     (ret (stripfix (read-line my-port)))
	     (header (string-split ret #\tab))
	     (result (let* (
			    (ret (read-line my-port))
			    (dummy2 (while (not (eof-object? ret))
				      (if (equal? (car (string-split (stripfix ret) #\tab)) "") #f
					  (set! holder (cons (string-split (stripfix ret) #\tab) holder)))
				      (set! ret  (read-line my-port))))
			    (holder2 (process-ar-row holder "" arid))
			    (sql (string-append "INSERT INTO assay_result_pre (assay_run_id, plate_order, well, response) VALUES " holder2)))	 
				 sql)))
	     result)
      #f))
;; (if (and (string=? (car header) "plate")
;; 			     (string=? (cadr header) "well")
;; 			     (string=? (caddr header) "response"))


(define (process-list-into-pgarray lst results)
  ;; results is a string like "'{"2" "3" "4"}'" note the single quotes
 (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results "\"" (number->string (cdar lst)) "\"" ))
       (string-append "'{" results  "}'"))
       (begin
	 (set! results  (string-append results "\"" (number->string (cdar lst)) "\","  ))
	 (process-list-into-pgarray (cdr lst) results)) ))

  
(define (make-threshold-hitlist threshold arid rc)
(let* ((sql (string-append "SELECT  well_sample.sample_id FROM assay_result, assay_run, plate_layout_name, plate_layout, plate_set, plate, plate_plate_set, well_numbers, well, well_sample WHERE assay_run.plate_set_id = plate_set.id AND assay_run.plate_layout_name_id = plate_layout_name.id AND assay_run.id=assay_result.assay_run_id AND assay_result.plate_order = plate_plate_set.plate_order AND assay_result.well = well.by_col AND plate_set.plate_layout_name_id = plate_layout_name.id AND plate_set.plate_format_id = well_numbers.plate_format AND plate_layout.well_by_col=well.by_col AND plate_set.id = plate_plate_set.plate_set_id AND plate_plate_set.plate_id = plate.id AND plate.id = well.plate_id AND well.by_col = well_numbers.by_col AND well_sample.well_id =  well.id AND well.by_col=well_numbers.by_col AND plate_layout_name.id= plate_layout.plate_layout_name_id AND plate_layout.well_type_id=1 AND assay_result.assay_run_id = " (number->string arid) " AND assay_result.norm > " (number->string threshold)  " ORDER BY assay_result.norm"))
       (all-hit-ids  (DB-get-all-rows(:conn rc sql)))
       (numhits (length all-hit-ids))
       (a (map car all-hit-ids))	 
       (results (process-list-into-pgarray a ""))
	 )
    (list numhits results)
    ))

(define (make-topN-hitlist name descr numhits arid sid rc)
  (let* ((sql (string-append "SELECT  well_sample.sample_id FROM assay_result, assay_run, plate_layout_name, plate_layout, plate_set, plate, plate_plate_set, well_numbers, well, well_sample WHERE assay_run.plate_set_id = plate_set.id AND assay_run.plate_layout_name_id = plate_layout_name.id AND assay_run.id=assay_result.assay_run_id AND assay_result.plate_order = plate_plate_set.plate_order AND assay_result.well = well.by_col AND plate_set.plate_layout_name_id = plate_layout_name.id AND plate_set.plate_format_id = well_numbers.plate_format AND plate_layout.well_by_col=well.by_col AND plate_set.id = plate_plate_set.plate_set_id AND plate_plate_set.plate_id = plate.id AND plate.id = well.plate_id AND well.by_col = well_numbers.by_col AND well_sample.well_id =  well.id AND well.by_col=well_numbers.by_col AND plate_layout_name.id= plate_layout.plate_layout_name_id AND plate_layout.well_type_id=1 AND assay_result.assay_run_id = " (number->string arid) " ORDER BY assay_result.norm limit "  numhits))
	 (all-hit-ids  (DB-get-all-rows(:conn rc sql)))
	 (a (map car all-hit-ids))	 
	 (results (process-list-into-pgarray a ""))
	 )
    results
    ))


;; Response
;; public static final int RAW = 0;
;; public static final int NORM = 1;
;; public static final int NORM_POS = 2;
;; public static final int P_ENHANCE = 3;
 
;; Metric
;; TopN = 1
;; Mean+2SD = 2
;; Mean+3SD = 3
;; >0% enhance = 4


(post "/plateset/impassdatadb"  #:conn #t #:from-post 'qstr
            #:cookies '(names prjid sid)

		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			   (sid (:cookies-value rc "sid"))
			
			  (prjid (get-prjid rc sid))
			  ;;(filename (:from-post rc 'get-vals "myfile"))
			 ;; (a (:from-post rc 'get-vals "datatransfer"))
			  ;;(b (map list (cdr (string-split a #\newline))))
			  (datafile (uri-decode (:from-post rc 'get-vals "datafile")))
			  (psid (:from-post rc 'get-vals "psid"))
			  (num-plates (:from-post rc 'get-vals "numplates"))
			  (format (:from-post rc 'get-vals "format"))
			 ;; (rows-needed (:from-post rc 'get-vals "rows-needed"))
			  (assay-descr (:from-post rc 'get-vals "assay-descr"))
			  (ps-descr (uri-decode (:from-post rc 'get-vals "ps-descr")))
			  (control-loc (uri-decode (:from-post rc 'get-vals "controlloc")))
			  (assay-name (:from-post rc 'get-vals "assayname"))
			  (assay-type (:from-post rc 'get-vals "assay-type"))
			  (sql (string-append "SELECT id from assay_type where assay_type_name ='" assay-type "'"))
			  (assay-type-id (object->string (cdaar (DB-get-all-rows (:conn rc sql)))))
			  (lyt-sys-name (uri-decode (:from-post rc 'get-vals "lytsysname")))
			  (plt-lyt-name-id  (substring lyt-sys-name 4))
			  (algorithm (:from-post rc 'get-vals "algorithm"))
			  (hl-name (:from-post rc 'get-vals "hlname"))
			  (hl-descr (:from-post rc 'get-vals "hldescr"))
			  (sql2 (string-append "SELECT new_assay_run('" assay-name "', '" assay-descr  "', " assay-type-id ", " psid ", " plt-lyt-name-id ", '" sid "')"))
		  	  ;;(lyt-txt (string-append lyt-sys-name ";" lyt-name ))
			  (assay-run-id (cdaar (DB-get-all-rows (:conn rc sql2))))
			 ;; (assay-run-id 2)
			  (sql3 (get-sql-assay-results-file datafile assay-run-id))
			  (dummy (:conn rc sql3))
			  (sql4 (string-append "SELECT process_assay_run_data( " (number->string assay-run-id)  ")"))
			  (dummy (:conn rc sql4))
			  (dummy (sleep 5))
			  (threshold (cond
				      ((equal? algorithm "1")  ;;Top N
				       (let* ((numhits (:from-post rc 'get-vals "nhits"))
					      (pgarray (make-topN-hitlist hl-name hl-descr numhits assay-run-id sid rc))
					      (sql (string-append "SELECT new_hit_list ('" hl-name "', '" hl-descr "', "  numhits ", " (number->string assay-run-id) ", '" sid "', " pgarray ")" ))
					      (dummy (:conn rc sql))
					      )	 #f) )
				      
				      ((equal? algorithm "2")  ;; mean(background) + 2SD
				       (let* ((sql (string-append "SELECT mean_neg_2_sd FROM assay_run_stats WHERE response_type = 1 AND assay_run_id=" (number->string assay-run-id )))
					      (threshold (cdaar (DB-get-all-rows (:conn rc sql))))
					      (results (make-threshold-hitlist threshold assay-run-id rc))
					      (sql2 (string-append "SELECT new_hit_list ('" hl-name "', '" hl-descr "', "  (number->string (car results)) ", " (number->string assay-run-id) ", '" sid "', "  (cadr results) ")" ))
					      (dummy (:conn rc sql2))
					      )
					 #f   ))
				       
				      ((equal? algorithm "3")  ;; mean(background) + 3SD
				       (let* ((sql (string-append "SELECT mean_neg_3_sd FROM assay_run_stats WHERE response_type = 1 AND assay_run_id=" (number->string assay-run-id )))
					      (threshold (cdaar (DB-get-all-rows (:conn rc sql))))
					      (results (make-threshold-hitlist threshold assay-run-id rc))
					      (sql2 (string-append "SELECT new_hit_list ('" hl-name "', '" hl-descr "', "  (number->string (car results)) ", " (number->string assay-run-id) ", '" sid "', "  (cadr results) ")" ))
					      (dummy (:conn rc sql2))
					      )
					 sql2   ))
				      
				      ((equal? algorithm "4") ;; >0% enhanced
				       (let* ((sql (string-append "SELECT mean_pos FROM assay_run_stats WHERE response_type = 1 AND assay_run_id=" (number->string assay-run-id )))     
					      (threshold (cdaar (DB-get-all-rows (:conn rc sql))))
					      (results (make-threshold-hitlist threshold assay-run-id rc))
					      (sql2 (string-append "SELECT new_hit_list ('" hl-name "', '" hl-descr "', "  (number->string (car results)) ", " (number->string assay-run-id) ", '" sid "', "  (cadr results) ")" ))
					      (dummy (:conn rc sql2)))
					      					      
					 #f   ))					 
				      (else #f))))
		     
		     (redirect-to rc (get-redirect-uri (string-append "plate/getpltforps?id=" psid)))
		  ;;  (view-render "test2" (the-environment))
		     )))



 ;; String insertSql = "SELECT new_hit_list ( ?, ?, ?, ?, ?, ?);";
 ;;      PreparedStatement insertPs =
 ;;          conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
 ;;      insertPs.setString(1, _name);
 ;;      insertPs.setString(2, _description);
 ;;      insertPs.setInt(3, _num_hits);
 ;;      insertPs.setInt(4, _assay_run_id);
 ;;      insertPs.setInt(5, session_id);
 ;;      insertPs.setArray(6, conn.createArrayOf("INTEGER", hit_list));


(post "/plateset/impdataaction"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
		 (lambda (rc)
		   (let* (
			  (help-topic "plateset")
			 (sid (:cookies-value rc "sid"))
			 (prjid (get-prjid rc sid))
			 (userid (:cookies-value rc "userid"))
			 (group (:cookies-value rc "group"))
				  (filename (:from-post rc 'get-vals "myfile"))
			  (a (:from-post rc 'get-vals "datatransfer"))
			  ;;(b (map list (cdr (string-split a #\newline))))
			  (temp-file (transfer-data-to-server a))
			  (psid (:from-post rc 'get-vals "psid"))
			  (num-plates (:from-post rc 'get-vals "num-plates"))
			  (format (:from-post rc 'get-vals "format"))
			  (rows-needed (:from-post rc 'get-vals "rows-needed"))
			  (descr (:from-post rc 'get-vals "descr"))
			  (ps-descr (uri-decode (:from-post rc 'get-vals "ps-descr")))
			  (control-loc (uri-decode (:from-post rc 'get-vals "control-loc")))
			  (lyt-sys-name (:from-post rc 'get-vals "lyt-sys-name"))
			  (lyt-name (uri-decode (:from-post rc 'get-vals "lyt-name")))			  
		  	 (lyt-txt (string-append lyt-sys-name ";" lyt-name ))
			  )
		     
		     (view-render "impdataaction" (the-environment))
		     ;;(view-render "test" (the-environment))
		     )))



(post "/plateset/importpsdata"
      #:conn #t
      #:from-post 'qstr
       #:cookies '(names prjid sid)
		  (lambda (rc)
		    (let* ((help-topic "plateset")	
			   (all-ps-ids  (list (uri-decode (:from-post rc 'get-vals "plateset-id")))) ;;these are the checked ps-ids - should be only one
			   (activity (:from-post rc 'get-vals "activity"))
			  ;; (filename (:from-post rc 'get-vals "myfile"))
			   (sid (:cookies-value rc "sid"))
			   (prjid (get-prjid rc sid))
			   (userid (:cookies-value rc "userid"))
			   (group (:cookies-value rc "group"))
			   (start (map string-split all-ps-ids (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
			   (psid (caar start))
			   (sql (string-append "select plate_set.plate_set_name, plate_set.descr AS plate_set_descr, plate_set.num_plates, plate_set.plate_format_id, plate_set.plate_layout_name_id,  plate_layout_name.name AS lyt_name, plate_layout_name.descr,  plate_layout_name.control_loc,  plate_layout_name.sys_name from plate_set, plate_layout_name where plate_set.plate_layout_name_id = plate_layout_name.id AND plate_set.id=" psid ))
			   (holder   (car (DB-get-all-rows (:conn rc sql))))
			   (descr (assoc-ref holder "descr"))
			   (format (assoc-ref holder "plate_format_id"))
			   (name (object->string (assoc-ref holder "plate_set_name")))
			   (lyt-name  (object->string (assoc-ref holder "lyt_name")))
			   (lyt-sys-name (assoc-ref holder "sys_name"))
			   (ps-descr (uri-decode (object->string (assoc-ref holder "plate_set_descr"))))
			   (num-plates (assoc-ref holder "num_plates"))
			   (control-loc (assoc-ref holder "control_loc"))
			   (rows-needed (* num-plates format))
			   )
			(view-render "impdata" (the-environment))
		;;	(view-render "test" (the-environment))
				     
			)))

;;;;;;;;;;;;;;;;;;;;
;;;import accessions
;;;;;;;;;;;;;;;;;;;;

(post "/plateset/importaccs"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
      (lambda (rc)
	(let* ((help-topic "plateset")	
	       (all-ps-ids  (list (uri-decode (:from-post rc 'get-vals "plateset-id")))) ;;these are the checked ps-ids - should be only one
	       ;; (filename (:from-post rc 'get-vals "myfile"))
	       (sid (:cookies-value rc "sid"))
	       (prjid (get-prjid rc sid))
	       (start (map string-split all-ps-ids (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
	       (psid  (caar start)) ;;already a string
	       (sql (string-append "SELECT plate_set.num_plates,  plate_set.plate_format_id FROM plate_set WHERE plate_set.ID =" psid ))
	       (holder   (car (DB-get-all-rows (:conn rc sql))))
	       (num-plates (number->string (assoc-ref holder "num_plates")))
	       (format (number->string (assoc-ref holder "plate_format_id")))
	       (sql2 (string-append "SELECT get_number_samples_for_psid(" psid ")"))
	       (holder2 (car (DB-get-all-rows (:conn rc sql2))))	       
	       (rows-needed (number->string (assoc-ref  holder2 "get_number_samples_for_psid")))
	       (psidq (addquotes psid))
	       (formatq (addquotes format))
	       (rows-neededq (addquotes rows-needed))
	       (num-platesq (addquotes num-plates))
	       )
	 (view-render "impaccs" (the-environment))
	  ;;	(view-render "test2" (the-environment))
	  
	  )))


(define (process-accs-row lst results )
  (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results "(" (caar lst) ", " (cadar lst) ", '"  (caddar lst)   "')" ))
       results)
       (begin
	 (set! results (string-append results "(" (caar lst) ", " (cadar lst) ", '"  (caddar lst)   "')," ))
	 (process-accs-row (cdr lst) results)) ))



(define (get-sql-accessions-file f )
  ;;for processing the tab delimitted file on the server
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (message "")
	     (ret (stripfix (read-line my-port)))
	     (header (string-split ret #\tab))
	     (result (let* (
			    (ret (read-line my-port))
			    (dummy2 (while (not (eof-object? ret))
				      (if (equal? (car (string-split (stripfix ret) #\tab)) "") #f
					  (set! holder (cons (string-split (stripfix ret) #\tab) holder)))
				      (set! ret  (read-line my-port))))
			    (holder2 (process-accs-row holder ""))
			    (sql (string-append "INSERT INTO temp_accs_id (plate_order, by_col, accs_id) VALUES " holder2)))	 
				 sql)))
	     result)
      #f))
;; (if (and (string=? (car header) "plate")
;; 			     (string=? (cadr header) "well")
;; 			     (string=? (caddr header) "response"))


(post "/plateset/impaccsaction"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
      (lambda (rc)
	(let* ((help-topic "plateset")	
	       (sid (:cookies-value rc "sid"))
	       (prjid (get-prjid rc sid))
	       (datatransfer (uri-decode (:from-post rc 'get-vals "datatransfer")))
	       (psid (:from-post rc 'get-vals "psid"))
	       (num-plates (:from-post rc 'get-vals "num-plates"))
	       (format (:from-post rc 'get-vals "format"))
	       (rows-needed (:from-post rc 'get-vals "rows-needed"))
	       (temp-file (transfer-data-to-server datatransfer))
	       (sql "TRUNCATE temp_accs_id RESTART IDENTITY CASCADE") ;;previously doing this in the stored procedure
	       (dummy (:conn rc sql)) 
	       (sql2 (get-sql-accessions-file temp-file))
	       (dummy (:conn rc sql2))
	       (sql3 (string-append "SELECT process_access_ids(" psid ")"))
	       (dummy (:conn rc sql3))
	       (dest (string-append "/plateset/getps?id=" prjid))
	       )
	  (redirect-to rc (get-redirect-uri dest ))
;;	  	(view-render "test2" (the-environment))
	  
	  )))


;;;;;;;;;;;;;;;;;;;;
;;;import barcodes
;;;;;;;;;;;;;;;;;;;;

(post "/plateset/importbc"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
      (lambda (rc)
	(let* ((help-topic "barcodes")	
	       (all-ps-ids  (list (uri-decode (:from-post rc 'get-vals "plateset-id")))) ;;these are the checked ps-ids - should be only one
	       ;; (filename (:from-post rc 'get-vals "myfile"))
	       (sid (:cookies-value rc "sid"))
	       (prjid (get-prjid rc sid))
	       (start (map string-split all-ps-ids (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
	       (psid (caar start))
	       
	       (sql (string-append "SELECT plate_set_name, descr, plate_set.num_plates FROM plate_set WHERE plate_set.ID =" psid ))
	       (holder   (car (DB-get-all-rows (:conn rc sql))))
	       (num-plates (number->string (assoc-ref holder "num_plates")))
	       (psname (assoc-ref holder "plate_set_name"))
	       (descr (uri-decode (assoc-ref holder "descr")))
	       (num-platesq (addquotes num-plates))
	       (psnameq (addquotes psname))
	       (descrq (addquotes descr))
	     (psidq (addquotes psid))
	       
	       )
	  (view-render "impbc" (the-environment))
	 ;; 	(view-render "test2" (the-environment))
	  
	  )))


(define (process-bc-row lst results )
  (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results "(" (caar lst) ", '" (cadar lst)   "')" ))
       results)
       (begin
	 (set! results (string-append results "(" (caar lst) ", '" (cadar lst)   "')," ))
	 (process-bc-row (cdr lst) results)) ))



(define (get-sql-bc-file f )
  ;;for processing the tab delimitted file on the server
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (message "")
	     (ret (stripfix (read-line my-port)))
	     (header (string-split ret #\tab))
	     (result (let* (
			    (ret (read-line my-port))
			    (dummy2 (while (not (eof-object? ret))
				      (if (equal? (car (string-split (stripfix ret) #\tab)) "") #f
					  (set! holder (cons (string-split (stripfix ret) #\tab) holder)))
				      (set! ret  (read-line my-port))))
			    (holder2 (process-bc-row holder ""))
			    (sql (string-append "INSERT INTO temp_barcode_id (plate_order, barcode_id) VALUES " holder2)))	 
				 sql)))
	     result)
      #f))


(post "/plateset/impbcaction"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
      (lambda (rc)
	(let* ((help-topic "barcodes")	
	       (sid (:cookies-value rc "sid"))
	       (prjid (get-prjid rc sid))
	       (datatransfer (uri-decode (:from-post rc 'get-vals "datatransfer")))
	       (psid (:from-post rc 'get-vals "psid"))
	       (num-plates (:from-post rc 'get-vals "num-plates"))
	       (descr (:from-post rc 'get-vals "descr"))
	       (psname (:from-post rc 'get-vals "psname"))
	       (temp-file (transfer-data-to-server datatransfer))
	       (sql "TRUNCATE temp_barcode_id RESTART IDENTITY CASCADE") ;;previously doing this in the stored procedure
	       (dummy (:conn rc sql)) 
	       (sql2 (get-sql-bc-file temp-file))
	       (dummy (:conn rc sql2))
	       (sql3 (string-append "SELECT process_barcode_ids(" psid ")"))
	       (dummy (:conn rc sql3))
	       (dest (string-append "/plate/getpltforps?id=" psid))
	       )
	  (redirect-to rc (get-redirect-uri dest ))
;;	  	(view-render "test2" (the-environment))
	  
	  )))




;;;;;;;;;;;;;;;;;;;;
;;;reformat
;;;;;;;;;;;;;;;;;;;;


(post "/plateset/reformat"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
      (lambda (rc)
	(let* ((help-topic "reformat")
	       (sid (:cookies-value rc "sid"))
	       (prjid (get-prjid rc sid))
	       (today (date->string  (current-date) "~Y-~m-~d"))
	       (username (cadr (get-id-name-group-email-for-session rc sid)))
	       (a  (uri-decode (:from-post rc 'get-vals "plateset-id")))
	       (start (string-split a  #\+)) ;;(1 2 96 1 1) psid num-plates format srclytid numreps?
	        (srcpsid  (car start) )
	        ;; ;;(ps-num-text  (string-join (map string-append d (map cadr start) (circular-list ");"))))
	        (srcnplates  ( string->number  (cadr start)))
	        (srcformat  (caddr start))
	        (destformat (number->string (* (string->number srcformat) 4)))
	        (srclytid  (cadddr start))
	        (sql2 (string-append "SELECT name, descr from plate_layout_name where id =" srclytid))
	        (holder2    (car  (DB-get-all-rows (:conn rc sql2))))
	        (srcspllyttxt (string-append  (cdar  holder2)  "; "  (cdadr  holder2)) )			     			   
	       (sql3 (string-append "SELECT id, plate_type_name from plate_type"))
	       (holder3  (DB-get-all-rows (:conn rc sql3)))
	       (plate-types-pre '())
	       (plate-types (dropdown-contents-with-id holder3 plate-types-pre))
	       (srclytidq  (addquotes srclytid))
	       (destformatq (addquotes destformat))
	       (srcpsidq  (addquotes srcpsid) )
	       
	       )		     
	  (view-render "reformatps" (the-environment))
	 ;; (view-render "test2" (the-environment))
	  
	  )))


(post "/plateset/reformatconfirm"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid userid group sid)

		  (lambda (rc)
		    (let* ((help-topic "reformat")
			   (sid (:cookies-value rc "sid"))
		       	   (prjid (get-prjid rc sid))
			   (today (date->string  (current-date) "~Y-~m-~d"))
			   (srcpsid (:from-post rc 'get-vals "srcpsid"))
			   (destname (uri-decode (:from-post rc 'get-vals "destname")))
			   (destdescr (uri-decode (:from-post rc 'get-vals "destdescr")))
			   (desttype (:from-post rc 'get-vals "desttype"))
			   (destformat (:from-post rc 'get-vals "destformat"))
			   (destsamprep (:from-post rc 'get-vals "destsamprep"))
			   (desttargrep (:from-post rc 'get-vals "desttargrep"))
			   (srclytid (:from-post rc 'get-vals "srclytid"))
			   (trglytid (:from-post rc 'get-vals "trglytid")) ;;optional from select dropdown
			   (srcnplates (:from-post rc 'get-vals "srcnplates"))
			   (destnplates (number->string (ceiling (/ (* (string->number srcnplates) (string->number destsamprep)) 4))))			   
			   (destlytdescr (string-append destsamprep "S" desttargrep "T"))			  
			   (sql (string-append "select id, sys_name, name, descr FROM plate_layout_name, layout_source_dest WHERE layout_source_dest.src =" srclytid  " AND layout_source_dest.dest = plate_layout_name.id AND plate_layout_name.descr='" destlytdescr "'"))
			   (holder     (car (DB-get-all-rows (:conn rc sql))))
			   (destlytid (number->string (assoc-ref holder "id")))
			   (destlytsysname (assoc-ref holder "sys_name"))
			   (destlytname (assoc-ref holder "name"))
			   (destlytdescr (assoc-ref holder "descr"))		
			   (destlyttxt (string-append destlytsysname ";" destlytname ";" destlytdescr))
			  (sql2 (string-append "SELECT id, target_layout_name_name FROM target_layout_name WHERE (project_id=" prjid " AND reps = " desttargrep ") OR (project_id IS NULL AND reps =" desttargrep ")"))
			   (holder2  (DB-get-all-rows (:conn rc sql2)))
			   (desttargetlyts (dropdown-contents-with-id holder2 '()))
			   (username (cadr (get-id-name-group-email-for-session rc sid)))
			   (srcpsidq (addquotes srcpsid))
			   (destnameq (addquotes destname))
			   (destdescrq (addquotes destdescr))
			   (desttypeq (addquotes desttype))
			   (destformatq (addquotes destformat))
			   (destsamprepq (addquotes destsamprep))
			   (desttargrepq (addquotes desttargrep))
			   (srclytidq (addquotes srclytid))
			   (srcnplatesq (addquotes srcnplates))
			   (destlytidq (addquotes destlytid))
			   )		     
			  (view-render "reformatconfirm" (the-environment))			 
		;;	  (view-render "test2" (the-environment))			 
		      )))


(post "/plateset/reformataction"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid userid group sid)
		  (lambda (rc)
		    (let* ((help-topic "reformat")
			   (today (date->string  (current-date) "~Y-~m-~d"))
			   (sid (:cookies-value rc "sid"))
			   (prjid (get-prjid rc sid))
			   (srcpsid (:from-post rc 'get-vals "srcpsid"))
			   (destname (:from-post rc 'get-vals "destname"))
			   (destdescr (uri-decode (:from-post rc 'get-vals "destdescr")))
			   (desttype (:from-post rc 'get-vals "desttype"))
			   (destformat (:from-post rc 'get-vals "destformat"))
			   (destsamprep (:from-post rc 'get-vals "destsamprep"))
			   (desttargrep (:from-post rc 'get-vals "desttargrep"))
			   (srclytid (:from-post rc 'get-vals "srclytid"))
			   (destlytid (:from-post rc 'get-vals "destlytid"))			   
			   (srcnplates (:from-post rc 'get-vals "srcnplates"))
			   (desttrglyt (:from-post rc 'get-vals "desttrglyt"))
			   (destnplates (number->string (ceiling (/ (* (string->number srcnplates) (string->number destsamprep)) 4))))			   
			   (destlytdescr (string-append destsamprep "S" desttargrep "T"))
			   (sid (:cookies-value rc "sid"))
			   (sql (string-append "SELECT reformat_plate_set("  srcpsid ", " srcnplates ", "  destsamprep  ", '" destdescr "', '" destname "', " destnplates", " destformat ", "  desttype ", "  prjid ", "  destlytid ", '" sid "', "  desttrglyt  ")"))
			   (holder    (car  (DB-get-all-rows (:conn rc sql))))
			   (destlytid (assoc-ref holder "reformat_plate_set"))
			   )
		      (redirect-to rc (get-redirect-uri (string-append "/plateset/getps?id=" prjid)))
		    ;;  (view-render "test2" (the-environment))
		      )))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Worklists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (prep-wl-rows a)
  (fold (lambda (x prev)
          (let* (
                 (sampleid (get-c1 x))
                 (src-plate (result-ref x "source_plate"))
		 (src-well (get-c3 x))
		 (dest-plate (result-ref x "dest_plate"))
		 (dest-well (get-c5 x))
		)
            (cons (string-append "<tr><td>" sampleid "</td><td>" src-plate "</td><td>" src-well "</td><td>" dest-plate "</td><td>" dest-well "</td></tr>")
		  prev)))
        '() a))




(post "/plateset/worklist"
      #:conn #t
      #:from-post 'qstr
      #:cookies '(names prjid sid)
		  (lambda (rc)
		    (let* ((help-topic "worklist")
			   (sid (:cookies-value rc "sid"))
			   (prjid (get-prjid rc sid))
			   (wl (:from-post rc 'get-vals "wl"))
	
			   (all-ps-ids  (list (uri-decode (:from-post rc 'get-vals "plateset-id")))) ;;these are the checked ps-ids - should be only one
			   (start (map string-split all-ps-ids (circular-list #\+))) ;;((1 2 96 1) (2 2 96 1))
			   (psid (caar start))
	    
			   (sql (string-append "SELECT sample_id, source_plate, source_well, dest_plate, dest_well FROM worklists WHERE rearray_pairs_id ="  wl ))
			   (holder    (DB-get-all-rows (:conn rc sql)))			   
			   (body  (string-concatenate (prep-wl-rows holder)))
			   (prjidq (addquotes prjid))
			   ;;(sidq (addquotes sid))
			   )
		      (view-render "worklist" (the-environment)))
		    ;;  (view-render "test2" (the-environment)))
		    
		   ))

		  ;; SELECT sample_id, source_plate, source_well, dest_plate, dest_well FROM worklists WHERE rearray_pairs_id =1;
