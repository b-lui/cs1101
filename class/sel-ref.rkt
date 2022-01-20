;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname sel-ref) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
empty

(define L1 (cons "Flames" empty))
(define L2 (cons 10 (cons 9 (cons 10 empty))))


(first L1)
(first L2)

(rest L1)
(rest L2)

(first (rest L2))
(first (rest (rest L2)))

(empty? empty)
(empty? L1)
(empty? 1)


;cons - a two argument constructor
;first - selects the first element of a list
;rest - selects the arguments after the first
; empty? produce true if argument is empty list


;;ListOfString is one of:
;- empty
;- (cons String ListOfString)
;interp. a list of strings
(define LOS1 empty)
(define LOS2 (cons "McGill" empty))
(define LOS3 (cons "UBC" (cons "McGill" empty)))

#;
(define (fn-for-los los) ;template
  (cond [Q A]
        [Q A]
        ))
(define (fn-for-los los))
  (cond [(empty? los)]
        []
        )) 