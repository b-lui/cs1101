;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname csexam1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;1d
(define COLORS "Crimson & Gray")
(define (change-order-q1 a-string)
 (string-append (substring a-string 10 (string-length a-string)) (substring a-string 7 10) (substring a-string 0 7) ))

(change-order-q1 COLORS)

;1e
  (define EXAM1 (cons 3 (cons 2 (cons 1 empty))))

(first (rest EXAM1))

;QUESTION 3
;;qualified?: String Natural Boolean -> Boolean
;;determine whether an American citizen is  
;;eligible to hold a federal office
;;
;;consumes a string representing the office sought: "House", "Senate", or "Prez"
;;and a number representing the citizen's age (in years) 
;;and a boolean which is true only for natural-born citizens
;;
;;Here's a function definition for qualified? :
(check-expect (qualified? "House" 25 true)true) ;equal age natural
(check-expect (qualified? "House" 24 true)false); below age natural
(check-expect (qualified? "House" 26 true)true); above age nautral
(check-expect (qualified? "House" 25 false)true); equal age not nat
(check-expect (qualified? "House" 24 false)false); below age not nat
(check-expect (qualified? "House" 26 false)true); above age not nat
(check-expect (qualified? "Senate" 30 true)true);equal age natural
(check-expect (qualified? "Senate" 29 true)false); below age natural
(check-expect (qualified? "Senate" 31 true)true); above age natural
(check-expect (qualified? "Senate" 30 false)true); equal age not nat
(check-expect (qualified? "Senate" 29 false)false); below age not nat
(check-expect (qualified? "Senate" 31 false)true); above age not nat
(check-expect (qualified? "Prez" 35 true)true); equal age natural
(check-expect (qualified? "Prez" 34 true)false); below age nautral
(check-expect (qualified? "Prez" 36 true)true); above age natural
(check-expect (qualified? "Prez" 35 false)false); equal age not natural
(check-expect (qualified? "Prez" 34 false)false); below age not natural
(check-expect (qualified? "Prez" 36 false)false); above age not natural

(check-expect (qualified? "Prez" 0 false)false); zero age not natural
(check-expect (qualified? "Senate" 0 false)false); zero age not natural
(check-expect (qualified? "House" 0 false)false); zero age not natural

(check-expect (qualified? "Prez" 0 false)false); zero age natural
(check-expect (qualified? "Senate" 0 false)false); zero age natural
(check-expect (qualified? "House" 0 false)false); zero age natural

(define (qualified? office age natural?)
  (or (and (string=? "House"  office) (>= age 25))
      (and (string=? "Senate" office) (>= age 30))
      (and (string=? "Prez"   office) (>= age 35) natural?)))


;QUESTION 4
(define-struct scubashow (guests time))
;;a Scubashow is a (make-scubashow Natural String)
;;interp:  represents a scubashow where
;;         guests is the number of paying customers on the ‘‘CrabClaw’’
;;         time represents time of day: "morning" or "afternoon"
(define-struct schooner (price passengers))
;;a Schooner is a (make-schooner Natural Natural)
;;interp:  represents a schooner where
;;         price is the dollar amount each passenger pays to sail the ‘‘Maggie Mae’’
;;         passengers represents the number of passengers aboard
(define-struct whalewatch (price tickets breach?))
;;a Whalewatch is a (make-whalewatch Natural Natural Boolean)
;;interp:  represents a whalewatch where
;;         price is the cost (in dollars) for a visitor to set out on the ‘‘Orcanada’’
;;         tickets is the number of tickets sold for a whalewatch
;;         breach? is true if the patrons get to see at least one whale

;4a
; a Adventure is one of 
;- Scubashow
;- Schooner
;- Whalewatch
; interp: defines an itemization of Adventure as a Scubashow, Schooner, Whalewatch

;4b
;make-whalewatch: Natural Natural Boolean -> Whalewatch
; consumes a price (Natural) in dollars, amount of tickets (Tickets) and if patrons get to see at least one whale (breach?) produces a Whalewatch

;4c
(define SCUBA-EX (make-scubashow 30 "morning"))

