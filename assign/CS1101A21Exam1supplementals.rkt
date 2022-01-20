;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname CS1101A21Exam1supplementals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;EXAM I  Supplemental Permitted Materials



; HtDP RECIPE:
; 1. Signature, Purpose, Stub
; 2. Examples (wrapped in check-expect)
; 3. Inventory - Template & Constants
; 4. Code Body
; 5. Test and Debug


;;Template:
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
;

;Question 1:

(define EXAM1 (cons 3 (cons 2 (cons 1 empty))))

;Question 2:

;;cross-multiply: Integer Integer -> Integer
;;consumes two integers and produces the square of their sum

(define (cross-multiply n m)
  (+ (sqr n) (* 2 n m) (sqr m)))
      

;;square?: Integer -> Boolean
;;consumes an integer and produces true iff it is a square

(define (square? num)
  (integer? (sqrt num)))
(square? (cross-multiply 5 1))

;Question 3:

;;qualified?: String Natural Boolean -> Boolean
;;determine whether an American citizen is  
;;eligible to hold a federal office
;;
;;consumes a string representing the office sought: "House", "Senate", or "Prez"
;;and a number representing the citizen's age (in years) 
;;and a boolean which is true only for natural-born citizens
;;
;;Here's a function definition for qualified? :

(define (qualified? office age natural?)
  (or (and (string=? "House"  office) (>= age 25))
      (and (string=? "Senate" office) (>= age 30))
      (and (string=? "Prez"   office) (>= age 35) natural?)))


;Question 4:

(define-struct scubashow (guests time))
;;a Scubashow is a (make-scubashow Natural String)
;;interp:  represents a scubashow where
;;         guests is the number of paying customers for Diver Ned
;;         time represents time of day: "morning" or "afternoon"

(define-struct schooner (price passengers))
;;a Schooner is a (make-schooner Natural Natural)
;;interp:  represents a schooner where
;;         price is the dollar amount each passenger pays to sail
;;         passengers represents the number of passengers aboard

(define-struct whalewatch (price tickets breach?))
;;a Whalewatch is a (make-whalewatch String Natural Boolean)
;;interp:  represents a whalewatch where
;;         price is the tunnel's name
;;         time represents the normal expected time of travel in minutes
;;         breach? is true if the patrons get to see at least one whale 


;4a
;Data Definition for an Adventure


;4b
;Signature and purpose for the constructor for a Whalewatch


;4c
;Using define, create an example of a Scubashow


;4d
;function definition
;
;;captains-catch: Adventure -> Natural
;;consumes an adventure on the waters around Nomanisan Island
;;produces the total dollar amount customers paid for the recreation


;Question 5:

;5a
;We often talk about courses by their numbers without their department-signifying
;first two letters.  We call CS1101 just 1101.
;
;
;Write a function that satifies the following signature and purpose:
;
;;course-just-number: String -> String
;;consumes a string and returns the string with the first two letters removed
;;
;;Example:  (course-just-number "CS1101") -> "1101"



;5b
;;A ListOfString is one of
;;  empty
;;  (cons String ListOfString)

;Write a function with the following signature and purpose.  Your function keep-cs-words must call the function course-just-number defined above (5a) as a helper function.


;;keep-just-nums: ListOfString -> ListOfString
;;consumes a list of strings representing courses of the form "XX####" and returns a
;;list with just the number parts (as strings).
;;
;;Example: (keep-just-nums (cons "CS1101" (cons "ID2050" (cons "MA1021" empty)))
;;returns (cons "1101" (cons "2050" (cons "1021" empty)))
