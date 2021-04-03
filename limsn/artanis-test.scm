;; /gnu/store/0w76khfspfy8qmcpjya41chj3bgfcy0k-guile-3.0.4/bin/guile
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





select plate_format_id, by_col, well_type_id,row, row_num, col, plate_layout.replicates, plate_layout.target from plate_layout_name, plate_layout, well_numbers where plate_layout.well_by_col=well_numbers.by_col and plate_layout.plate_layout_name_id = plate_layout_name.id and well_numbers.plate_format=plate_layout_name.plate_format_id AND plate_layout.plate_layout_name_id =10;


(define ns-list
  ;; 96 well rows
  '((1 . 8)(2 . 7)(3 . 6)(4 . 5)(5 . 4)(6 . 3)(7 . 2)(8 . 1)))



  (1 . 16)
  (2 . 15)
  (3 . 14)
  (4 . 13)
  (5 . 12)
  (6 . 11)
  (7 . 10)
  (8 . 9)
  (9 . 8)
  (10 . 7)
  (11 . 6)
  (12 . 5)
  (13 . 4)
  (14 . 3)
  (15 . 2)
(16 . 1)



(1 . 32)
  (2 . 31)
  (3 . 30)
  (4 . 29)
  (5 . 28)
  (6 . 27)
  (7 . 26)
  (8 . 25)
  (9 . 24)
  (10 . 23)
  (11 . 22)
  (12 . 21)
  (13 . 20)
  (14 . 19)
  (15 . 18)
  (16 . 17)
  (17 . 16)
  (18 . 15)
  (19 . 14)
  (20 . 13)
  (21 . 12)
  (22 . 11)
  (23 . 10)
  (24 . 9)
  (25 . 8)
  (26 . 7)
  (27 . 6)
  (28 . 5)
  (29 . 4)
  (30 . 3)
  (31 . 2)
  (32 . 1)


(assq-ref ns-list 1)
