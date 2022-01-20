;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname CanvasSampleExam3workfile) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #t)))
; HtDP RECIPE:
; 1. Signature, Purpose, Stub
; 2. Examples (wrapped in check-expect)
; 3. Inventory - Template & Constants
; 4. Code Body
; 5. Test and Debug
 
  
;;Template:
;;
;;(define (fn-name ...)
;;   (...  ...)


;; a ListOfString is one of
;;     empty
;;     (cons String ListOfString)


; ;; los-fcn:  ListOfString ->
; ;;
; (define (los-fcn alos)
;   (cond [(empty? alos)  (...)      ]
;         [(cons? alos)   (... (first alos)
;                              (los-fcn (rest alos)))]))


;; a ListOfNumber is one of
;;   empty
;;   (cons Number ListOfNumber)

; ;; lon-fcn:  ListOfNumber ->
; ;;
; (define (lon-fcn alon)
;   (cond [(empty? alon)  (...)      ]
;         [(cons? alon)   (... (first alon)
;                              (lon-fcn (rest alon)))]))


;1 (20) HOF  build-list/filter/map/foldr
;2 (20) map/filter on [crabs of paradise] lobster buoys (two colors/EXAM)/moose tags?
;3 (20) acc style for above (#3)
;4 (30) (a) set! remove-from-list (15) (b) set-struct! change (15)
;5 (15) cycle (15) films/spouses


;1

(build-list 4 sqr)

(filter zero? (list -2 -1 0 1 2 3))

(map add1 (list -2 -1 0 1 2 3))

(foldr + 0 (list -2 -1 0 1 2 3))


;1a). Create (list -2 -1 0 1 2 3) with an expression involving higher-order functions.

(build-list 6 (lambda (n) (- n 2))) 


;1b). Why does (filter sqr (list 0 1 4 9 16 25 36)) NOT return (list 0 1 4 9 16 25 36) ?

;filter needs a boolean value function as the peramater for it's higher order function. since the sqr fucniton takes in a number and returns a number, the function will fail




;1c). In class, we found we could sneakily use abs with build-list instead of identity to create lists of integers.
;That is, (build-list 5 abs) and (build-list 5 identity) both generate the same list.






;;Construct a pair of expressions with higher-order functions, one using abs and the other identity (but otherwise identical,
;as above) which return different values.

(map identity (build-list 6 (lambda (n) (- n 6))) )
(map abs (build-list 6 (lambda (n) (- n 6))) )




;1d).  Explain the difference between
;;(foldr string-append "" (list "K" "a" "y" "a" "k"))
;;and
;;(foldl string-append "" (list "K" "a" "y" "a" "k"))

;foldr folds from the right, while foldl folds from the left. foldr would retun "Kayak" foldl would return "kayaK"



;;2.  Higher-Order Functions on Lists of Structs  (20 points)

;;The waters around Nomanisan Island teem with the highly prized Crab of Paradise.   Fishers of these waters mark their traps with buoys that float on the surface.  These buoys are identified by two colored rings unique to each licensed fishing boat.


;;Here are some data definitions:

