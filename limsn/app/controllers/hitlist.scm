;; Controller hitlist definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller hitlist) ; DO NOT REMOVE THIS LINE!!!

(use-modules (artanis utils)(artanis irregex)
	     (srfi srfi-1)(dbi dbi) (labsolns artass)
	     (ice-9 textual-ports)(ice-9 rdelim)
	     (ice-9 string-fun) ;; string-replace-substring
	     )



(define (prep-hl-for-ar-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(hit-list-sys-name (result-ref x "hitlist_sys_name"))
		(hit-list-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		(nhits (get-c5 x)))
	      (cons (string-append "<tr><td><a href=\"/hitlist/gethlbyid?id=" id  "\">" hit-list-sys-name "</a></td><td>" hit-list-name "</td><td>" descr "</td><td>" nhits "</td></tr>")
		  prev)))
        '() a))


(hitlist-define gethlforarid
		(options #:conn #t)
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (id  (get-from-qstr rc "id")) ;; assay-run id
	   (sql (string-append "select id, hitlist_sys_name, hitlist_name, descr, n from hit_list where assay_run_id =" id ))
	   (holder (DB-get-all-rows (:conn rc sql)))
	   (body  (string-concatenate  (prep-hl-for-ar-rows holder)) ))  
      (view-render "gethlforarid" (the-environment))
      )))


(define (prep-hl-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(sample-sys-name (result-ref x "sample_sys_name"))
		(prj-id (get-c3 x ))
		(accs (result-ref x "accs_id")))
	      
	      (cons (string-append "<tr><td>"  sample-sys-name "</td><td>" prj-id "</td><td>" accs "</td></tr>")
		  prev)))
        '() a))

(define (prep-hl-counts a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(plate-set-sys-name (result-ref x "plate_set_sys_name"))
		(type (cdar (cddr x))) ;; coming out as "max"
		(format (get-c4 x))
		(nhits (get-c5 x)))
	      (cons (string-append "<tr><td> <input type=\"radio\" id=\"psid\" name=\"psid\" value=\"" id "\"></td><td>" id "</td><td>" plate-set-sys-name "</td><td>" type "</td><td>" format "</td><td>" nhits "</td></tr>")
		  prev)))
        '() a))


