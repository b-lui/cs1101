;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname cs1101Day21A20before) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;#lang racket

;Class 21 Objectives
; 
;At the end of today's class you should
;KNOW: 
;
;	•	Accumulator-style recursive functions can be written using local. 
;	•	Tail recursive functions can be more efficient than the kinds of  (naive) recursive functions we have written so far. 
; 
;BE ABLE TO: 
;	•	Write accumulator-style recursive functions. 
;	•	Write accumulator-style recursive functions using local. 
;	•	Write tail-recursive functions. 



(define FIBS7 (list 1 1 2 3 5 8 13))

;;sum: ListOfNum -> Num
;;sum returns the sum of the numbers in a list

(define (sum lon)
  (if (empty? lon)
      0
      (+ (first lon) (sum (rest lon)))))

(check-expect (sum empty) 0)
(check-expect (sum FIBS7) 33)
(check-expect (sum (list -3 0 3)) 0)

#;(define (summer lon)
  (sum-up lon 0))

;;sum-up: ListOfNumbers Num -> Num
;;returns sum of list of numbers with running total (second argument)

#;(define (sum-up lon sum-so-far)
  (if (empty? lon)
      sum-so-far
      (sum-up (rest lon) (+ (first lon) sum-so-far))))
     


(check-expect (summer empty) 0)
(check-expect (summer FIBS7) 33)
(check-expect (summer (list -3 0 3)) 0)

;;keep-evens: ListOfNumber -> ListOfNumber
;;filter out odd integers, retaining only evens  [keep&chuck!]
(check-expect (keep-evens empty) empty)
(check-expect (keep-evens (list 2 5 1 2 4 5 2 8 10)) (list 2 2 4 2 8 10))
(check-expect (keep-evens (list 2 6 1 7 8)) (list 2 6 8))
#;(define (keep-evens lon)
  (cond [(empty? lon) empty]
        [(cons?  lon) (if (even? (first lon))
                          (cons (first lon) (keep-evens (rest lon)))
                          (keep-evens (rest lon)))]))

;;Now, do the same thing accumulator-style (with launcher)


(define (keep-evens a-lon)
  (local [(define (keep-evens acc a-lon)
            (cond [(empty? a-lon) acc]
                  [(cons? a-lon) (if (even? (first a-lon))
                                     (keep-evens (append acc (list (first a-lon)))
                                                 (rest a-lon))
                                     (keep-evens acc (rest a-lon)))]))]
    (keep-evens empty a-lon)))
                                                 




#;(define (only-evens lon)
  (only-evens-acc lon empty))s

#;(define (only-evens-acc lon evens-so-far)
  (cond [(empty? lon) evens-so-far]
        [(cons? lon) (if (even? (first lon))
                         (only-evens-acc (rest lon) (cons (first lon) evens-so-far))
                         (only-evens-acc (rest lon) evens-so-far))]))
      
;;accumulator-style with local / trampoline

;;summer: ListOfNumber -> Number
;;consumes a list of numbers and produces their sum

#;(define (summer lon)
  (local
    []
    (trampoline / launcher / initializer)))


(define (summer a-lon)
  (local [
          (define (summer acc a-lon)
            (cond [(empty? a-lon) acc]
                  [(cons? a-lon)
                   (summer (+ (first a-lon) acc) (rest a-lon))]))]
    (summer 0 a-lon)))
  


#;(define (summer lon)
  (local
    [(define (sum-up lon accumulator)
       (if (empty? lon)
           accumulator
           (sum-up (rest lon) (+ accumulator (first lon)))))]
    (sum-up lon 0))) 


;;Tail Recursion  /   slide-rule story

;;A recursive call is in "tail position" if it returns its value IMMEDIATELY
;;That is, it doesn't have to wait around for any other computation.

;;A recursive function is tail recursive if ALL of its recursive calls are
;;in tail position.  A single recursive call NOT in tail position can cause
;;build-ups and backs ups.  Such a function is NOT tail recursive.


;;Copy stuff from only-evens above






;;Next week -> Mutable Variables

;;What's your goose time?






;(define TESTLIST (build-list 100000 identity))



