;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Montana-G-Lui-B-hw1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Brandon Lui blui
; Gustave Montana gmmontana

;;QUESTION 1
(define-struct film (title genre rating running-time opening-date receipts-collected))
;A film can be constructed by using (make-film String String String Natural Date Natural)
;interp: represents a film where
;title is the film's title in English
;genre is the film's genre category
;rating is the film's children rating (G, PG, PG-13, R, NC-17, NR)
;running-time is the film's running time in minutes using the define Date structure 
;opening-date is the film's public release date
;receipts-collected is a film's box office receipts collected (in millions of dollars)

(define-struct date (year month day))
;A date can be constructed by using (make-date Natrual Natrual Natural)
;interp: represents a date where
;year is the year as a natural
;month is the month as a natural
;day is the day of the month

(define HELLO (make-film "Hello" "Children" "G" 60 (make-date 2020 1 9) 100))
(define HELLO-2 (make-film "Hello 2" "Children" "PG" 60 (make-date 2020 2 9) 150))
(define HELLO-3 (make-film "Hello 3" "Children" "PG-13" 60 (make-date 2020 3 9) 200))
(define HELLO-4 (make-film "Hello 4" "Children" "R" 60 (make-date 2020 4 9) 300))
(define HELLO-5 (make-film "Hello 5" "Children" "X" 60 (make-date 2020 5 9) 400))

(define DATETEST1 (make-date 2020 5 9))
(define DATETEST2 (make-date 2019 2 9))
(define DATETEST3 (make-date 2120 5 19))
(define DATETEST4 (make-date 2020 1 8))


;;QUESTION 2
;;make-film: String String String Natural Date Natural -> Film
;;consume a film's title, genre, rating, running-time, opening-date, receipts-collected; produce a film 

;;film-title: Film -> String
;; consume a dilm; produce the film's title

;film-genre: Film -> String
;; consume a film; produce a film genre 

;film-rating: Film -> String
;; consume a film; produce a film's children rating (G, PG, PG-13, R, NC-17, NR)

;film-running-time: Film -> Natural 
;; consume a film; produce a film's running time in minutes 

;film-opening-date: Film -> Date
;; consume a film; produce a film's opening date (year, month, day)

;film-receipts-collected: Film -> Natural
;; consume a film; produce a film's box office receipts collected (in millions of dollars)

;;film? any -> Boolean
; consumes anything and produces true if it is a film

;;QUESTION 3
;; sutible-for-children?: Film -> Boolean
;; consume a film; produce true if rating is G, PG, or PG-13 (sutible for children)
; (define (sutible-for-children? f) true) ;stub 
(check-expect (sutible-for-children? HELLO) true)
(check-expect (sutible-for-children? HELLO-2) true)
(check-expect (sutible-for-children? HELLO-3) true)
(check-expect (sutible-for-children? HELLO-4) false)
(check-expect (sutible-for-children? HELLO-5) false)

(define (sutible-for-children? a-film)
(cond [( equal? (film-rating a-film) "G") true]
      [( equal? (film-rating a-film) "PG") true]
      [( equal? (film-rating a-film) "PG-13") true]
      [else false]
  ))

;;QUESTION 4
;;difference-in-receipts: Film Film -> Number
;; consumes two films, produces the difference in receipts for the two films (in millions of dollars) in a non-negative number
; (define (difference-in-receipts f1 f2) 0) ;stub 
(check-expect (difference-in-receipts HELLO HELLO-2) 50)
(check-expect (difference-in-receipts HELLO-2 HELLO-4) 150)
(check-expect (difference-in-receipts HELLO HELLO) 0)

(define (difference-in-receipts f1 f2)
 (abs (- (film-receipts-collected f1) (film-receipts-collected f2))))

;;QUESTION 5
;;modify-rating: Film String -> Film
; consumes a film and a new rating for the film (string) and produces a new film that is the same as the original with the new rating
; (define (modify-rating a-film newrating) HELLO) ;stub
(check-expect (modify-rating HELLO "R") (make-film "Hello" "Children" "R" 60 (make-date 2020 1 9) 100))
(check-expect (modify-rating HELLO-2 "NR") (make-film "Hello 2" "Children" "NR" 60 (make-date 2020 2 9) 150))

 (define (modify-rating a-film newrating)
(make-film (film-title a-film) (film-genre a-film) newrating (film-running-time a-film) (film-opening-date a-film) (film-receipts-collected a-film)) 
   )

;;QUESTION 6
;;opens-before?: Film Date -> Boolean
;consumes a film and a date and produces true if the given film opens before the given date, returns flase otherwise
;(define (opens-before? a-film a-date) true) ; stub
(check-expect (opens-before? HELLO DATETEST1) true) ; test true month
(check-expect (opens-before? HELLO DATETEST2) false) ; test false year
(check-expect (opens-before? HELLO (make-date 2020 1 10) ) true) ;test true day
(check-expect (opens-before? HELLO (make-date 2020 1 9) ) false) ;test false day
(check-expect (opens-before? HELLO (make-date 2019 12 31) )false);test false year
(check-expect (opens-before? HELLO (make-date 2020 2 9) )true) ;test true month
(check-expect (opens-before? HELLO-2 (make-date 2020 1 9) )false) ; test false same day 
(check-expect (opens-before? HELLO-2 (make-date 2020 2 1) )false) ;test false day 

(define (opens-before? a-film a-date)
  (cond
    [ (> (date-year (film-opening-date a-film)) (date-year a-date)) false]
    [ (> (date-month (film-opening-date a-film)) (date-month a-date)) false]
    [ (> (date-day (film-opening-date a-film)) (date-day a-date)) false]
    [ (equal? (film-opening-date a-film) a-date )false]
    [ else true ]))

;These are already defined above but copied here for reference
;(define HELLO (make-film "Hello" "Children" "G" 60 (make-date 2020 1 9) 100)) 
;(define HELLO-2 (make-film "Hello 2" "Children" "PG" 60 (make-date 2020 2 9) 150))
;(define HELLO-3 (make-film "Hello 3" "Children" "PG-13" 60 (make-date 2020 3 9) 200))
;(define HELLO-4 (make-film "Hello 4" "Children" "R" 60 (make-date 2020 4 9) 300))
;(define HELLO-5 (make-film "Hello 5" "Children" "X" 60 (make-date 2020 5 9) 400))
;
;(define DATETEST1 (make-date 2020 5 9))
;(define DATETEST2 (make-date 2019 2 9))
;(define DATETEST3 (make-date 2120 5 19))
;(define DATETEST4 (make-date 2020 1 8))