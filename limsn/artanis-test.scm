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




(define (process-lyt-row r)
  (let* ((by-col (car  (string-split "5\t7\r"  #\tab)))
	 (type (cdr  (string-split "5\t7"  #\tab)))
	 (key (cons 'by_col (string->number by-col)))
	 (well-num-row (assoc key well-nums))
	 (col (assoc-ref well-num-row col))
	 (row-num (assoc-ref well-num-row row_num))
	 (rev-row )
	 (row-label)
	(color  (get-spl-color type))	 
	 )
    (string-append col "\t" row-num "\t" color)))

(map process-lyt-row b)



  
 (car  (string-split "5\t7"  #\tab)) "\t"



(assoc-ref '())



(define well-nums '(((by_col . 1) (col . 1) (row_num . 1)) ((by_col . 2) (col . 1) (row_num . 2))))

(define k '(by_col . 1))
(assoc-ref (assoc k well-nums) 'col)

(cons 'by_col (string->number "1"))



(define well-nums '(((by_col . 1) (col . 1) (row_num . 1)) ((by_col . 2) (col . 1) (row_num . 2)) ((by_col . 3) (col . 1) (row_num . 3)) ((by_col . 4) (col . 1) (row_num . 4)) ((by_col . 5) (col . 1) (row_num . 5)) ((by_col . 6) (col . 1) (row_num . 6)) ((by_col . 7) (col . 1) (row_num . 7)) ((by_col . 8) (col . 1) (row_num . 8)) ((by_col . 9) (col . 1) (row_num . 9)) ((by_col . 10) (col . 1) (row_num . 10)) ((by_col . 11) (col . 1) (row_num . 11)) ((by_col . 12) (col . 1) (row_num . 12)) ((by_col . 13) (col . 1) (row_num . 13)) ((by_col . 14) (col . 1) (row_num . 14)) ((by_col . 15) (col . 1) (row_num . 15)) ((by_col . 16) (col . 1) (row_num . 16)) ((by_col . 17) (col . 2) (row_num . 1)) ((by_col . 18) (col . 2) (row_num . 2)) ((by_col . 19) (col . 2) (row_num . 3)) ((by_col . 20) (col . 2) (row_num . 4)) ((by_col . 21) (col . 2) (row_num . 5)) ((by_col . 22) (col . 2) (row_num . 6)) ((by_col . 23) (col . 2) (row_num . 7)) ((by_col . 24) (col . 2) (row_num . 8)) ((by_col . 25) (col . 2) (row_num . 9)) ((by_col . 26) (col . 2) (row_num . 10)) ((by_col . 27) (col . 2) (row_num . 11)) ((by_col . 28) (col . 2) (row_num . 12)) ((by_col . 29) (col . 2) (row_num . 13)) ((by_col . 30) (col . 2) (row_num . 14)) ((by_col . 31) (col . 2) (row_num . 15)) ((by_col . 32) (col . 2) (row_num . 16)) ((by_col . 33) (col . 3) (row_num . 1)) ((by_col . 34) (col . 3) (row_num . 2)) ((by_col . 35) (col . 3) (row_num . 3)) ((by_col . 36) (col . 3) (row_num . 4)) ((by_col . 37) (col . 3) (row_num . 5)) ((by_col . 38) (col . 3) (row_num . 6)) ((by_col . 39) (col . 3) (row_num . 7)) ((by_col . 40) (col . 3) (row_num . 8)) ((by_col . 41) (col . 3) (row_num . 9)) ((by_col . 42) (col . 3) (row_num . 10)) ((by_col . 43) (col . 3) (row_num . 11)) ((by_col . 44) (col . 3) (row_num . 12)) ((by_col . 45) (col . 3) (row_num . 13)) ((by_col . 46) (col . 3) (row_num . 14)) ((by_col . 47) (col . 3) (row_num . 15)) ((by_col . 48) (col . 3) (row_num . 16)) ((by_col . 49) (col . 4) (row_num . 1)) ((by_col . 50) (col . 4) (row_num . 2)) ((by_col . 51) (col . 4) (row_num . 3)) ((by_col . 52) (col . 4) (row_num . 4)) ((by_col . 53) (col . 4) (row_num . 5)) ((by_col . 54) (col . 4) (row_num . 6)) ((by_col . 55) (col . 4) (row_num . 7)) ((by_col . 56) (col . 4) (row_num . 8)) ((by_col . 57) (col . 4) (row_num . 9)) ((by_col . 58) (col . 4) (row_num . 10)) ((by_col . 59) (col . 4) (row_num . 11)) ((by_col . 60) (col . 4) (row_num . 12)) ((by_col . 61) (col . 4) (row_num . 13)) ((by_col . 62) (col . 4) (row_num . 14)) ((by_col . 63) (col . 4) (row_num . 15)) ((by_col . 64) (col . 4) (row_num . 16)) ((by_col . 65) (col . 5) (row_num . 1)) ((by_col . 66) (col . 5) (row_num . 2)) ((by_col . 67) (col . 5) (row_num . 3)) ((by_col . 68) (col . 5) (row_num . 4)) ((by_col . 69) (col . 5) (row_num . 5)) ((by_col . 70) (col . 5) (row_num . 6)) ((by_col . 71) (col . 5) (row_num . 7)) ((by_col . 72) (col . 5) (row_num . 8)) ((by_col . 73) (col . 5) (row_num . 9)) ((by_col . 74) (col . 5) (row_num . 10)) ((by_col . 75) (col . 5) (row_num . 11)) ((by_col . 76) (col . 5) (row_num . 12)) ((by_col . 77) (col . 5) (row_num . 13)) ((by_col . 78) (col . 5) (row_num . 14)) ((by_col . 79) (col . 5) (row_num . 15)) ((by_col . 80) (col . 5) (row_num . 16)) ((by_col . 81) (col . 6) (row_num . 1)) ((by_col . 82) (col . 6) (row_num . 2)) ((by_col . 83) (col . 6) (row_num . 3)) ((by_col . 84) (col . 6) (row_num . 4)) ((by_col . 85) (col . 6) (row_num . 5)) ((by_col . 86) (col . 6) (row_num . 6)) ((by_col . 87) (col . 6) (row_num . 7)) ((by_col . 88) (col . 6) (row_num . 8)) ((by_col . 89) (col . 6) (row_num . 9)) ((by_col . 90) (col . 6) (row_num . 10)) ((by_col . 91) (col . 6) (row_num . 11)) ((by_col . 92) (col . 6) (row_num . 12)) ((by_col . 93) (col . 6) (row_num . 13)) ((by_col . 94) (col . 6) (row_num . 14)) ((by_col . 95) (col . 6) (row_num . 15)) ((by_col . 96) (col . 6) (row_num . 16)) ((by_col . 97) (col . 7) (row_num . 1)) ((by_col . 98) (col . 7) (row_num . 2)) ((by_col . 99) (col . 7) (row_num . 3)) ((by_col . 100) (col . 7) (row_num . 4)) ((by_col . 101) (col . 7) (row_num . 5)) ((by_col . 102) (col . 7) (row_num . 6)) ((by_col . 103) (col . 7) (row_num . 7)) ((by_col . 104) (col . 7) (row_num . 8)) ((by_col . 105) (col . 7) (row_num . 9)) ((by_col . 106) (col . 7) (row_num . 10)) ((by_col . 107) (col . 7) (row_num . 11)) ((by_col . 108) (col . 7) (row_num . 12)) ((by_col . 109) (col . 7) (row_num . 13)) ((by_col . 110) (col . 7) (row_num . 14)) ((by_col . 111) (col . 7) (row_num . 15)) ((by_col . 112) (col . 7) (row_num . 16)) ((by_col . 113) (col . 8) (row_num . 1)) ((by_col . 114) (col . 8) (row_num . 2)) ((by_col . 115) (col . 8) (row_num . 3)) ((by_col . 116) (col . 8) (row_num . 4)) ((by_col . 117) (col . 8) (row_num . 5)) ((by_col . 118) (col . 8) (row_num . 6)) ((by_col . 119) (col . 8) (row_num . 7)) ((by_col . 120) (col . 8) (row_num . 8)) ((by_col . 121) (col . 8) (row_num . 9)) ((by_col . 122) (col . 8) (row_num . 10)) ((by_col . 123) (col . 8) (row_num . 11)) ((by_col . 124) (col . 8) (row_num . 12)) ((by_col . 125) (col . 8) (row_num . 13)) ((by_col . 126) (col . 8) (row_num . 14)) ((by_col . 127) (col . 8) (row_num . 15)) ((by_col . 128) (col . 8) (row_num . 16)) ((by_col . 129) (col . 9) (row_num . 1)) ((by_col . 130) (col . 9) (row_num . 2)) ((by_col . 131) (col . 9) (row_num . 3)) ((by_col . 132) (col . 9) (row_num . 4)) ((by_col . 133) (col . 9) (row_num . 5)) ((by_col . 134) (col . 9) (row_num . 6)) ((by_col . 135) (col . 9) (row_num . 7)) ((by_col . 136) (col . 9) (row_num . 8)) ((by_col . 137) (col . 9) (row_num . 9)) ((by_col . 138) (col . 9) (row_num . 10)) ((by_col . 139) (col . 9) (row_num . 11)) ((by_col . 140) (col . 9) (row_num . 12)) ((by_col . 141) (col . 9) (row_num . 13)) ((by_col . 142) (col . 9) (row_num . 14)) ((by_col . 143) (col . 9) (row_num . 15)) ((by_col . 144) (col . 9) (row_num . 16)) ((by_col . 145) (col . 10) (row_num . 1)) ((by_col . 146) (col . 10) (row_num . 2)) ((by_col . 147) (col . 10) (row_num . 3)) ((by_col . 148) (col . 10) (row_num . 4)) ((by_col . 149) (col . 10) (row_num . 5)) ((by_col . 150) (col . 10) (row_num . 6)) ((by_col . 151) (col . 10) (row_num . 7)) ((by_col . 152) (col . 10) (row_num . 8)) ((by_col . 153) (col . 10) (row_num . 9)) ((by_col . 154) (col . 10) (row_num . 10)) ((by_col . 155) (col . 10) (row_num . 11)) ((by_col . 156) (col . 10) (row_num . 12)) ((by_col . 157) (col . 10) (row_num . 13)) ((by_col . 158) (col . 10) (row_num . 14)) ((by_col . 159) (col . 10) (row_num . 15)) ((by_col . 160) (col . 10) (row_num . 16)) ((by_col . 161) (col . 11) (row_num . 1)) ((by_col . 162) (col . 11) (row_num . 2)) ((by_col . 163) (col . 11) (row_num . 3)) ((by_col . 164) (col . 11) (row_num . 4)) ((by_col . 165) (col . 11) (row_num . 5)) ((by_col . 166) (col . 11) (row_num . 6)) ((by_col . 167) (col . 11) (row_num . 7)) ((by_col . 168) (col . 11) (row_num . 8)) ((by_col . 169) (col . 11) (row_num . 9)) ((by_col . 170) (col . 11) (row_num . 10)) ((by_col . 171) (col . 11) (row_num . 11)) ((by_col . 172) (col . 11) (row_num . 12)) ((by_col . 173) (col . 11) (row_num . 13)) ((by_col . 174) (col . 11) (row_num . 14)) ((by_col . 175) (col . 11) (row_num . 15)) ((by_col . 176) (col . 11) (row_num . 16)) ((by_col . 177) (col . 12) (row_num . 1)) ((by_col . 178) (col . 12) (row_num . 2)) ((by_col . 179) (col . 12) (row_num . 3)) ((by_col . 180) (col . 12) (row_num . 4)) ((by_col . 181) (col . 12) (row_num . 5)) ((by_col . 182) (col . 12) (row_num . 6)) ((by_col . 183) (col . 12) (row_num . 7)) ((by_col . 184) (col . 12) (row_num . 8)) ((by_col . 185) (col . 12) (row_num . 9)) ((by_col . 186) (col . 12) (row_num . 10)) ((by_col . 187) (col . 12) (row_num . 11)) ((by_col . 188) (col . 12) (row_num . 12)) ((by_col . 189) (col . 12) (row_num . 13)) ((by_col . 190) (col . 12) (row_num . 14)) ((by_col . 191) (col . 12) (row_num . 15)) ((by_col . 192) (col . 12) (row_num . 16)) ((by_col . 193) (col . 13) (row_num . 1)) ((by_col . 194) (col . 13) (row_num . 2)) ((by_col . 195) (col . 13) (row_num . 3)) ((by_col . 196) (col . 13) (row_num . 4)) ((by_col . 197) (col . 13) (row_num . 5)) ((by_col . 198) (col . 13) (row_num . 6)) ((by_col . 199) (col . 13) (row_num . 7)) ((by_col . 200) (col . 13) (row_num . 8)) ((by_col . 201) (col . 13) (row_num . 9)) ((by_col . 202) (col . 13) (row_num . 10)) ((by_col . 203) (col . 13) (row_num . 11)) ((by_col . 204) (col . 13) (row_num . 12)) ((by_col . 205) (col . 13) (row_num . 13)) ((by_col . 206) (col . 13) (row_num . 14)) ((by_col . 207) (col . 13) (row_num . 15)) ((by_col . 208) (col . 13) (row_num . 16)) ((by_col . 209) (col . 14) (row_num . 1)) ((by_col . 210) (col . 14) (row_num . 2)) ((by_col . 211) (col . 14) (row_num . 3)) ((by_col . 212) (col . 14) (row_num . 4)) ((by_col . 213) (col . 14) (row_num . 5)) ((by_col . 214) (col . 14) (row_num . 6)) ((by_col . 215) (col . 14) (row_num . 7)) ((by_col . 216) (col . 14) (row_num . 8)) ((by_col . 217) (col . 14) (row_num . 9)) ((by_col . 218) (col . 14) (row_num . 10)) ((by_col . 219) (col . 14) (row_num . 11)) ((by_col . 220) (col . 14) (row_num . 12)) ((by_col . 221) (col . 14) (row_num . 13)) ((by_col . 222) (col . 14) (row_num . 14)) ((by_col . 223) (col . 14) (row_num . 15)) ((by_col . 224) (col . 14) (row_num . 16)) ((by_col . 225) (col . 15) (row_num . 1)) ((by_col . 226) (col . 15) (row_num . 2)) ((by_col . 227) (col . 15) (row_num . 3)) ((by_col . 228) (col . 15) (row_num . 4)) ((by_col . 229) (col . 15) (row_num . 5)) ((by_col . 230) (col . 15) (row_num . 6)) ((by_col . 231) (col . 15) (row_num . 7)) ((by_col . 232) (col . 15) (row_num . 8)) ((by_col . 233) (col . 15) (row_num . 9)) ((by_col . 234) (col . 15) (row_num . 10)) ((by_col . 235) (col . 15) (row_num . 11)) ((by_col . 236) (col . 15) (row_num . 12)) ((by_col . 237) (col . 15) (row_num . 13)) ((by_col . 238) (col . 15) (row_num . 14)) ((by_col . 239) (col . 15) (row_num . 15)) ((by_col . 240) (col . 15) (row_num . 16)) ((by_col . 241) (col . 16) (row_num . 1)) ((by_col . 242) (col . 16) (row_num . 2)) ((by_col . 243) (col . 16) (row_num . 3)) ((by_col . 244) (col . 16) (row_num . 4)) ((by_col . 245) (col . 16) (row_num . 5)) ((by_col . 246) (col . 16) (row_num . 6)) ((by_col . 247) (col . 16) (row_num . 7)) ((by_col . 248) (col . 16) (row_num . 8)) ((by_col . 249) (col . 16) (row_num . 9)) ((by_col . 250) (col . 16) (row_num . 10)) ((by_col . 251) (col . 16) (row_num . 11)) ((by_col . 252) (col . 16) (row_num . 12)) ((by_col . 253) (col . 16) (row_num . 13)) ((by_col . 254) (col . 16) (row_num . 14)) ((by_col . 255) (col . 16) (row_num . 15)) ((by_col . 256) (col . 16) (row_num . 16)) ((by_col . 257) (col . 17) (row_num . 1)) ((by_col . 258) (col . 17) (row_num . 2)) ((by_col . 259) (col . 17) (row_num . 3)) ((by_col . 260) (col . 17) (row_num . 4)) ((by_col . 261) (col . 17) (row_num . 5)) ((by_col . 262) (col . 17) (row_num . 6)) ((by_col . 263) (col . 17) (row_num . 7)) ((by_col . 264) (col . 17) (row_num . 8)) ((by_col . 265) (col . 17) (row_num . 9)) ((by_col . 266) (col . 17) (row_num . 10)) ((by_col . 267) (col . 17) (row_num . 11)) ((by_col . 268) (col . 17) (row_num . 12)) ((by_col . 269) (col . 17) (row_num . 13)) ((by_col . 270) (col . 17) (row_num . 14)) ((by_col . 271) (col . 17) (row_num . 15)) ((by_col . 272) (col . 17) (row_num . 16)) ((by_col . 273) (col . 18) (row_num . 1)) ((by_col . 274) (col . 18) (row_num . 2)) ((by_col . 275) (col . 18) (row_num . 3)) ((by_col . 276) (col . 18) (row_num . 4)) ((by_col . 277) (col . 18) (row_num . 5)) ((by_col . 278) (col . 18) (row_num . 6)) ((by_col . 279) (col . 18) (row_num . 7)) ((by_col . 280) (col . 18) (row_num . 8)) ((by_col . 281) (col . 18) (row_num . 9)) ((by_col . 282) (col . 18) (row_num . 10)) ((by_col . 283) (col . 18) (row_num . 11)) ((by_col . 284) (col . 18) (row_num . 12)) ((by_col . 285) (col . 18) (row_num . 13)) ((by_col . 286) (col . 18) (row_num . 14)) ((by_col . 287) (col . 18) (row_num . 15)) ((by_col . 288) (col . 18) (row_num . 16)) ((by_col . 289) (col . 19) (row_num . 1)) ((by_col . 290) (col . 19) (row_num . 2)) ((by_col . 291) (col . 19) (row_num . 3)) ((by_col . 292) (col . 19) (row_num . 4)) ((by_col . 293) (col . 19) (row_num . 5)) ((by_col . 294) (col . 19) (row_num . 6)) ((by_col . 295) (col . 19) (row_num . 7)) ((by_col . 296) (col . 19) (row_num . 8)) ((by_col . 297) (col . 19) (row_num . 9)) ((by_col . 298) (col . 19) (row_num . 10)) ((by_col . 299) (col . 19) (row_num . 11)) ((by_col . 300) (col . 19) (row_num . 12)) ((by_col . 301) (col . 19) (row_num . 13)) ((by_col . 302) (col . 19) (row_num . 14)) ((by_col . 303) (col . 19) (row_num . 15)) ((by_col . 304) (col . 19) (row_num . 16)) ((by_col . 305) (col . 20) (row_num . 1)) ((by_col . 306) (col . 20) (row_num . 2)) ((by_col . 307) (col . 20) (row_num . 3)) ((by_col . 308) (col . 20) (row_num . 4)) ((by_col . 309) (col . 20) (row_num . 5)) ((by_col . 310) (col . 20) (row_num . 6)) ((by_col . 311) (col . 20) (row_num . 7)) ((by_col . 312) (col . 20) (row_num . 8)) ((by_col . 313) (col . 20) (row_num . 9)) ((by_col . 314) (col . 20) (row_num . 10)) ((by_col . 315) (col . 20) (row_num . 11)) ((by_col . 316) (col . 20) (row_num . 12)) ((by_col . 317) (col . 20) (row_num . 13)) ((by_col . 318) (col . 20) (row_num . 14)) ((by_col . 319) (col . 20) (row_num . 15)) ((by_col . 320) (col . 20) (row_num . 16)) ((by_col . 321) (col . 21) (row_num . 1)) ((by_col . 322) (col . 21) (row_num . 2)) ((by_col . 323) (col . 21) (row_num . 3)) ((by_col . 324) (col . 21) (row_num . 4)) ((by_col . 325) (col . 21) (row_num . 5)) ((by_col . 326) (col . 21) (row_num . 6)) ((by_col . 327) (col . 21) (row_num . 7)) ((by_col . 328) (col . 21) (row_num . 8)) ((by_col . 329) (col . 21) (row_num . 9)) ((by_col . 330) (col . 21) (row_num . 10)) ((by_col . 331) (col . 21) (row_num . 11)) ((by_col . 332) (col . 21) (row_num . 12)) ((by_col . 333) (col . 21) (row_num . 13)) ((by_col . 334) (col . 21) (row_num . 14)) ((by_col . 335) (col . 21) (row_num . 15)) ((by_col . 336) (col . 21) (row_num . 16)) ((by_col . 337) (col . 22) (row_num . 1)) ((by_col . 338) (col . 22) (row_num . 2)) ((by_col . 339) (col . 22) (row_num . 3)) ((by_col . 340) (col . 22) (row_num . 4)) ((by_col . 341) (col . 22) (row_num . 5)) ((by_col . 342) (col . 22) (row_num . 6)) ((by_col . 343) (col . 22) (row_num . 7)) ((by_col . 344) (col . 22) (row_num . 8)) ((by_col . 345) (col . 22) (row_num . 9)) ((by_col . 346) (col . 22) (row_num . 10)) ((by_col . 347) (col . 22) (row_num . 11)) ((by_col . 348) (col . 22) (row_num . 12)) ((by_col . 349) (col . 22) (row_num . 13)) ((by_col . 350) (col . 22) (row_num . 14)) ((by_col . 351) (col . 22) (row_num . 15)) ((by_col . 352) (col . 22) (row_num . 16)) ((by_col . 353) (col . 23) (row_num . 1)) ((by_col . 354) (col . 23) (row_num . 2)) ((by_col . 355) (col . 23) (row_num . 3)) ((by_col . 356) (col . 23) (row_num . 4)) ((by_col . 357) (col . 23) (row_num . 5)) ((by_col . 358) (col . 23) (row_num . 6)) ((by_col . 359) (col . 23) (row_num . 7)) ((by_col . 360) (col . 23) (row_num . 8)) ((by_col . 361) (col . 23) (row_num . 9)) ((by_col . 362) (col . 23) (row_num . 10)) ((by_col . 363) (col . 23) (row_num . 11)) ((by_col . 364) (col . 23) (row_num . 12)) ((by_col . 365) (col . 23) (row_num . 13)) ((by_col . 366) (col . 23) (row_num . 14)) ((by_col . 367) (col . 23) (row_num . 15)) ((by_col . 368) (col . 23) (row_num . 16)) ((by_col . 369) (col . 24) (row_num . 1)) ((by_col . 370) (col . 24) (row_num . 2)) ((by_col . 371) (col . 24) (row_num . 3)) ((by_col . 372) (col . 24) (row_num . 4)) ((by_col . 373) (col . 24) (row_num . 5)) ((by_col . 374) (col . 24) (row_num . 6)) ((by_col . 375) (col . 24) (row_num . 7)) ((by_col . 376) (col . 24) (row_num . 8)) ((by_col . 377) (col . 24) (row_num . 9)) ((by_col . 378) (col . 24) (row_num . 10)) ((by_col . 379) (col . 24) (row_num . 11)) ((by_col . 380) (col . 24) (row_num . 12)) ((by_col . 381) (col . 24) (row_num . 13)) ((by_col . 382) (col . 24) (row_num . 14)) ((by_col . 383) (col . 24) (row_num . 15)) ((by_col . 384) (col . 24) (row_num . 16))) )
