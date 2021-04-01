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


	


(define a '(((response_type . 0) (max_response . 0.667751848697662) (min_response . 0.017696063965559) (mean_bkgrnd . 0.257461663052116) (std_dev_bkgrnd . 0.151798759982396) (mean_pos . 0.585150003433228) (stdev_pos . 0.052504768074834) (mean_neg_3_sd . 0.3236000662449897) (mean_neg_2_sd . 0.2539500441255768) (mean_pos_3_sd . 0.74266430765773) (mean_pos_2_sd . 0.690159539582896)) ((response_type . 1) (max_response . 1) (min_response . 0.0265009608119726) (mean_bkgrnd . 0.400153788707584) (std_dev_bkgrnd . 0.234627494089074) (mean_pos . 0.908844977617264) (stdev_pos . 0.0838151252227677) (mean_neg_3_sd . 0.533256372088082) (mean_neg_2_sd . 0.415829003866439) (mean_pos_3_sd . 1.160290353285567) (mean_pos_2_sd . 1.0764752280627994)) ((response_type . 2) (max_response . 1.12151801586151) (min_response . 0.0297213047742844) (mean_bkgrnd . 0.440134737964558) (std_dev_bkgrnd . 0.258646761272284) (mean_pos . 1.00000001490116) (stdev_pos . 0.0884577742520888) (mean_neg_3_sd . 0.569230995446559) (mean_neg_2_sd . 0.445309862077313) (mean_pos_3_sd . 1.2653733376574263) (mean_pos_2_sd . 1.1769155634053377)) ((response_type . 3) (max_response . 13.651291847229) (min_response . -133.296340942383) (mean_bkgrnd . -70.4923045725926) (std_dev_bkgrnd . 32.8073758947133) (mean_pos . 0) (stdev_pos . 12.0112171134045) (mean_neg_3_sd . -100) (mean_neg_2_sd . -100) (mean_pos_3_sd . 36.0336513402135) (mean_pos_2_sd . 24.022434226809))))



(define (get-threshold-for-response response metric data)
  ;; Response  ========================
  ;; public static final int RAW = 0;
  ;; public static final int NORM = 1;
  ;; public static final int NORM_POS = 2;
  ;; public static final int P_ENHANCE = 3;
  ;; Metric  ===========================
  ;; TopN = 1
  ;; Mean+2SD = 2
  ;; Mean+3SD = 3
  ;; >0% enhance = 4
  ;; =================================
  ;; note that this does not handle Top N  
  (let* ((response-key (cond ((equal? response "0") '(response_type . 0))
			    ((equal? response "1") '(response_type . 1))
			    ((equal? response "2") '(response_type . 2))
			    ((equal? response "3") '(response_type . 3))
			    ))
	(response-row (assoc response-key data))
	(metric-key (cond   ((equal? metric "2") 'mean_neg_2_sd)
			    ((equal? metric "3") 'mean_neg_3_sd)
			    ((equal? metric "4") 'mean_pos))))
    (cdr (assoc metric-key response-row))))

(get-threshold-for-response "1" "3" a)