; ;; long-words:  ListOfString -> ListOfString
; ;; produces a list of the words with more than 5 characters
; (define (long-words alos)
;   (long-words-accum alos empty))
; 
; ;; long-words-accum:  ListOfString ListOfString -> ListOfString
; ;; consumes a list of strings and an accumulator, and produces a list of words
; ;; with more than 5 characters, building the list as we go in list-so-far
; (define (long-words-accum alos list-so-far)
;   (cond [(empty? alos) list-so-far]
;         [(cons? alos) (if (> (string-length (first alos)) 5)
;                           (long-words-accum (rest alos) (cons (first alos) list-so-far))
;                           (long-words-accum (rest alos) list-so-far))]))
; 


;; Here's the non-accumulator version of long-words.  The two versions build the list
;; in reverse order from each other 

;; long-words:  ListOfString -> ListOfString
;; produces a list of the words with more than 5 characters
(define (long-words alos)
  (cond [(empty? alos) empty]
        [(cons? alos) (if (> (string-length (first alos)) 5)
                          (cons (first alos) (long-words (rest alos)))
                          (long-words (rest alos)))]))

(check-expect (long-words (list "USA" "Canada" "Peru" "Guatemala"))
              (list "Canada" "Guatemala"))


;; largest:  ListOfNumber (non-empty) -> Number
;; consumes a list of numbers and produces the largest number in the list
(define (largest alon)
  (largest-accum alon (first alon)))

;; largest-accum:  ListOfNumber Number -> ListOfNumber
;; produces the largest number in the list, remembering the largest seen so far
;; in largest-so-far
(define (largest-accum alon largest-so-far)
  (cond [(empty? alon) largest-so-far]
        [(cons? alon) (if (> (first alon) largest-so-far)
                          (largest-accum (rest alon) (first alon))
                          (largest-accum (rest alon) largest-so-far))]))


(define SOMENUMS (list 1 2 3 4 5 4 3 2 1 0))

(check-expect (largest SOMENUMS) 5)

;;foldr & foldl
;;apply
;;sort



(define ALPHABET (list "z" "a" "y" "b" "c" "x" "d" "w" "e" "v" "f" "u" "g" "t" "h" "s" "i" "r" "j" "q" "k" "p" "l" "o" "m" "n"))




;; reverse-list:  ListOfString -> ListOfString
;; reverses the order of the elements in the list
(define (reverse-list alos)
  (reverse-accum alos empty))

;; reverse-accum:  ListOfString ListOfString -> ListOfString
;; reverses the order of the elements in alos, building the reversed list
;; in rev-list
(define (reverse-accum alos rev-list)
  (cond [(empty? alos) rev-list]
        [(cons? alos) (reverse-accum (rest alos) (cons (first alos) rev-list))]))


;; non-accumulator version:

;; reverse-list2:  ListOfString -> ListOfString
;; reverses the order of the elements in the list
(define (reverse-list2 alos)
  (cond [(empty? alos) empty]
        [(cons? alos) (append (reverse-list2 (rest alos))
                              (list (first alos)))]))

;fibonacci: Natural -> Natural
;compute the nth Fibonacci number

(define (fibonacci n)
  (if (or (= 1 n)
          (= 2 n))
      1
      (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(check-expect (fibonacci 1) 1)
(check-expect (fibonacci 2) 1)
(check-expect (fibonacci 7) 13)     
(check-expect (fibonacci 9) 34)

;This is Fibonacci by definition.  Absolutely perfect.
;Also, very very slow because each call makes two more calls.
;That is exponential growth.
;(Additionally, we have to re-compute intermediate values.)
;((Yes, there are ways to save them and look them up again later, when needed.))

;(define (fibonacci n)




;Instead of starting at the top and computing down....
;We can start at the bottom and compute up, just as we would 'by hand'.

;;fib-totem: Natural -> Natural
;;compute Fibonacci numbers accumulator style
;;(this will just be launcher program)

(define (fib-totem n)
  (if (or (= 1 n)
          (= 2 n))
      1
      (fibonacci-acc-style n 3 1 1)))


(define (fibonacci-acc-style target current bigfib smallfib)
  (if (= current target)
      (+ bigfib smallfib)
      (fibonacci-acc-style target (add1 current) (+ bigfib smallfib) bigfib)))

(check-expect (fib-totem 1) 1)
(check-expect (fib-totem 2) 1)
(check-expect (fib-totem 3) 2)
(check-expect (fib-totem 7) 13)