;4d
;function definition
;
;;captains-catch: Adventure -> Natural
;;consumes an adventure on the waters around Nomanisan Island
;;produces the total dollar amount customers paid for the recreation

(check-expect (captains-catch (make-scubashow 30 "morning"))25)
(check-expect (captains-catch (make-scubashow 30 "afternoon"))40)
(check-expect (captains-catch (make-scubashow 19 "morning"))25)
(check-expect (captains-catch (make-scubashow 19 "afternoon"))40)
(check-expect (captains-catch (make-scubashow 0 "afternoon"))40)
(check-expect (captains-catch (make-schooner 30 30)) 30)
(check-expect (captains-catch (make-schooner 35 30)) 35)
(check-expect (captains-catch (make-schooner 25 30)) 25)
(check-expect (captains-catch (make-schooner 30 31)) 30)
(check-expect (captains-catch (make-schooner 35 31)) 35)
(check-expect (captains-catch (make-schooner 25 31)) 25)
(check-expect (captains-catch (make-schooner 0 31)) 0)
(check-expect (captains-catch (make-whalewatch 30 30 true)) 30)
(check-expect (captains-catch (make-whalewatch 40 30 true)) 40)
(check-expect (captains-catch (make-whalewatch 50 35 true)) 50)
(check-expect (captains-catch (make-whalewatch 30 30 false)) 15)
(check-expect (captains-catch (make-whalewatch 40 30 false)) 20)
(check-expect (captains-catch (make-whalewatch 50 35 false)) 25)
(check-expect (captains-catch (make-whalewatch 0 35 false)) 0)
(check-expect (captains-catch (make-whalewatch 0 35 true)) 0)
;(define (captains-catch a-adventure) 0) ;stub


       (define (captains-catch a-adventure)
  (cond
    [(scubashow? a-adventure) (if (string=? (scubashow-time a-adventure) "morning") 25 40)]
    [(schooner? a-adventure)  (schooner-price a-adventure)]
    [(whalewatch? a-adventure) (if (whalewatch-breach? a-adventure) (whalewatch-price a-adventure) (/ (whalewatch-price a-adventure) 2) )]))

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

(check-expect (course-just-number "CS1101") "1101")
(check-expect (course-just-number "MA1029") "1029")
(check-expect (course-just-number "MA1012") "1012")
(check-expect (course-just-number "EN2912") "2912")
(check-expect (course-just-number "") "")
(check-expect (course-just-number "QIAJ") "AJ")
(check-expect (course-just-number "AM1") "1")
(check-expect (course-just-number "1111") "11")
(check-expect (course-just-number "QIAJ") "AJ")
(check-expect (course-just-number "AI") "")
(check-expect (course-just-number "RUAJNRWI") "AJNRWI")
(check-expect (course-just-number "PIRWEFNLJV") "RWEFNLJV")
(check-expect (course-just-number "I") "")
;(define (course-just-numnber a-stirng) "");stub

(define (course-just-number a-stirng)
  (if
    (> (string-length a-stirng) 2) (substring a-stirng 2 (string-length a-stirng )) ""))

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
(check-expect (keep-just-nums (cons "CS1101" (cons "ID2050" (cons "MA1021" empty))))(cons "1101" (cons "2050" (cons "1021" empty))))
(check-expect (keep-just-nums (cons "" empty))  (cons "" empty))
(check-expect (keep-just-nums (cons "CS1101" empty)) (cons "1101" empty))
(check-expect (keep-just-nums (cons "EN1931" (cons "MA1029" empty))) (cons "1931" (cons "1029" empty)))
(check-expect (keep-just-nums (cons "UQ1039" (cons "YN0119" (cons "MA1093" empty)))) (cons "1039" (cons "0119" (cons "1093" empty))))
(check-expect (keep-just-nums empty)  empty)
;(define (keep-just-nums a-los) empty);stub
 (define (keep-just-nums a-los)
   (cond [(empty? a-los) empty]
         [(cons? a-los)   (cons (course-just-number (first a-los))
                              (keep-just-nums (rest a-los)))]))