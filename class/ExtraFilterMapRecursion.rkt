;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname ExtraFilterMapRecursion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #t)))
;; strings-shorter-than:  ListOfString Natural -> ListOfString
;; consume a list of strings, and a limit on the size of the string, and
;; produces a list of only those strings with fewer characters than the given limit
(define (strings-shorter-than alos limit)
  (local [(define (shorter-than? astr)
            (< (string-length astr) limit))]
  (filter shorter-than?  alos)))


; ;; map is built into Racket
; 
; ;; map: (Alpha-> Beta) ListOfAlpha -> ListOfBeta
; ;; consumes a function f and a list of alphas loa and produces the list obtained by applying
; ;; f to every element of loa
; (define (map f aloa)
;   (cond [(empty? aloa) empty]
;         [(cons? aloa) (cons (f (first aloa)) (map f (rest aloa)))]))
; 


(define-struct dillo (length dead?))
;; a Dillo is a (make-dillo Natural Boolean)
;; interp:  represents an armadillo where
;;   length is the length of the armadillo (in feet)
;;   dead? is true if the armadillo is dead


;; lengths-of-dillos:  ListOfDillo -> ListOfNatural
;; consumes a list of dillos and produces a list of the lengths of all the dillos
(define (lengths-of-dillos alod)
  (map dillo-length alod))

(check-expect (lengths-of-dillos (list (make-dillo 3 false) (make-dillo 1 false) (make-dillo 4 true)))
              (list 3 1 4))

;; grow-dillos:  ListOfDillo -> ListOfDillo
;; consumes a list of dillos and creates a list where every dillo is one unit longer than the original
(define (grow-dillos alod)
  (map grow alod))

;; grow:  Dillo -> Dillo
;; consumes a dillo and creates a dillo one unit longer than the original
(define (grow a-dillo)
  (make-dillo (+ 1 (dillo-length a-dillo)) (dillo-dead? a-dillo)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Try these problems tonight

(define-struct lp (title artist price copies category))
;; an LP is a (make-lp String String Number Natural String)
;; interp:  a long-playing record where
;;    title is the title of the LP
;;    artist is the recording artist
;;    price is the price
;;    copies is the number of copies of the LP in stock
;;    category is the genre

(define HELP (make-lp "Help" "Beatles" 14.95 45 "rock"))

;; a ListOfLP is one of
;;     empty
;;     (cons LP ListOfLP)

;; using map and/or filter define the following functions:

;; all-titles:  ListOfLP -> ListOfString
;; consumes a list of LPs and produces a list of the titles of all the LPs

;; titles-in-stock:  ListOfLP -> ListOfString
;; consumes a list of LPs and produces the titles of all those LPs with at
;; least one copy in stock


;; titles-by:  String ListOfLP -> ListOfString
;; consumes the name of an artist and a list of LPs, and produces a list of
;; the titles of all LPs by the given artist



;; blues-sale: ListOfLP -> ListOfLP
;; consumes a list of LPs and produces a list in which
;; each blues LP is discounted by 10%



;;Use the data definitions and function descriptions above for an inventory of long-playing records to re-write the function titles-in-stock as an accumulator-style (recursive) program. 
