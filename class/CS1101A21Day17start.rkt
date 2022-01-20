;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname CS1101A21Day17start) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t write repeating-decimal #f #t none #f () #f)))
;Class 17 Objectives
; 
;At the end of today's class you should
;KNOW: 
;	• That functions are values and can be passed as arguments to other functions 
;	• That filter and map can be used whenever you want to extract elements from a list according to some predicate 
;	• That filter and map provide a compact way to write certain functions over lists 
; 
;BE ABLE TO: 
;	• Use filter and map to write functions over lists. 
; 
;Sample Exam Question: 
;A database of college students staying in residence halls is made up of a list of structs with the following format:

;; a Student is a (make-student String Symbol Number String)
(define-struct student(name gender age id))
;Using filter, write a function list-all-females that consumes a ListOfStudent and produces a ListOfStudent. The list that is produced contains only the female students. 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define INTS (list 0 1 -1 2 -2 3 -3 4 -4 5 -5))


;; extract-positives:  ListOfNumber -> ListOfNumber
;; produces a list of only the positive numbers
(define (extract-positives alon)
  (cond [(empty? alon) empty]
        [(cons? alon) (if (positive? (first alon))
                          (cons (first alon) (extract-positives (rest alon)))
                          (extract-positives (rest alon)))]))


;; short-strings:  Natural ListOfString -> ListOfString
;; consumes a length and a list of strings and produces a list of those
;; strings with fewer than the given number of chars
(define (short-strings limit alos)
  (cond [(empty? alos) empty]
        [(cons? alos) (if (< (string-length (first alos)) limit)
                          (cons (first alos) (short-strings limit (rest alos)))
                          (short-strings limit (rest alos)))]))



; ;; filter IS BUILT-IN TO RACKET.  YOU DON'T HAVE TO DEFINE IT
; 
; ;; filter:  (Alpha -> Boolean) ListOfAlpha -> ListOfAlpha
; ;; consumes a predicate and a list of alphas and produces a list of only those alphas
; ;; for which the given predicate function keep? is true
; (define (filter keep? aloa)
;   (cond [(empty? aloa) empty]
;         [(cons? aloa) (if (keep? (first aloa))
;                           (cons (first aloa) (filter keep? (rest aloa)))
;                           (filter keep? (rest aloa)))]))
; 



;; HERE'S ANOTHER WAY TO WRITE extract-positives, USING filter

; ;; extract-positives:  ListOfNumber -> ListOfNumber
; ;; produces a list of only the positive numbers
; (define (extract-positives alon)
;   (filter positive? alon))

(define (double num)
  (* 2 num))


;;A Universal Function?

#;(define (compute operator arg1 arg2)
  (operator arg1 arg2))


;; map:  (Alpha -> Beta) ListOfAlpha -> ListOfBeta
;; consumes a predicate and a list of alphas and produces a list of only those alphas
;; for which the given predicate function keep? is true

;; build-list:  Natural (Natural -> Alpha) -> ListOfAlpha


#;(define (rando x)
  (random 10))