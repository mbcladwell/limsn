;; Controller layout definition of lnserver
;; Please add your license header here.
;; This file is generated automatically by GNU Artanis.
(define-artanis-controller layout) ; DO NOT REMOVE THIS LINE!!!

;; https://web-artanis.com/docs/manual.html#org5cb8432
;; (add-to-load-path "/home/mbc/projects/ln4/")

(use-modules (artanis artanis)(artanis utils)(artanis irregex)	     
	     (srfi srfi-1)(dbi dbi) (labsolns artass)(labsolns gplot)(ice-9 popen)
	     (ice-9 textual-ports)(ice-9 rdelim)(rnrs bytevectors)(web uri)(ice-9 pretty-print)
	     (oop goops) ;;class-of
	     )

(define (prep-lyt-rows a)
  (fold (lambda (x prev)
          (let* ((id (get-c1 x))
                (sys-name (result-ref x "sys_name"))
		(name (result-ref x "name"))
		(descr (result-ref x "descr"))
		(plate-format-id (get-c5 x))
		(replicates (get-c6 x))
		(targets (get-c7 x))
		(use-edge (get-c8 x))
		(num-controls (get-c9 x))
		(unknown-n (get-c10 x))
		(control-loc (result-ref x "control_loc"))
		(source-dest (result-ref x "source_dest"))
		(id-html (string-append "<a href=\"/layout/lytbyid?id=" id "\">" sys-name "</a>") ))
            (cons (string-append "<tr><td>" id-html "</td><td>" name "</td><td>" descr "</td>
<td>"   plate-format-id "</td><td>" replicates "</td><td>" targets "</td>
<td>"  use-edge "</td><td>" num-controls "</td><td>" unknown-n "</td><td>" control-loc "</td><td>" source-dest "</td></tr>")
		  prev)))
        '() a))

(define (get-format-for-layout-id id rc)
  (let* ((sql (string-append "select  plate_format_id from plate_layout_name where id="  id))
	(ret (DB-get-all-rows(:conn rc sql) )))
     (number->string (cdaar ret))))

;; (define (get-layout-table-for-r id rc)
;;   (let* ((table-header (string-append "format\twell\ttype\trow\trow.num\tcol\treplicates\ttargets\n"))
;; 	 (sql (string-append "select plate_format_id, by_col, well_type_id,row, row_num, col, plate_layout.replicates, plate_layout.target from plate_layout_name, plate_layout, well_numbers where plate_layout.well_by_col=well_numbers.by_col and plate_layout.plate_layout_name_id = plate_layout_name.id and well_numbers.plate_format=plate_layout_name.plate_format_id AND plate_layout.plate_layout_name_id =" id))
;; 	 (holder (DB-get-all-rows(:conn rc sql) ))
;; 	(body (string-concatenate (prep-lyt-for-r holder))))
;;     (string-append table-header body )))


;; (define (get-data-for-layout id data-file-name rc)
;;   (let* ((data-file data-file-name)
;; 	 (p  (open-output-file data-file)))
;;     (put-string p (get-layout-table-for-r id rc) )
;;     (force-output p)
;;     ))


;; (define (prep-lyt-for-g a)
;;   (fold (lambda (x prev)
;;           (let* ((format (get-c1 x))	
;; 		 (well (get-c2 x))
;; 		 (type (get-c3 x))
;; 		 (row (result-ref x "row"))
;; 		 (row-num (get-c5 x))
;; 		 (col (result-ref x "col"))
;; 		 (replicates (get-c7 x ))
;; 		 (targets (get-c8 x )))
;;             (cons (string-append  format "\t" well "\t" type "\t" row "\t" row-num "\t" col "\t" replicates "\t" targets  "\n")
;; 		  prev)))
;;         '() a))


(layout-define getall
	       (options #:conn #t
			#:cookies '(names prjid userid sid))
  (lambda (rc)
    (let* ((help-topic "layouts")
	     (sid (:cookies-value rc "sid"))
	       (prjid (get-prjid rc sid))
	       (userid (:cookies-value rc "userid"))
	       (sql  "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name")
	   (holder  (DB-get-all-rows (:conn rc sql)))
	   (body (string-concatenate (prep-lyt-rows holder))))
   (view-render "getall" (the-environment)))))

(define (add-comma lst result)
  ;;concatenates numbers as string, putting ", " between each
  (if (null? (cdr lst))
      (begin
	(set! result (string-append result (car lst)))
	result)
      (begin
	(set! result (string-append result (car lst) ", "))
	(add-comma (cdr lst) result))))



;; (layout-define lytbyid
;; 	       (options #:conn #t
;; 			#:cookies '(names prjid userid sid))
;; 	       (lambda (rc)
;; 		 (let* (
;; 			(help-topic "layouts")
;; 			(prjid (get-prjid rc sid))
;; 			(userid (:cookies-value rc "userid"))
;; 			(sid (:cookies-value rc "sid"))
;; 			(id  (get-from-qstr rc "id"))
;; 			(infile (get-rand-file-name "lyt" "txt"))
;; 			(spl-out (get-rand-file-name "lyt" "png"))
;; 			(spl-rep-out (get-rand-file-name "lyt" "png"))
;; 			(trg-rep-out (get-rand-file-name "lyt" "png"))	 
;; 			(outfile (string-append  (get-rand-file-name "lyt" "png")))
;; 			(format (get-format-for-layout-id id rc))
;; 			(sql (string-append "SELECT source_dest FROM plate_layout_name WHERE id=" id))
;; 			(srcdest (assoc-ref (car (DB-get-all-rows (:conn rc sql))) "source_dest"))
;; 			(sql (if (equal? srcdest "source")
;; 				 (string-append "select dest from layout_source_dest where src =" id)
;; 				 (string-append "select dest from layout_source_dest where src =(select src from layout_source_dest where dest = " id ") UNION select src from layout_source_dest where dest =" id " ORDER BY dest")))
					
;; 			(holder (map cdar (DB-get-all-rows (:conn rc sql))))
;; 			(allids (if (equal? srcdest "source")
;; 				    (cons (string->number id) holder)
;; 				    holder))
;; 			(allidsstring (map number->string allids))
;; 			(allidscomma (add-comma allidsstring ""))
;; 			(sql (string-append "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name where id IN (" allidscomma ") ORDER BY source_dest DESC"))
;; 			(holder  (DB-get-all-rows (:conn rc sql)))
;; 			 (body (string-concatenate (prep-lyt-rows holder)))
;; 			 (dummy3 (get-data-for-layout id (string-append "pub/" infile) rc))
;;  			 (dummy4 (system (string-append "Rscript --vanilla rscripts/plot-layout.R pub/" infile " pub/" spl-out " pub/" spl-rep-out " pub/" trg-rep-out " " format)))
;; 			 (spl-out2 (string-append "\"../" spl-out "\"" ))
;; 			 (spl-rep-out2 (string-append "\"../" spl-rep-out "\""))
;; 			 (trg-rep-out2  (string-append "\"../" trg-rep-out "\""))
;; 			)
;; 		   (view-render "lytbyid" (the-environment))
;; 		 ;;  (view-render "test" (the-environment))
;; 		   )))



(layout-define select
	       (options 
		#:cookies '(names prjid sid))
	       (lambda (rc)
		 (let* ((help-topic "layouts")
			(sid (:cookies-value rc "sid"))
			(prjid (get-prjid rc sid))
			(identity (get-id-name-group-email-for-session rc sid))
			(userid (car identity)))
			(view-render "select" (the-environment))
			)))

(define cs (char-set #\space #\tab #\newline #\return))

(define (get-types lst holder)
  ;; get the second column of types
  ;; an element looks like ("1\t5\r") trim the \r; split on \t
  (cond
   ((null? (cdr lst))
    (set! holder (cons  (cdr (string-split (string-trim-both (caar lst) cs) #\tab))  holder))
     holder)
   ((cdr lst)
    (set! holder (cons (cdr (string-split (string-trim-both (caar lst) cs) #\tab))  holder))
    (get-types (cdr lst) holder))
    (else #f)))

(define (count what list counter)
  ;;count the string elements
  ;;input is ("1" "1" "1")
  (cond
   ((null? (cdr list))
    (if (equal? what  (car list)) (set! counter (+ counter 1)) #f)
    counter)
   ((cdr list)
    (if (equal? what (car list)) (set! counter (+ counter 1)) #f)
    (count what (cdr list) counter))
   (else #f)))

(define (process-lyt-row r format well-nums)
  (let* (
	 (row (stripfix (car r)))
	 (by-col (car  (string-split row  #\tab)))
	 (type (cadr  (string-split row  #\tab)))
	 (key (cons 'by_col  (string->number by-col)))
	;;  (well-num-row (assoc key well-nums))
	;;  (col (assoc-ref well-num-row 'col))
	 
	;;  (row-num (assoc-ref well-num-row 'row_num))
	;;  (rev-row (cond ((equal? format "96")  (assq-ref ns-lst  row-num))
	;; 		((equal? format "384") (assq-ref tef-lst row-num))
	;; 		((equal? format "1536") (assq-ref fts-lst  row-num))
	;; 		))
	;;  (y-tic-label (cond ((equal? format "96")  (assq-ref get-96-row-labels  row-num))
	;; 		    ((equal? format "384") (assq-ref get-384-row-labels row-num))
	;; 		    ((equal? format "1536") (assq-ref get-1536-row-labels row-num))
	;; 		    ))
	;; (color  (assq-ref get-spl-color type))	 
	 )
    (string-append by-col "\t" row "\t" type)))


(define (prep-datatransfer lst well-nums format results)
  ;;input is (88\t90\r)
  (cond
   ((null? (cdr lst))
    (let* ((by-col (car (string-split (string-trim-both (caar lst) cs) #\tab)))
	   (type (string->number (cadr (string-split (string-trim-both (caar lst) cs) #\tab))))
	   (well-num-row (get-roi (string->number by-col) well-nums))
	   (col  (cdadr well-num-row))
	   (row (cdaddr well-num-row))
	   (rev-row (cond ((equal? format "96") (assoc-ref ns-lst row))
		     ((equal? format "384") (assoc-ref tef-lst row))
		     ((equal? format "1536") (assoc-ref fts-lst row))
		     ))
	   (label (cond ((equal? format "96") (assoc-ref get-96-row-labels row))
		     ((equal? format "384") (assoc-ref  get-384-row-labels row))
		     ((equal? format "1536") (assoc-ref  get-1536-row-labels row))
		     ))
	   (color (assoc-ref get-spl-color type))
	   (dummy (set! results (string-append results col "\t" (number->string rev-row) "\t" label "\t"  color "\n")))	   
	   )
      results))  
   ((cdr lst)
    (let* ((by-col (car (string-split (string-trim-both (caar lst) cs) #\tab)))
	   (type (string->number (cadr (string-split (string-trim-both (caar lst) cs) #\tab))))
	   (well-num-row (get-roi (string->number by-col) well-nums))
	   (col  (cdadr well-num-row))
	   (row (cdaddr well-num-row))
	   (rev-row (cond ((equal? format "96") (assoc-ref ns-lst row))
		     ((equal? format "384") (assoc-ref tef-lst row))
		     ((equal? format "1536") (assoc-ref fts-lst row))
		     ))
	   (label (cond ((equal? format "96") (assoc-ref get-96-row-labels row))
		     ((equal? format "384") (assoc-ref  get-384-row-labels row))
		     ((equal? format "1536") (assoc-ref  get-1536-row-labels row))
		     ))
	   (color (assoc-ref get-spl-color type))
	   (dummy (set! results (string-append results col "\t" (number->string rev-row) "\t" label "\t" color "\n")))	   
	   )
      (prep-datatransfer (cdr lst) well-nums format results)))
   (else #f)))


(define (get-roi key allrows)
  ;;assume key is unique stop when found
  (cond
   ((null? (cdr allrows))
   (if (eqv? key (cdaar allrows)) (car allrows) #f ))
   
   ((cdr allrows)
    (if (eqv? key (cdaar allrows))
	(car allrows)
	(get-roi key (cdr allrows))))
   ))
   
(define (filter-empty lst newlst)
(cond
 ((null? (cdr lst)) 
  (if (null? (car lst)) (cdr newlst)
      (begin
	(set! newlst (cons (car lst) newlst))
	(cdr  newlst))))
  ((cdr lst)
   (if (null? (car lst))
       (filter-empty (cdr lst) newlst)
       (begin
	(set! newlst (cons (car lst) newlst))
	(filter-empty (cdr lst) newlst)))
   )))
  
  


(post "/viewlayout"   #:from-post 'qstr
      #:cookies '(names prjid userid sid)
      #:conn #t
      ;; view a layout before import
   (lambda (rc)
     (let* ((help-topic "layouts")
	    (sid (:cookies-value rc "sid"))
	    (prjid (get-prjid rc sid))
	   
	    (infile (get-rand-file-name "lyt" "txt")) ;;do not incorporate the "pub" here because the html
	   (spl-out  (get-rand-file-name "lyt" "png")) ;; does not want the pub
	   ; (spl-out2 (string-append "\"" spl-out "\""))
	   ;; (cookies  (rc-cookie rc))
	    (a (uri-decode (:from-post rc 'get-vals "datatransfer")))
	    (b (map list (cdr (string-split a #\newline))))
	    (c (filter-empty b '()))
	    (holder (get-types b '()))
	    (all-types (apply append holder))	   
	    (nunks (count "1" all-types 0))
	    (n2 (count "2" all-types 0))
	    (n3 (count "3" all-types 0))
	    (n4 (count "4" all-types 0))
	    (nedge (count "5" all-types 0))
	    (ncontrols (+ n2 n3 n4))
	    (format (:from-post rc 'get-vals "format2"))

	    (file-port (open-output-file (string-append "pub/" infile)))
	    (dummy (display a file-port))
	    (dummy2 (force-output file-port))
	   ;; (dummy (system (string-append "Rscript --vanilla rscripts/plot-review-layout.R pub/" infile " pub/" spl-out " " format )))

	    ;; (sqlprefix "INSERT INTO import_plate_layout (well_by_col, well_type_id, replicates, target) VALUES ")
	    ;; (sql (string-append sqlprefix sqlsuffix))
	    ;; (dummy (:conn rc sql))

	    (sql (string-append "select  by_col, col, row_num  FROM well_numbers where well_numbers.plate_format=" format))
	    (well-nums (DB-get-all-rows(:conn rc sql) ))	    	  
	    (data-body (prep-datatransfer c well-nums format ""))

	    (dummy (make-layout-preview-plot spl-out data-body format))

	    (spl-out2 (string-append "\"../" spl-out "\"" ))

	    )
    (view-render "viewlayout" (the-environment))
;;    (view-render "test" (the-environment))
   )))




 (define (prep-sql-suffix list sqlsuffix)
  ;;input is (88\t90\r)
  (cond
   ((null? (cdr list))
    (if (null? (car list)) #f (set! sqlsuffix (string-append sqlsuffix "(" (string-trim-both (caar list) cs) ", " (string-trim-both  (cadar list) cs)  ", 1, 1) "))) 
    sqlsuffix)
   ((cdr list)
    (if (null? (car list)) #f (set! sqlsuffix (string-append sqlsuffix "(" (string-trim-both  (caar list) cs) ", " (string-trim-both  (cadar list) cs)  ", 1, 1), ")) )
    (prep-sql-suffix (cdr list) sqlsuffix))
   (else #f)))


(define (get-sql-layout-file f)
  (if (access? f R_OK)
      (let* (
	     (my-port (open-input-file f))
	     (ret #f)
	     (holder '())
	     (message "")
	     (ret (read-line my-port))
	     (header (string-split ret #\tab))
	     (result (if (and (string=? (string-trim-both (car header) cs) "well")
			     (string=? (string-trim-both (cadr header) cs) "type"))
			  (let* (
				 (ret (read-line my-port))
				 (dummy2 (while (not (eof-object? ret))
					   (set! holder (cons (string-split ret #\tab) holder))
					   (set! ret (read-line my-port))))
				 (holder2 (prep-sql-suffix holder "")))		     
			    holder2))))	
	result)
      #f))


(post "/updatedb"  #:conn #t #:from-post 'qstr 
  (lambda (rc)
    (let* ((help-topic "layouts")
	  (infile (uri-decode (:from-post rc 'get-vals "infile")))
	  (format  (:from-post rc 'get-vals "format"))
	  (lytname (:from-post rc 'get-vals "lytname"))
	  (descr (:from-post rc 'get-vals "descr"))
	  (contloc (:from-post rc 'get-vals "contloc"))
	  (nunks  (:from-post rc 'get-vals "nunks"))
	  (ncontrols  (:from-post rc 'get-vals "ncontrols"))
	  (nedge (:from-post rc 'get-vals "nedge"))
	  (sql "TRUNCATE TABLE import_plate_layout")
	  (dummy (:conn rc sql))
	  (sqlsuffix (get-sql-layout-file (string-append "pub/" infile)))
	  (sqlprefix "INSERT INTO import_plate_layout (well_by_col, well_type_id, replicates, target) VALUES ")
	  (sql (string-append sqlprefix sqlsuffix))
	  (dummy (:conn rc sql))
	  (sql (string-append "SELECT create_layout_records('" lytname "', '" descr "', '" contloc "', " ncontrols ", " nunks ", " format ", " nedge ")"))
	  (dummy (:conn rc sql))
	  (dummy (sleep 5))
	)
   (redirect-to rc (get-redirect-uri "/layout/getall" ))
  )))



;; (layout-define success
;; 	       (lambda (rc)
;; 		 (let* ((help-topic "layouts"))		   
;;  (view-render "success" (the-environment)))
;; 	       ))







(layout-define lytbyid
	       (options #:conn #t
			#:cookies '(names prjid userid sid))
	       (lambda (rc)
		 (let* (
			(help-topic "layouts")
			(sid (:cookies-value rc "sid"))
			(prjid (get-prjid rc sid))
			(lytid  (get-from-qstr rc "id"))
			
			;; (infile (get-rand-file-name "lyt" "txt"))
			(spl-out (get-rand-file-name "lyt" "png"))
			(spl-rep-out (get-rand-file-name "lyt" "png"))
			(trg-rep-out (get-rand-file-name "lyt" "png"))	 
			;;(outfile (string-append  (get-rand-file-name "lyt" "png")))
			(format (get-format-for-layout-id lytid rc))
			(sql (string-append "SELECT source_dest FROM plate_layout_name WHERE id=" lytid))
			(srcdest (assoc-ref (car (DB-get-all-rows (:conn rc sql))) "source_dest"))
			(sql (if (equal? srcdest "source")
				 (string-append "select dest from layout_source_dest where src =" lytid)
				 (string-append "select dest from layout_source_dest where src =(select src from layout_source_dest where dest = " lytid ") UNION select src from layout_source_dest where dest =" lytid " ORDER BY dest")))
					
			(holder (map cdar (DB-get-all-rows (:conn rc sql))))
			(allids (if (equal? srcdest "source")
				    (cons (string->number lytid) holder)
				    holder))
			(allidsstring (map number->string allids))
			(allidscomma (add-comma allidsstring ""))
			(sql (string-append "select id, sys_name, name, descr, plate_format_id, replicates, targets, use_edge, num_controls, unknown_n, control_loc, source_dest from plate_layout_name where id IN (" allidscomma ") ORDER BY source_dest DESC"))
			(holder  (DB-get-all-rows (:conn rc sql)))
			(body (string-concatenate (prep-lyt-rows holder)))
			;;gnuplot stuff starts here
			(sql (string-append "select  row_num, col, well_type_id, plate_layout.replicates, plate_layout.target from plate_layout_name, plate_layout, well_numbers where plate_layout.well_by_col=well_numbers.by_col and plate_layout.plate_layout_name_id = plate_layout_name.id and well_numbers.plate_format=plate_layout_name.plate_format_id AND plate_layout.plate_layout_name_id =" lytid))
			(holder (DB-get-all-rows(:conn rc sql) ))
			(data-body (string-concatenate (prep-lyt-for-g holder format)))
			(dummy (make-layout-plot spl-out spl-rep-out trg-rep-out data-body lytid format))
			
		
			 (spl-out2 (string-append "\"../" spl-out "\"" ))
			 (spl-rep-out2 (string-append "\"../" spl-rep-out "\""))
			 (trg-rep-out2  (string-append "\"../" trg-rep-out "\""))
			)
		   (view-render "lytbyid" (the-environment))
		 ;;  (view-render "test" (the-environment))
		   )))