(define-struct buoy (name top bottom license#))
;;Buoy is a (make-buoy String String String Natural)
;;interp: represents a crab buoy where
;;        name is the boat that set the trap
;;        top is the color of the upper ring as the buoy floats on the sea
;;        bottom is the color of the lower ring as the buoy floats on the sea
;;        license# is the unique license number of an individual crab trap

;;a ListOfBuoy is one of:
;;  -empty
;;  (cons Buoy ListOfBuoy)



;;Using filter and/or map, write a function satisfying the following signature/purpose:

;;licenses-top-bottom: ListOfBuoy String String -> ListOfNatural
;;consumes a list of buoys and a top-color and a bottom-color
;;returns a list of the license numbers of the buoys with those colors

(define BUOY1 (make-buoy "smith" "red" "green" 1))
(define BUOY2 (make-buoy "miller" "blue" "yellow" 2))
(define BUOY3 (make-buoy "miller" "blue" "yellow" 3))
(define BUOY4 (make-buoy "smith" "red" "green" 4))
(define BUOY5 (make-buoy "jones" "green" "red" 5))
(define BUOY6 (make-buoy "jones" "green" "red" 6))
(define BUOY7 (make-buoy "smith" "red" "green" 7))

(define All-Buoys (list BUOY1 BUOY2 BUOY3 BUOY4 BUOY5 BUOY6 BUOY7))

(check-expect (licenses-top-bottom empty "" "") empty)
(check-expect (licenses-top-bottom All-Buoys "red" "green") (list 1 4 7))
(check-expect (licenses-top-bottom All-Buoys "green" "red") (list 5 6))

(define (licenses-top-bottom a-lob top-color bottom-color)
  (local [(define (colors-equal? a-buoy)
            (and (string=? (buoy-top a-buoy) top-color)
                 (string=? (buoy-bottom a-buoy) bottom-color)))
          ]
    (map buoy-license# (filter colors-equal? a-lob))))
    
                             



;;3.  Accumulator-Style Programming  (20 points)

;;The waters around Nomanisan Island teem with the highly prized Crab of Paradise.   Fishers of these waters mark their traps with buoys that float on the surface.  These buoys are identified by two colored rings unique to each licensed fishing boat.


;;Here are some data definitions:

;(define-struct buoy (name top bottom license#))     ;;SAME AS ABOVE
;;Buoy is a (make-buoy String String String Natural)
;;interp: represents a crab buoy where
;;        name is the boat that set the trap
;;        top is the color of the upper ring as the buoy floats on the sea
;;        bottom is the color of the lower ring as the buoy floats on the sea
;;        license# is the unique license number of an individual crab trap
;;a ListOfBuoy is one of:
;;  -empty
;;  (cons Buoy ListOfBuoy)
;;Using accumulator-style recursion, write a function satisfying the following signature/purpose:

;;licenses-top-bottom-2: ListOfBuoy String String -> ListOfNatural
;;consumes a list of buoys and a top-color and a bottom-color
;;returns a list of the license numbers of the buoys with those colors
(check-expect (licenses-top-bottom-2 empty "" "") empty)
(check-expect (licenses-top-bottom-2 All-Buoys "red" "green") (list 1 4 7))
(check-expect (licenses-top-bottom-2 All-Buoys "green" "red") (list 5 6))

(define (licenses-top-bottom-2 a-lob top-color bottom-color)
  (local [
          (define (licenses-top-bottom-2--acc acc a-lob )
             (cond [(empty? a-lob) acc]
                   [(cons? a-lob) (if (colors-equal? (first a-lob))
                                      (licenses-top-bottom-2--acc (add-licence acc (first a-lob)) (rest a-lob))
                                      (licenses-top-bottom-2--acc acc (rest a-lob))
                                      )]))

           (define (colors-equal? a-buoy)
             (and (string=? (buoy-top a-buoy) top-color)
                  (string=? (buoy-bottom a-buoy) bottom-color)))
           
           (define (add-licence existing-list new-buoy)
             (append existing-list (list (buoy-license# new-buoy))))
           ]
    (licenses-top-bottom-2--acc empty a-lob )))
           




;4a.  Mutable Variables  (15 points)\\


;;Tourism on Nomanisan Island is a booming industry.  Parking meters have been installed in several areas to generate revenue and promote local businesses.  That means some people get\dots


(define-struct ticket (plate meter# fine))
;;Ticket is a (make-ticket String Natural Natural)
;;interp: represents a parking ticket where
;;        plate is the car's license plate
;;        meter# is the number of the meter where time expired
;;        fine is the dollar amount owed

;;a ListOfTicket is one of:
;;  -empty
;;  (cons Ticket ListOfTicket)

;;All the tickets issued on Nomanisan Island are contained in the list NITICKETS

(define NITICKETS (list (make-ticket "abc123" 1 50)
                        (make-ticket "123abc" 2 25)
                        (make-ticket "def456" 3 30)
                        (make-ticket "blurb"  3 10)
                        (make-ticket "MAINE"  1 20)))



;;;It was recently discovered that some parking meters have been malfunctioning, and out of fairness, the Grand Poobah of Nomanisan Island has decreed that tickets issued at such meters are null and, ahem, void.

;;Using set! write a function that satisfies the following signature/purpose:

;;remove-bad-meter:  Natural -> ListOfTicket
;;Consumes a meter number
;;deletes all tickets with given meter number from NITICKETS
;;EFFECT: Possibly removes some tickets from NITICKETS













;4b.  Mutable Variables  (15 points)

;(define-struct ticket (plate meter# fine))  ;;SAME AS ABOVE
;;Ticket is a (make-ticket String Natural Natural)
;;interp: represents a parking ticket where
;;        plate is the car's license plate
;;        meter# is the number of the meter where time expired
;;        fine is the dollar amount owed

;;a ListOfTicket is one of:
;;  -empty
;;  (cons Ticket ListOfTicket)

;;All the tickets issued on Nomanisan Island are contained in the list NITICKETS







;;In order to encourage some people to pay their parking tickets, the Grand Poobah of Nomanisan Island has ordered that all fines in excess of \$25 be reduced by \$10.


;;Write a function that satisfies the following signature/purpose:


;;discount: -> ListOfTicket
;;lowers all ticket fines over $25 by subtracting $10 
;;returns an error "No High Fines" if every fine is $25 or under
;;EFFECT: The fines of some tickets in NITICKETS may be lowered









;5a

(define-struct adult (surname age spouse))
;;Adult is a (make-adult String Natural Partner)
;;interp: represents an adult person where
;;        surname is the person's last name
;;        age is the person's age
;;        spouse is the person's partner (single/spouse

;;a Partner is one of:
;;  - single
;;  - Adult


;Jay-Z and Beyonce are a celebrity husband and wife power couple.  He was born ``Shawn Corey Carter'' in 1969; she was born ``Beyonce Giselle Knowles'' in 1981.


;;Write a sequence of expressions that correctly defines JAY-Z and BEYONCE as Adults in terms of each other.









;5b).  (5 BONUS Points) The 2004 Pulitzer Prize for Drama was awarded to Doug Wright for his one-person play ``I Am My Own Wife''.  It chronicles the life of German antiquarian Charlotte von Mahlsdorf, born Lothar Berfelde in 1928, who  survived the Nazi and Communist regimes in East Berlin as a transgender woman.


;;Write a sequence of expressions that correctly defines CHARLOTTE as an Adult in terms of her/himself, reflecting the title of the play, or explain why such a definition is impossible.