(hitlist-define gethlbyid
		(options #:conn #t
			 #:cookies '(names prjid sid))
		(lambda (rc)
		  (let* ((help-topic "hitlist")
			 (sid (:cookies-value rc "sid"))
			 (prjid (get-prjid rc sid))
			 (hlid  (get-from-qstr rc "id")) ;; hit-list id
			 ;;here I think the prjid in the sample table is redundant; ignore it and get the prjid <- plate_set <- assay_run
			 ;;(sql (string-append "select sample.id, sample.sample_sys_name, sample.project_id, sample.accs_id  from hit_list, sample, hit_sample where sample.id=hit_sample.sample_id AND hit_list.id=hit_sample.hitlist_id AND hitlist_id =" hlid ))
			 (sql (string-append "select sample.id, sample.sample_sys_name, plate_set.project_id, sample.accs_id  from hit_list, sample, hit_sample, plate_set, assay_run where sample.id=hit_sample.sample_id AND hit_list.id=hit_sample.hitlist_id AND plate_set.id=assay_run.plate_set_id AND hit_list.assay_run_id=assay_run.id  AND hitlist_id =" hlid ))
			 (holder (DB-get-all-rows (:conn rc sql)))
			 (numhits (length  holder))
			 (body  (string-concatenate  (prep-hl-rows holder)) )
			 (sql2 (string-append "SELECT MAX(plate_set.id), plate_set.plate_set_sys_name, MAX(plate_type.plate_type_name), MAX(plate_set.plate_format_id), COUNT(sample.ID) FROM plate_set, plate_plate_set, plate_type, plate, well, well_sample, sample WHERE plate_plate_set.plate_set_id=plate_set.ID AND plate_plate_set.plate_id=plate.id AND plate_set.plate_type_id = plate_type.id   and well.plate_id=plate.ID AND well_sample.well_id=well.ID AND well_sample.sample_id= sample.ID  AND sample.id  IN (SELECT  sample.id FROM hit_list, hit_sample, plate_set, assay_run, sample WHERE hit_sample.hitlist_id=hit_list.id  AND hit_sample.sample_id=sample.id  and assay_run.plate_set_id=plate_set.id AND   hit_list.assay_run_id=assay_run.id   AND  hit_sample.hitlist_id IN (SELECT hit_list.ID FROM hit_list, assay_run WHERE hit_list.assay_run_id=assay_run.ID AND hit_list.id= " hlid " and assay_run.ID IN (SELECT assay_run.ID FROM assay_run WHERE assay_run.plate_set_id IN (SELECT plate_set.ID FROM plate_set WHERE plate_set.project_id=" prjid ")))) GROUP BY plate_set.plate_set_sys_name" ))
			 (holder2 (DB-get-all-rows (:conn rc sql2)))
			 (body2  (string-concatenate  (prep-hl-counts holder2)) )
			 (prjidq (addquotes prjid))
			 (sidq (addquotes sid))
			 (hlidq (addquotes hlid))
			 (numhitsq (addquotes (number->string numhits)))
			 
	       	 )
		   (view-render "gethlbyid" (the-environment))
		   ;; (view-render "test2" (the-environment))
		    
		    )))


(hitlist-define test
		(lambda (rc)
		  (let* ((help-topic "hitlist")
			 ;; (prjid (get-prjid rc sid))
			 ;; (userid (:cookies-value rc "userid"))
			 ;; (group (:cookies-value rc "group"))
			 ;; (sid (:cookies-value rc "sid"))
			 (prjid "1")
			 (userid "1")
			 (group "admin")
			 (sid "0f1a05af5685af9ab62536720c9a74c1"))
		    (view-render "test" (the-environment)))))


(hitlist-define importhl
		;; for ?arid=1
		(options #:cookies '(names prjid sid))
		(lambda (rc)
		  (let* ((help-topic "hitlist")
			 (arid (get-from-qstr rc "arid"))
			 (sid (:cookies-value rc "sid"))
						 
			 (prjid (get-prjid rc sid))
			 )
		    (view-render "importhl" (the-environment)))))


(define (prep-hl-for-prj-rows a)
  (fold (lambda (x prev)
          (let ((id (get-c1 x))
		(hit-list-sys-name (result-ref x "hitlist_sys_name"))
		(hit-list-name (result-ref x "hitlist_name"))
		(descr (result-ref x "descr"))
		(nhits (get-c5 x)))
	      (cons (string-append "<tr><td><a href=\"/hitlist/gethlbyid?id=" id  "\">" hit-list-sys-name "</a></td><td>" hit-list-name "</td><td>" descr "</td><td>" nhits "</td></tr>")
		  prev)))
        '() a))


(hitlist-define forprj
		(options #:conn #t
			 #:cookies '(names prjid sid))
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (sid (:cookies-value rc "sid"))
	   (prjid (get-from-qstr rc "prjid"))
	   (sql (string-append "SELECT hit_list.id, hit_list.hitlist_sys_name, hit_list.hitlist_name, hit_list.descr, hit_list.n FROM hit_list, assay_run, plate_set   WHERE hit_list.assay_run_id=assay_run.id AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id=" prjid ))
	   (holder (DB-get-all-rows (:conn rc sql)))
	   (body  (string-concatenate  (prep-hl-for-prj-rows holder)) ))  
      (view-render "forprj" (the-environment))
      )))

(define (no-empty lst results)
  ;; make a list of strings from objects
  (if (null? (cdr lst))
      (begin
	(if (= (string-length (car lst)) 0 ) #f
	 (set! results  (cons  (car lst) results)))
       results)
       (begin
	(if (= (string-length (car lst)) 0 ) #f
	 (set! results  (cons  (car lst) results)))
	 (no-empty (cdr lst) results )) ))


(define (make-pg-hl lst results b )
  ;; if b is false must remove SPL-
 (if (null? (cdr lst))
      (begin
	(if b (set! results  (string-append   (car lst) "," results))
	    (set! results  (string-append   (substring (car lst)  4 (string-length (car lst))) "," results)) )
       results)
       (begin
	(if b (set! results  (string-append   (car lst) "," results))
	    (set! results  (string-append   (substring (car lst)  4 (string-length (car lst))) "," results)))
	(make-pg-hl (cdr lst) results b))))



;; SELECT new_hit_list('reer', 'reer',6, 4,'fca5ff1c11adc95f24d4a0c83a447d10', '{292,285,284,283,282,281}');

(post "/hitlist/addstep2"
		 #:conn #t
		 #:cookies '(names prjid lnuser userid group sid)
		  #:from-post 'qstr
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (name (:from-post rc 'get "hlname"))
	   (descr (:from-post rc 'get "descr"))
	   (num-hits (:from-post rc 'get "hitcount"))
	   (datatransfer (:from-post rc 'get "datatransfer"))
	   (arid (:from-post rc 'get "arid"))
	   (sid (:cookies-value rc "sid"))
	   (prjid (get-prjid rc sid))
	   (userid (:cookies-value rc "userid"))
	   (group (:cookies-value rc "group"))
	   (a (uri-decode datatransfer))
	   (b (map list (cdr (string-split a #\newline))))
	   (c (map (lambda (x)(string-trim-both (car x) white-chars)) b))
	   (d (no-empty c '()))
	   (id? (if (equal? (substring  (car d) 0 1) "S") #f #t)) ;; is it SPL-1 or 1? #t means yes it is an id #f make id
	   (e (make-pg-hl d "" id?))
	   (f (substring e 0 (- (string-length e) 1)))
	   (sql (string-append "SELECT new_hit_list('" name "', '" descr "'," num-hits ", " arid ", '" sid "', '{" f "}' )" ))
	   (holder (:conn rc sql))
	   (dest (string-append "/assayrun/getid?id=" arid)))  
      (redirect-to rc (get-redirect-uri dest ))
      )))




(post "/hitlist/addtoar"
		 #:conn #t
		 #:cookies '(names prjid lnuser userid group sid)
		 #:from-post 'qstr
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (arid (:from-post rc 'get "arid"))
	   (datatransfer (uri-decode (:from-post rc 'get "datatransfer")))
	   (sid (:cookies-value rc "sid"))
	   (prjid (get-prjid rc sid))	   
	   (userid (:cookies-value rc "userid"))
	   (group (:cookies-value rc "group"))
	   (num-hits (:from-post rc 'get "hitcount"))
	   (aridq (addquotes arid) )
	   (datatransferq (addquotes datatransfer))
	   (num-hitsq (addquotes num-hits))
	   
	  ;; (sql (string-append "SELECT hit_list.id, hit_list.hitlist_sys_name, hit_list.hitlist_name, hit_list.descr, hit_list.n FROM hit_list, assay_run, plate_set   WHERE hit_list.assay_run_id=assay_run.id AND assay_run.plate_set_id=plate_set.id AND plate_set.project_id=" arid ))
	  ;; (holder (DB-get-all-rows (:conn rc sql)))
	 ; ;; (body  (string-concatenate  (prep-hl-for-prj-rows holder)) )
	   )  
      (view-render "addtoar" (the-environment))
      )))


(post "/hitlist/rearray"
		 #:conn #t
		 #:cookies '(names prjid lnuser userid group sid)
		 #:from-post 'qstr
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (hlid (:from-post rc 'get "hlid"))
	   (psid (:from-post rc 'get "psid"))
	   (sid (:cookies-value rc "sid"))
	   (prjid (get-prjid rc sid))	   
	   (numhits (:from-post rc 'get "numhits"))
	   (sql3 (string-append "SELECT id, plate_type_name from plate_type where plate_type_name='rearray'"))
	    (holder3  (DB-get-all-rows (:conn rc sql3))) ;;(((id . 1) (plate_type_name . assay)) ((id . 2) (plate_type_name . rearray)) ....
	   (plate-types-pre '())
	   (plate-types (dropdown-contents-with-id holder3 plate-types-pre)) ;;("assay" "replicate"....)
	   (prjidq (addquotes prjid))
	   (sidq (addquotes sid))
	   (hlidq (addquotes hlid))
	   (psidq (addquotes psid))
	   (numhitsq (addquotes numhits))
	  ;; (holder3q  (addquotes (htmlify (object->string (car holder3)))))
	   )  
      (view-render "rearray" (the-environment))
     ;; (view-render "test2" (the-environment))
      )))


(post "/hitlist/rearraystep2"
		 #:conn #t
		 #:cookies '(names prjid lnuser userid group sid)
		 #:from-post 'qstr
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (hlid (:from-post rc 'get "hlid"))
	   (psid (:from-post rc 'get "psid"))
	   (psname (uri-decode (:from-post rc 'get "psname")))
	   (psdescr (uri-decode (:from-post rc 'get "psdescr")))
	   (format (:from-post rc 'get "format"))
	   (typeid (:from-post rc 'get "typeid")) ;;only rearray
	   (numhits (:from-post rc 'get "numhits"))
	  ;; (platetypespre (:from-post rc 'get "platetypes"))
	  ;; (platetypes (map number->string (string-split "platetypes" #\+)))
	   (platetype "rearray")
	   (sql (string-append "select id, name, descr from plate_layout_name WHERE plate_format_id =" format " AND source_dest='source'"))	  
	    (holder  (DB-get-all-rows (:conn rc sql))) 
	    (sample-layouts-pre '())
	    (sample-layouts (dropdown-contents-with-id holder sample-layouts-pre)) 
	   (trg-desc "trg-desc")
	   (target-layouts "trg-layouts")
	   (sid (:cookies-value rc "sid"))
	   (prjid (get-prjid rc sid))	   
	   (numhits (:from-post rc 'get "numhits"))
	   (typeid (:from-post rc 'get "typeid"))
	   (prjidq (addquotes prjid))
	    (sidq (addquotes sid))
	   (hlidq (addquotes hlid))
	   (psidq (addquotes psid))
	   (numhitsq (addquotes numhits))
	   (psnameq (addquotes psname))
	   (psdescrq (addquotes psdescr))
	   (formatq (addquotes format))
	   ;;(plttypeidq (addquotes typeid))
	   ;;(numplatesq (addquotes numplates))
	   (plttypeq "rearray")
	   )  
      (view-render "rearraystep2" (the-environment))
      )))


(post "/hitlist/rearrayaction"
		 #:conn #t
		 #:cookies '(names prjid lnuser userid group sid)
		 #:from-post 'qstr
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (hlid (:from-post rc 'get "hlid"))
	   (psid (:from-post rc 'get "psid"))
	   (prjid (get-prjid rc sid))	   
	   (userid (:cookies-value rc "userid"))
	   (group (:cookies-value rc "group"))
	   (sid (:cookies-value rc "sid"))
	   (numhits (:from-post rc 'get "numhits"))
	   (psname (uri-decode (:from-post rc 'get "psname")))
	   (psdescr (uri-decode (:from-post rc 'get "psdescr")))
	   (format (:from-post rc 'get "format"))
	   (plttype (:from-post rc 'get "plttype"))
	   (pltlytid  (:from-post rc 'get "samplelyt"))
	   (sql (string-append "SELECT unknown_n FROM plate_layout_name WHERE plate_layout_name.ID ="  pltlytid))
	   (holder  (DB-get-all-rows (:conn rc sql))) 	
	   (num-unks-per-plate (cdaar holder))
	   (numplates (ceiling (/ (string->number numhits) num-unks-per-plate)))
	   ;; using DefaultQuadruplicates for target layout : 3
	   ;; rearray plates are plttype 2
	   ;; with-samples is false
	   (sql3 (string-append "SELECT new_plate_set('" psdescr "', '" psname "', " (number->string numplates) ", " format  ",2 , " prjid ", " pltlytid  ", '" sid "', false, 3 )"))
	   (new-psid (number->string (cdaar (DB-get-all-rows (:conn rc sql3)))))
	   (sql4 (string-append "SELECT rearray_transfer_samples(" psid ", " new-psid ", " hlid ")" ))
	   (dummy  (:conn rc sql4))
	   
	   (destination (string-append "plateset/getps?id=" prjid))
	   )  
      (redirect-to rc (get-redirect-uri destination))
;;      (view-render "test2" (the-environment))
      )))



(define (process-hl-row lst results )
  (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results "<tr><td>" (caar lst) "</td><td>" (cadar lst) "</td><td>" (cadr (cdddar lst))   "</td></tr>" ))
       results)
       (begin
	 (set! results (string-append results "<tr><td>" (caar lst) "</td><td>" (cadar lst) "</td><td>"  (cadr (cdddar lst))  "</td></tr>" ))
	 (process-hl-row (cdr lst) results)
       )
       ))



;; (define (get-hitlist-file f )
;;   ;;for processing the tab delimitted file on the server
;;   (if (access? f R_OK)
;;       (let* (
;; 	     (my-port (open-input-file f))
;; 	     (ret #f)
;; 	     (holder '())
;; 	     (message "made it here")
;; 	     (ret (stripfix (read-line my-port)))
;; 	     (header (string-split ret #\tab))
;; 	     (result (let* (
;; 			    (ret (read-line my-port))
;; 			    (dummy2 (while (not (eof-object? ret))
;; 				      (if (equal? (car (string-split (stripfix ret) #\tab)) "") #f
;; 					  (set! holder (cons (string-split (stripfix ret) #\tab) holder)))
;; 				      (set! ret  (read-line my-port))))
;; 			    (holder2 (process-hl-row holder ""))
;; 			    )	 
;; 		       holder2)))
;; 	     result)
;;       #f))


(define (process-hl-get-int-array lst results )
  (if (null? (cdr lst))
        (begin
	 (set! results  (string-append results  (cadr (cdddar lst))  ))
	  results )
       (begin
	 (set! results (string-append results  (cadr (cdddar lst))  "+" ))
	 (process-hl-get-int-array (cdr lst) results)
       )
       ))



(define (get-hitlist-as-list f )
  ;;for counting and making int array for postgres
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (ret (stripfix (read-line my-port)))
	     (header (string-split ret #\tab))
	     (result (let* (
			    (ret (read-line my-port))
			    (dummy2 (while (not (eof-object? ret))
				      (if (equal? (car (string-split (stripfix ret) #\tab)) "") #f
					  (set! holder (cons (string-split (stripfix ret) #\tab) holder)))
				      (set! ret  (read-line my-port))))
			    )	 
		       holder)))
	     result)
      #f))



(post "/hitlist/viewhits"
		 #:conn #t
		 #:cookies '(names prjid sid)
		 #:from-post 'qstr
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (sid (:cookies-value rc "sid"))
	   (prjid (get-prjid rc sid))	   
	   (arid (:from-post rc 'get-vals "arid"))
	   (threshold-id (:from-post rc 'get-vals "threshold"))
	   (threshold (cond((equal? threshold-id "1") "mean(pos)")
			   ((equal? threshold-id "2") "mean(neg) + 2SD")
			   ((equal? threshold-id "3") "mean(neg) + 3SD")
			   (else "(Manually entered)")))
	   (response-id (:from-post rc 'get-vals "response"))
	   (response (cond ((equal? response-id "0") "Background Subtracted")
			   ((equal? response-id "1") "Normalized")
			   ((equal? response-id "2") "Normalized to postivie controls")
			   ((equal? response-id "3") "% Enhanced")))
	   
	   (hitfile (string-append "../lnserver/pub/" (uri-decode (:from-post rc 'get-vals "hitfile"))))
	   (aslist (get-hitlist-as-list hitfile))
	   (body (process-hl-row aslist ""))
	   ;;(body (get-hitlist-file hitfile))
	   (num-hits (length aslist))
	   (hl-int-arrayq (addquotes (process-hl-get-int-array aslist "")))
	 (aridq (addquotes arid))
	   )  
      (view-render "viewhits" (the-environment))
    ;;  (view-render "test2" (the-environment))
      )))


;;new_hit_list(_name VARCHAR(250), _descr VARCHAR(250), _num_hits INTEGER, _assay_run_id INTEGER, _sessions_id VARCHAR(32), hit_list integer[])

(post "/hitlist/newhitlistfromview"
		 #:conn #t
		 #:cookies '(names prjid sid)
		 #:from-post 'qstr
  (lambda (rc)
    (let* ((help-topic "hitlist")
	   (sid (:cookies-value rc "sid"))
	   (prjid (get-prjid rc sid))	   
	   (arid (:from-post rc 'get-vals "arid"))
	   (hlname (:from-post rc 'get-vals "hlname"))
	   (descr (:from-post rc 'get-vals "descr"))
	   (num-hits (:from-post rc 'get-vals "numhits"))
	   ;; want a string like "'{"2", "3", "4"}'" note the single quotes
	   (int-array  (uri-decode (:from-post rc 'get-vals "int-array")))
	   (int-array (string-replace-substring int-array "+" "\", \""))
	   (sql (string-append "SELECT new_hit_list('" hlname "', '" descr "', " num-hits ", " arid ", '" sid "', '{\"" int-array"\"}')" ))
	   (dest (string-append "/assayrun/getarid?arid=" arid))
	   )  
      (redirect-to rc (get-redirect-uri dest))
     ;; (view-render "test2" (the-environment))
      )))


