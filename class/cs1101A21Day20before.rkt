;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname cs1101A21Day20before) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;#lang racket
;#lang eopl

;Class 20 Objectives
 
;At the end of today's class you should
;KNOW: 
;	•  That accumulator-style functions can be more efficient than the kinds of recursive functions we have written so far. 
;	•  That accumulator-style programming is the style of programming used in many other programming languages.

;BE ABLE TO: 
;	•  Convert a Racket program to a program that accomplishes the same task "accumulator-style". 


;;Accumulator-style recursion

;;sum a list
;;  Naively

(define FIBS7 (list 1 1 2 3 5 8 13))

;;sum: ListOfNum -> Num
;;sum returns the sum of the numbers in a list

#;(define (sum lon)
    (if (empty? lon)
        0
        (+ (first lon) (sum (rest lon)))))

#|(check-expect (sum empty) 0)
(check-expect (sum FIBS7) 33)
(check-expect (sum (list -3 0 3)) 0)|#

;;  Accumulator style

;;An accumulator is typically a parameter(s) used to keep track of
;;the work done up to the time of a recursive call.
;;With naive recursion, a call is made without reference to any previous progress.

;;summer: ListOfNum -> Num
;;sum returns the sum of the numbers in a list
;;accumulator style
(define (summer a-lon)
  (local [(define (sum-up a-lon accumulator)
            (cond [(empty? a-lon) accumulator]
                  [(cons? a-lon) (sum-up (rest a-lon) (+ (first a-lon) accumulator))]))]
                
    (sum-up a-lon 0)))

;Here 'summer' is a launching program.  Such programs makeit look to the user as if
;ordinary recursion may be taking place -- i.e. user does not have to initialize
;whatever accumulator(s) will be employed.
;The launcher takes care of that.  Here, we start with a zero sum-so-far.

;Triangular numbers?

#;(define (summer lon)
    (sum-up lon 0))

;;sum-up: ListOfNumbers Num -> Num
;;returns sum of list of numbers with running total (second argument)
#;(define (sum-up lon accumulator)
    (if (empty? lon)
        accumulator
        (sum-up (rest lon) (+ (first lon) accumulator))))


(check-expect (summer empty) 0)
(check-expect (summer FIBS7) 33)
(check-expect (summer (list -3 0 3)) 0)


;factorial accumulator-style

;(define (factorial n)
#;(define (fibonacci n)
    (if (or (= n 1) (= n 2))
        1
        (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(define (fibonacci n)
    (local [
(define (fib-acc target bigfib smallfib accumulator)
  (if (= target accumulator)
      bigfib
      (fib-acc target (+ bigfib smallfib) bigfib (+ 1 accumulator))))

            ]
(if (or (= n 1) (= n 2))
        1
        (fib-acc n 1 1 2))))



;;Why accumulator style?

;;Fibonacci detour....

;;1 1 2 3 5 8 13 ...


;fibonacci: Natural -> Natural
;compute the nth Fibonacci number


;This is Fibonacci by definition.  Absolutely perfect.
;Also, very very slow because each call makes two more calls.
;That is exponential growth.
;(Additionally, we have to re-compute intermediate values.)
;((Yes, there are ways to save them and look them up again later, when needed.))

;(define (fibonacci n)


(check-expect (fibonacci 1) 1)
(check-expect (fibonacci 2) 1)
(check-expect (fibonacci 3) 2)
(check-expect (fibonacci 7) 13)


;Instead of starting at the top and computing down....
;We can start at the bottom and compute up, just as we would 'by hand'.

;;fib-totem: Natural -> Natural
;;compute Fibonacci numbers accumulator style
;;(this will just be launcher program)



#|(check-expect (fib-totem 1) 1)
(check-expect (fib-totem 2) 1)
(check-expect (fib-totem 3) 2)
(check-expect (fib-totem 7) 13)|#

   



;largest in list

;;largest-in-list: ListOfNumbers -> Number
;;determine largest number in a list

;We assume a list -- if it's empty, the return value is non-numeric (probably)


(check-expect (largest-in-list FIBS7) 13)
(check-expect (largest-in-list (reverse FIBS7)) 13)
(check-expect (largest-in-list (list 5)) 5)
(check-expect (largest-in-list (list 1 2 3 4 3 2 1)) 4)

(define (largest-in-list a-lon)
  (local [
          (define (largest-in-list--acc accumulator a-lon)
            (cond [(empty? a-lon) accumulator]
                  [(> accumulator (first a-lon)) (largest-in-list--acc accumulator (rest a-lon))]
                  [ else (largest-in-list--acc (first a-lon) (rest a-lon))]))
          ]
    (largest-in-list--acc (first a-lon) (rest a-lon))))


;keep&chuck list

;;only-odds-in-list: LoN -> LoN
;;keep&chuck accumulator style
  

(define (only-odds-in-list a-lon)
  (local [
          (define (only-odds-in-list acc a-lon)
            (cond [(empty? a-lon) acc]
                  [(cons? a-lon) (if (odd? (first a-lon))
                                     (only-odds-in-list (append (list (first a-lon)) acc) (rest a-lon))
                                     (only-odds-in-list acc (rest a-lon)))]))
          ]
    (only-odds-in-list empty a-lon)))
            

#;(define (only-odds-in-list lon)
    (Only-Odds-In-List empty lon));List to be built starts empty.

;;Only-Odds-In-List: LoN LoN ->  LoN       
;;first list is accumulated odds (totem!)
;;second list is remaining possible odds


;;Important!  We are now recurring with TWO lists.
;;One is the result we want/are building
;;The other is the list we are examining somehow and shrinking.
;;Don't get them mixed up.
             

(check-expect (only-odds-in-list FIBS7) (reverse (list 1 1 3 5 13)))
(check-expect (only-odds-in-list empty) empty)
(check-expect (only-odds-in-list (list 4)) empty)
(check-expect (only-odds-in-list (list 5)) (list 5))

;We did find that our list grows backwards.  Insted of growing it up, we sort of
;push it down.  Very common.  







;(define (fibonacci n)
;  (if (or (= 1 n)
;          (= 2 n))
;      1
;      (+ (fibonacci (- n 1))
;         (fibonacci (- n 2)))))
;
;(define (fib n)
;  (if (or (= 1 n)
;          (= 2 n))
;      1
;      (Fib n 3 1 1)))
;
;(define (Fib n kount bigfib smallfib)
;  (if (= n kount)
;      (+ bigfib smallfib)
;      (Fib n (+ kount 1) (+ bigfib smallfib) bigfib)))
;
;
;(foldr + 0 (build-list 5 identity))

(define 2to50 (expt 2 50))

(define MILES 93000000)
(define FEET (* 5280 MILES))
(define INCHES (* 12 FEET))
(define CM (* 2.54 INCHES))
(define MM (* 10 CM))
MM

(define TRIPS (/ 2to50 MM))
(define ROUNDTRIPS (/ TRIPS 2))

#;(define (fib n)
    (if (or (= n 1) (= n 2))
        1
        (+ (fib (- n 1)) (fib (- n 2)))))

#;(define (fibonacci n)
    (if (or (= n 1) (= n 2))
        1
        (Fibonacci n 1 1 3)))

#;(define (Fibonacci target bigfib smallfib nextfib)
    (if (= target nextfib)
        (+ bigfib smallfib)
        (Fibonacci target (+ bigfib smallfib) bigfib (+ nextfib 1))))


#;(define (factorial n)
    (local
      [(define (fact-acc n index acc)
         (if (= n index)
             (* n acc)
             (fact-acc n (+ 1 index) (* index acc))))]
      (fact-acc n 1 1)))