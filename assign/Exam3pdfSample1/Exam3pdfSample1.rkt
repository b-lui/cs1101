;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Exam3pdfSample1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;Brandon Lui

;1.  Higher-Order Functions (20 points)

;Evaluate the following expressions that use abstract functions:

;a).(filter even? (list 1 1 2 3 5 8))
; (list 2 8)

;b).(map sqr (list 1 1 2 3 5 8))
; (list 1 1 4 9 25 64)

;c).(foldr * 1 (list 1 1 2 3 5 8))
; 240

;d).(ormap odd? (list 1 1 2 3 5 8))
; true

;2.  Higher-Order Functions on Lists of Structs (15 points)

;;Biologists on Nomanisan Island study the moose population by tagging them
(define-struct tag (name year color))
;;Tag is a (make-tag String Natural String)
;;interp: represents a tag where
;;        name is the name of the biologist who tagged the moose
;;        year is the year the tag was applied
;;        color is the color of the tag

;;ListOfTag is one of
;;  - empty
;;  - (cons Tag ListOfTag)

;a ListOfMoose is a ListOfTag

;Using filter and/or map, write a function satisfying the following signature/purpose:

;;all-year-color: ListOfMoose Natural String -> ListOfString
;;consumes a list of moose and a year and a color
;;returns a list of the names of researchers who tagged a moose
;;with given year and given color
(define  MOOSE-TEST (list (make-tag "Brandon" 2001 "Green")
                          (make-tag "Allen" 2021 "Blue")
                          (make-tag "Eddy" 2004 "Red")
                          (make-tag "Joe" 2004 "Red")
                          (make-tag "Fred" 2021 "Blue")))
(check-expect (all-year-color MOOSE-TEST 2020 "Green") empty)
(check-expect (all-year-color empty 2020 "Green") empty)
(check-expect (all-year-color MOOSE-TEST 2021 "Green") empty)
(check-expect (all-year-color MOOSE-TEST 2021 "Blue") (list "Allen" "Fred"))
(check-expect (all-year-color MOOSE-TEST 2004 "Red") (list "Eddy" "Joe"))
; (define (all-year-color a-lom year color) empty);stub

(define (all-year-color a-lom year color)
  (local [(define (all-year-color? a-moose)
            (and (= year (tag-year a-moose)) (string=? color (tag-color a-moose))))]
    (map tag-name (filter all-year-color? a-lom))))

;3.  Accumulator-Style Programming (20 points)
;The data definitions from Problem 2 again

;Using accumulator-style recursion, write a function satisfying the following signature/purpose:

;;all-year-color: ListOfMoose Natural String -> ListOfString
;;consumes a list of moose and a year and a color
;;returns a list of the names of researchers who tagged a moose
;;with given year and given color
(check-expect (all-year-color-2 MOOSE-TEST 2020 "Green") empty)
(check-expect (all-year-color-2 empty 2020 "Green") empty)
(check-expect (all-year-color-2 MOOSE-TEST 2021 "Green") empty)
(check-expect (all-year-color-2 MOOSE-TEST 2021 "Blue") (list "Allen" "Fred"))
(check-expect (all-year-color-2 MOOSE-TEST 2004 "Red") (list "Eddy" "Joe"))

(define (all-year-color-2 a-lom year color)
  (local [
          (define (all-year-color? a-moose)
            (and (= year (tag-year a-moose)) (string=? color (tag-color a-moose))))
          
          (define (all-year-color-2 acc a-lom)
            (cond [(empty? a-lom) acc]
                  [(cons? a-lom) (if (all-year-color? (first a-lom))
                                     (all-year-color-2 (append acc (list (first a-lom))) (rest a-lom))
                                     (all-year-color-2 acc (rest a-lom)))
                                 ]))
          
          (define (tag-names acc a-lom)
            (cond [(empty? a-lom) acc]
                  [(cons? a-lom) (tag-names
                                  (append acc (list (tag-name (first a-lom))))
                                  (rest a-lom))]))
          ]
    (tag-names empty (all-year-color-2 empty a-lom))))

;4.  Mutable Variables (30 points)Here are some data definitions:
(define-struct hotel (name rooms occupied rate))
;;Hotel is a (make-hotel String Natural Natural Natural)
;;interp: represents a hotel where
;;        name is the name of the hotel
;;        rooms is the total number of rooms in the hotel
;;        occupied is the number of rooms currently occupied
;;        rate is the per-night rental cost of a room (in dollars)

;;a ListOfHotel is one of:
;;  - empty
;;  - (cons Hotel ListOfHotel)

;a).  (15 points) Write a function that satisfies the following signature/purpose:

;;check-in: ListOfHotel -> Natural
;;consumes a list of hotels and returns the rate of the first available room
;;returns an error "No Vacancies" if every room in every hotel is rented
;;EFFECT: The number of occupied rooms in a hotel is changed (incremented)

;HOLIDAY is a Hotel
;remembers information about a hotel
(define HOLIDAY (make-hotel "Holiday Inn" 40 40 89))
;MARRIOT is a Hotel
;remembers information about a hotel
(define MARRIOT (make-hotel "Marriot Hotel" 100 100 250))
;HAMPTON is a Hotel
;remembers information about a hotel
(define HAMPTON (make-hotel "Hampton Inn" 50 49 150))
;TRUMP is a Hotel
;remembers information about a hotel
(define TRUMP (make-hotel "Trump Hotel" 200 198 400))

