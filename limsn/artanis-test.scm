n-;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
;; /gnu/store/jgl9d4axpavsv83z2f1z1himnkbsxxqj-guile-2.2.7/bin/guile
;; /usr/lib/x86_64-linux-gnu/guile/3.0/bin/guile

(use-modules (srfi srfi-1)
	     (dbi dbi)
	     (ice-9 match)
	     (web uri)
	     (ice-9 format)
	     (ice-9 match)
	      (web response)
	     (web request)(web client)
	      (ice-9 receive)
	      (json)(ice-9 textual-ports)
	      (ice-9 pretty-print)
	     (artanis utils)(artanis irregex)
	     (srfi srfi-19)   ;; date time
	     (ice-9 textual-ports)(ice-9 rdelim)(ice-9 pretty-print)
	     (artanis artanis)
	     (ice-9 string-fun) ;; string-replace-substring
	     (rnrs bytevectors))
;;	     (lnserver sys extra))
(getcwd)	    
(use-modules  (home mbc .cache guile ccache 3.0-LE-8-4.4 home mbc projects ln7 lnserver sys extra))


(define ciccio (dbi-open "postgresql" "ln_admin:welcome:lndb:tcp:192.168.1.11:5432"))

(define (get-key cust-id email )
  (string->md5 (string-append cust-id email "lnsDFoKytr")))

(define (validate-key cust_id cust_email cust_key)
  (equal? (get-key cust_id cust_email) cust_key))

(get-key "jf8d9slkdow09ieieurie" "info@labsolns.com")

"e118bd1efb4b4f5367cf99976267c5ad"

(validate-key "jf8d9slkdow09ieieurie" "info@labsolns.com" "e118bd1efb4b4f5367cf99976267c5ad")





select  row_num, col, well_type_id, plate_layout.replicates, plate_layout.target from plate_layout_name, plate_layout, well_numbers where plate_layout.well_by_col=well_numbers.by_col and plate_layout.plate_layout_name_id = plate_layout_name.id and well_numbers.plate_format=plate_layout_name.plate_format_id AND plate_layout.plate_layout_name_id =10;

row_num | col | well_type_id | replicates | target 
---------+-----+--------------+------------+--------
       1 | 1   |            1 |          1 |      1
       2 | 1   |            1 |          2 |      1
       3 | 1   |            1 |          1 |      1
       4 | 1   |            1 |          2 |      1
       5 | 1   |            1 |          1 |      1
       6 | 1   |            1 |          2 |      1



(assq-ref ns-list 1)



(define get-96-row-labels '( (1 . "A")(2 . “B”)(3 . "")(4 . “D”)(5 . “E”)(6 . “F”)(7 . “G”)(8 . “H”)))

(assq-ref get-96-row-labels 3)

(define input "well	type
1	5
2	5
3	5
4	5
5	5
6	5
7	5
8	5
9	5
10	5
11	5
12	5
13	5
14	5
15	5
16	5
17	5
18	1
19	1
20	1
21	1
22	1")

(define b  (cdr (string-split input #\newline)))








(define (get-roi key allrows)
  ;;assume key is unique stop when found
  (cond
   ((null? (cdr allrows))
   (if (equal? key (cdaar allrows)) (car allrows) #f ))
   
   ((cdr allrows)
    (if (equal? key (cdaar allrows))
	 (car allrows)
	(get-roi key (cdr allrows))))
   ))



(define key (cons 'by_col 2))

(equal? key '(by_col . 1)) 

(define allrows '(((by_col . 1) (col . 1) (row_num . 1)) ((by_col . 2) (col . 1) (row_num . 2)) ((by_col . 3) (col . 1) (row_num . 3)) ((by_col . 4) (col . 1) (row_num . 4)) ((by_col . 5) (col . 1) (row_num . 5)) ((by_col . 6) (col . 1) (row_num . 6))))


(cdaar allrows)
(define c (get-roi 1 allrows))
(assoc-ref c 'col )

(null? '())

(define d '((by_col . 1) (col . 1) (row_num . 1)) )

(number->string (assoc-ref d 'col))
