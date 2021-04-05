(define-module (labsolns gplot)
  #:export (
	    ns-lst
	    tef-lst
	    fts-lst
	    make-scatter-plot
	    get-96-row-labels
	    get-384-row-labels
	    get-1536-row-labels
	    get-spl-color
	    ))

(use-modules (artanis artanis)(artanis utils)(artanis config) (ice-9 local-eval) (srfi srfi-1)
             (artanis irregex)(dbi dbi) (ice-9 textual-ports)(ice-9 rdelim)(ice-9 popen)
	     (rnrs bytevectors)(web uri))


;; used to reverse row labels for plotting
(define ns-lst
  ;; 96 well rows
  '((1 . 8)(2 . 7)(3 . 6)(4 . 5)(5 . 4)(6 . 3)(7 . 2)(8 . 1)))
(define tef-lst
  ;; 384 well rows
  '((1 . 16)(2 . 15)(3 . 14)(4 . 13)(5 . 12)(6 . 11)(7 . 10)(8 . 9)(9 . 8)(10 . 7)(11 . 6)(12 . 5)(13 . 4)(14 . 3)(15 . 2)(16 . 1)))
(define fts-lst
  ;; 1536 well rows
'((1 . 32)(2 . 31)(3 . 30)(4 . 29)(5 . 28)(6 . 27)(7 . 26)(8 . 25)(9 . 24)(10 . 23)(11 . 22)(12 . 21)(13 . 20)(14 . 19)(15 . 18)(16 . 17)(17 . 16)(18 . 15)(19 . 14)(20 . 13)(21 . 12)(22 . 11)(23 . 10)(24 . 9)(25 . 8)(26 . 7)(27 . 6)(28 . 5)(29 . 4)(30 . 3)(31 . 2)(32 . 1)))

(define get-96-row-labels '( (1 . "A")(2 . "B")(3 . "C")(4 . "D")(5 . "E")(6 . "F")(7 . "G")(8 . "H")))

(define get-384-row-labels '( (1 . "A")(2 . "B")(3 . "C")(4 . "D")(5 . "E")(6 . "F")(7 . "G")(8 . "H")(9 . "I")(10 . "J")(11 . "K")(12 . "L")(13 . "M")(14 . "N")(15 . "O")(16 . "P")))

(define get-1536-row-labels '( (1 . "A")(2 . ".")(3 . "C")(4 . ".")(5 . "E")(6 . ".")(7 . "G")(8 . ".")(9 . "I")(10 . ".")(11 . "K")(12 . ".")(13 . "M")(14 . ".")(15 . "O")(16 . ".")(17 . "Q")(18 . ".")(19 . "S")(20 . ".")(21 . "U")(22 . ".")(23 . "W")(24 . ".")(25 . "Y")(26 . ".")(27 . "AA")(28 . ".")(29 . "AC")(30 . ".")(31 . "AE")(32 . ".")))


(define get-spl-color '((1 . 0x000000)   ;;unk black
			(2 . 0x00ff00)   ;;pos green
			(3 . 0xff0000)   ;;neg red 
			(4 . 0x969696)   ;;blank grey
			(5 . 0x33FFFF))) ;;edge light blue



(define (make-scatter-plot outfile response metric threshold nrows num-hits data-body )
;; Threshold  called metric below x,y are coordinates for printing
  ;; outfile: .png filename
  ;; nrows number of data points to plot
  ;; num-hits given the threshold
  ;; threshold must be a number
  (let* ((y-label (cond ((equal? response "0") "Background Subtracted")
			((equal? response "1") "Normalized")
			((equal? response "2") "Normalized to positive controls")
			((equal? response "3") "% Enhanced")))
	 (metric-text (cond   ((equal? metric "1") "> mean(pos)")
			      ((equal? metric "2") "mean(neg) + 2SD")
			      ((equal? metric "3") "mean(neg) + 3SD")
			      (else "Manual")))
	 (metric-text-x (number->string (* nrows 0.08)))
	 ;;if  response=3 %enhanced, mean of threshold is 0 so set y to 5%
	 (metric-text-y (if (equal? response "3") "-5" (number->string (- threshold (* threshold 0.06)))))
	 (xmax (number->string (+ nrows 4)))
	 (hit-num-text (string-append "hits: " num-hits))
	 (hit-num-text-x (number->string (* nrows 0.08)))
	 (hit-num-text-y (if (equal? response "3") "5" (number->string (+ threshold (* threshold 0.06)))))
	 (thresholdstr (number->string threshold))
	 (gplot-script (get-gplot-scatter-script outfile y-label thresholdstr xmax hit-num-text hit-num-text-x hit-num-text-y metric-text metric-text-x metric-text-y data-body))
	 ;; (p  (open-output-file (get-rand-file-name "script" "txt")))
	 ;; (dummy (begin
	 ;; 	  (put-string p gplot-script )
	 ;; 	  (force-output p)))
	 (port (open-output-pipe "gnuplot"))
	 )
    (begin
      (display gplot-script port)
      (close-pipe port))
    )) 

(define (get-gplot-scatter-script out-file ylabel threshold xmax hit-num-text hit-num-text-x hit-num-text-y metric-text metric-text-x metric-text-y data)
  ;;xmax is 100 for 96 well plates, 385 for 384 well plate etc
  ;; hit-num-text e.g. 38 hits
  ;; metric-text e.g. Norm + 3SD
  (let* (
	 (str1 "reset session\nset terminal pngcairo size 800,500\nset output '")
	 (str2 "'\nset key box ins vert right top\nset grid\nset arrow 1 nohead from 0,")
	 (str3 " to ")
	 (str4 ", ")
	 (str5 " linewidth 1 dashtype 2\nset xlabel \"Index\"\nset ylabel \"")	       
	 (str6 "\"\nset label '")
	 (str7 "' at ")
	 (str8 ",")
	 (str9 "\nset label '")
	 (str10 "' at ")
	 (str11 ",")
	 (str12 "\nplot '-' using 1:2:3 notitle with points pt 2 lc rgbcolor variable, NaN with points pt 20 lc rgb \"green\" title \"pos\", NaN with points pt 20 lc rgb \"red\" title \"neg\", NaN with points pt 20 lc rgb \"black\" title \"unk\", NaN with points pt 20  lc rgb \"grey\" title \"blank\"\n")
	 (str13 "e"))   
   (string-append str1 (string-append "pub/" out-file) str2 threshold str3 xmax str4 threshold str5 ylabel str6  hit-num-text str7 hit-num-text-x str8 hit-num-text-y str9 metric-text str10 metric-text-x str11 metric-text-y str12 data str13 ) ))