(check-error (check-in empty) "There are no hotels under the given critera.")
;TRUMP ;"TRUMP before test fucntion. Will increment occupancy by 1."
(check-expect (check-in (list HOLIDAY MARRIOT TRUMP HAMPTON )) (make-hotel "Trump Hotel" 200 199 400))
;HAMPTON ;"HAMPTON before test fucntion. Will increment occupancy by 1."
(check-expect (check-in (list HOLIDAY MARRIOT HAMPTON TRUMP)) (make-hotel "Hampton Inn" 50 50 150))
;TRUMP ;"TRUMP before test fucntion. Will increment occupancy by 1."
(check-expect (check-in (list TRUMP HOLIDAY MARRIOT HAMPTON )) (make-hotel "Trump Hotel" 200 200 400))
(check-error (check-in (list TRUMP HOLIDAY MARRIOT HAMPTON )) "There are no hotels under the given critera.")
;(define (check-in a-lom) (make-hotel "Trump " 200 199 400));stub
(define (check-in a-lom)
  (local [(define (hotel-open? a-hotel)
            (< 0 (- (hotel-rooms a-hotel) (hotel-occupied a-hotel))))
          (define (minus-room a-hotel)
            (begin (set-hotel-occupied! a-hotel (+ 1 (hotel-occupied a-hotel)))  a-hotel))
          ]
    (cond [(empty? a-lom) (error "There are no hotels under the given critera.")]
          [(cons? a-lom) (if (hotel-open? (first a-lom))
                             (minus-room (first a-lom))
                             (check-in (rest a-lom)))])))

;b).  (15 points) Usingset!write a function that satisfies the following signature/purpose:
;;Suppose all the hotels on Nomanisan Island are contained in the list NOMANOTELS.

;;remove-full-hotels:  -> ListOfHotel
;;deletes all hotels completely occupied from NOMANOTELS
;;EFFECT: Possibly removes some hotels from NOMANOTELS

;HOLIDAY-2 is a Hotel
;remembers information about a hotel
(define HOLIDAY-2 (make-hotel "Holiday Inn" 40 40 89))
;MARRIOT-2 is a Hotel
;remembers information about a hotel
(define MARRIOT-2 (make-hotel "Marriot Hotel" 100 100 250))
;HAMPTON-2 is a Hotel
;remembers information about a hotel
(define HAMPTON-2 (make-hotel "Hampton Inn" 50 49 150))
;TRUMP-2 is a Hotel
;remembers information about a hotel
(define TRUMP-2 (make-hotel "Trump Hotel" 200 198 400))

;NOMANOTELS is a ListOfHotel
;remembers information about a list of hotels
(define NOMANOTELS (list HOLIDAY-2 MARRIOT-2 HAMPTON-2 TRUMP-2))

(check-expect (remove-full-hotels--lom NOMANOTELS) 
              (list  HAMPTON-2 TRUMP-2 ))

(check-expect (remove-full-hotels--lom (list TRUMP-2 MARRIOT-2 HAMPTON-2 HOLIDAY-2) )
              (list  TRUMP-2 HAMPTON-2  ))

(define (remove-full-hotels)
  (set! NOMANOTELS (remove-full-hotels--lom NOMANOTELS)))

(define (remove-full-hotels--lom a-loh)
  (local [(define (remove-full-hotels--lom a-loh acc)
            (cond [(empty? a-loh) acc]
                  [(cons? a-loh) (if (hotel-not-full? (first a-loh))
                                     (remove-full-hotels--lom (rest a-loh) (append acc (list (first a-loh))))
                                     (remove-full-hotels--lom (rest a-loh) acc))]))
          (define (hotel-not-full? a-hotel)
            (< 0 (- (hotel-rooms a-hotel) (hotel-occupied a-hotel))))
          ]
    (remove-full-hotels--lom a-loh empty)))


;5.  Data With Cycles (15 points)Here are some data definitions:
(define-struct movie (title year prequel sequel))
;;Movie is a (make-movie String Natural Flick Flick)
;;interp: represents a movie where
;;        title is the title of the movie
;;        year is the year the movie was released
;;        prequel is the preceding Movie in the franchise (or false)
;;        sequel is the following Movie in the franchise (or false)

;;a Flick is one of:
;;  - false
;;  - Movie

;The  original  “Star  Wars”  trilogy  consisted  of  EpisodeIV,  entitled  “A  New  Hope”  andreleased in 1977
;  EpisodeV, entitled “The Empire Strikes Back” and released in 1980
;  and EpisodeVI, entitled “Return of the Jedi” and released in 1983.

;Write a sequence of expressions that results in a (cinematic family) tree containing all three Movies correctly defined in terms of each other.

;;EpisodeIV is a Movie
;;remembers information about the star wars film
(define EpisodeIV (make-movie "A New Hope" 1977 false false))
;;EpisodeV is a Movie
;;remembers information about the star wars film
(define EpisodeV (make-movie "The Empire Strikes Back"  1980 EpisodeIV false))
;;EpisodeVI is a Movie
;;remembers information about the star wars film
(define EpisodeVI (make-movie "Return of the Jedi"  1983 EpisodeV false))
(set-movie-sequel! EpisodeIV EpisodeV)
(set-movie-sequel! EpisodeV EpisodeVI)

(define StarWars (list EpisodeIV EpisodeV EpisodeVI))

(define EpisodeIV-1 (make-movie "A New Hope" 1977 false false))
(define EpisodeV-1  (make-movie "The Empire Strikes Back" 1980 false false))
(define EpisodeVI-1 (make-movie "Return of the Jedi" 1983 false false))

(set-movie-sequel!  EpisodeIV-1 EpisodeV-1)
(set-movie-sequel!  EpisodeV-1 EpisodeVI-1)
(set-movie-prequel! EpisodeVI-1 EpisodeV-1)
(set-movie-prequel! EpisodeV-1 EpisodeIV-1)

(define StarWars-1 (list EpisodeIV-1 EpisodeV-1 EpisodeVI-1))



