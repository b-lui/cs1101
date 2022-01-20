;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Montana-G-Lui-B-hw2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Gustave Montana gmmontana
; Brandon Lui blui


;QUESTION 1

(define-struct hurricane (name category max-sustained-winds velocity heading))
; a Hurricane is a (make-hurricane String Natural Natural Natural String)
; interp: represents a hurricane where
; name is the hurricane's name
; category is the hurricane's category from 1-5 inclusive, 5 is largest
; max-sustained-winds is the hurricane's maximum sustained winds in miles per hour
; velocity is the hurricane's velocity in miles per hour
; heading is the hurricane's heading (ex. NNW)
(define HURRICANE-KAT (make-hurricane "Katrina" 5 175 200 "NNW"))

(define-struct thunderstorm (inches-rainfall max-wind-gust velocity heading))
; a Thunderstorm is a (make-thunderstorm Natural Natural Natural String)
; interp: represents a hurricane where
; inches-rainfall is the thunderstorm's maximum raindall in inches
; max-wind-gust is the thunderstorm's maximum wind gust in miles per hour
; velocity is the thunderstorm's velocity in miles per hour
; heading is the thunderstorm's heading (ex. NNW)
(define THUNDER-B (make-thunderstorm 4 50 55 "W"))

(define-struct fire (sq-miles days ppl-displaced))
; a Fire is a (make-thunderstorm Natural Natural Natural)
; interp: represents a fire where
; sq-miles is the fire's coverage in square miles
; days is the number of days the fire has been raging 
; ppl-displaced is the number of people the fire has displaced
(define FIRE-EX0 (make-fire 100 14 10000))
(define FIRE-EX1 (make-fire 20 2 100))

       
;a Storm is one of 
;- Hurricane
;- Thunderstorm
;- Fire
;interp: Storm represents an itemization of data definitions of storms
(define STORM-EX0 (make-fire 2 1 2))
(define STORM-EX1 (make-hurricane "Katrina" 5 175 200 "NNW"))
(define STORM-EX2 (make-thunderstorm 4 50 55 "W"))

;QUESTION 2
; hurricane-fcn: Hurricane -> 
; 
#; (define (hurricane-fcn a-hurricane ...) ;template
     (... (hurricane-name a-hurricane) 
          (hurricane-category a-hurricane) 
          (hurricane-max-sustained-winds a-hurricane) 
          (hurricane-velocity a-hurricane) 
          (hurricane-heading a-hurricane) ))

; tunderstorm-fcn: Thunderstorm ->
; 
#; (define (tunderstorm-fcn a-thunderstorm ...) ;template
     (... (thunderstorm-inches-rainfall a-thunderstorm) 
          (thunderstorm-max-wind-gust a-thunderstorm) 
          (thunderstorm-velocity a-thunderstorm) 
          (thunderstorm-heading a-thunderstorm) ))

; fire-fcn: Fire ->
; 
#; (define (fire-fcn a-fire ...) ;template
     (... (fire-sq-miles a-fire)
          (fire-days a-fire)
          (fire-ppl-displaced a-fire) ))

; storm-fcn: Storm ->
; 
#;(define (storm-fcn a-storm ...) ;template
  (cond [(hurricane? a-storm) (... (hurricane-category a-storm))]
        [(thunderstorm? a-storm) (... (thunderstorm-inches-rainfall a-storm))]
        [(fire? a-storm) (... (fire-days a-storm))]
        [else (...)]))
;QUESTION 3
;high-impact?: Storm -> Boolean
; consumes a storm, produces true if hurricane is category 4 or 5, if thunderstorm is > 3 in rain and >60mph, or if fire covers > 50 sq miles
(check-expect (high-impact? HURRICANE-KAT) true)
(check-expect (high-impact? (make-hurricane "Example" 4 175 200 "NNW")) true)
(check-expect (high-impact? (make-hurricane "Example" 5 175 200 "NNW")) true)
(check-expect (high-impact? (make-hurricane "Example" 1 175 200 "NNW")) false)
(check-expect (high-impact? (make-hurricane "Example" 3 175 200 "NNW")) false)
(check-expect (high-impact? (make-thunderstorm 4 50 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 4 60 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 3 70 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 3 50 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 4 60 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 3 60 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 5 60 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 5 65 55 "N")) true)
(check-expect (high-impact? (make-thunderstorm 4 61 55 "W")) true)
(check-expect (high-impact? (make-thunderstorm 4 80 55 "W")) true)
(check-expect (high-impact? (make-fire 100 14 10000)) true)
(check-expect (high-impact? (make-fire 51 14 10000)) true)
(check-expect (high-impact? (make-fire 50 14 10000)) false)
(check-expect (high-impact? (make-fire 40 14 10000)) false)
(check-expect (high-impact? (make-fire 30 14 10000)) false)
(check-expect (high-impact? 4) false)
(check-expect (high-impact? "a-string") false)
(check-expect (high-impact? "lol") false)
;(define (high-impact? a-storm) true) ;stub

(define (high-impact? a-storm) 
  (cond [(hurricane? a-storm) (>= (hurricane-category a-storm) 4)]
        [(thunderstorm? a-storm) (and (> (thunderstorm-inches-rainfall a-storm) 3) (> (thunderstorm-max-wind-gust a-storm) 60))]
        [(fire? a-storm) (> (fire-sq-miles a-storm) 50)]
        [else #false]))

;QUESTION 4
; change-heading: Storm Heading -> Storm
; consumes an existing Storm and new Heading and produces a new Storm with the new Heading, everything else unchanged
(check-expect (change-heading (make-hurricane "Example" 4 175 200 "NNW") "N") (make-hurricane "Example" 4 175 200 "N") )
(check-expect (change-heading (make-thunderstorm 4 50 55 "W") "N") (make-thunderstorm 4 50 55 "N") )
(check-expect (change-heading (make-fire 40 14 10000) "N") (make-fire 40 14 10000) )
(check-expect (change-heading "NotAStorm" "Random" ) "Error: Not a Storm")
;(define (change-heading a-storm a-heading) HURRICANE-KAT) ;stub

(define (change-heading a-storm a-heading) 
  (cond [(hurricane? a-storm) (make-hurricane (hurricane-name a-storm) (hurricane-category a-storm) (hurricane-max-sustained-winds a-storm) (hurricane-velocity a-storm) a-heading)]
        [(thunderstorm? a-storm) (make-thunderstorm (thunderstorm-inches-rainfall a-storm) (thunderstorm-max-wind-gust a-storm) (thunderstorm-velocity a-storm) a-heading)]
        [(fire? a-storm) a-storm]
        [else "Error: Not a Storm"]))

;QUESTION 5
;; a ListOfString is one of
;; - empty
;; - (cons String ListOfString)
;; interp:  ListOfString represents a list of strings

;character-count: ListOfString -> Natural
; consumes a ListOfString, produces the total amount of characters in each String combined 
(define S-LISTTEST (cons "String1" (cons "string2" empty)))
(check-expect (character-count S-LISTTEST) 14)
(check-expect (character-count (cons "String" (cons "string" empty)))12)
(check-expect (character-count (cons "String"(cons "String" (cons "string" empty))))18)
 (check-expect (character-count (cons "11"(cons "1" (cons "1" empty))))4)
(check-expect (character-count (cons "11" (cons "aaa" empty)))5)
(check-expect (character-count (cons "dafsjnajnfew"(cons "1ei" (cons "aj3ksnfoqne" empty))))26)
 (check-expect (character-count (cons "11"(cons "1" (cons "1" empty))))4)
 (check-expect (character-count (cons "11"(cons "11"(cons "11"(cons "11"(cons "11"(cons "1" (cons "1" empty))))))))12)
(check-expect (character-count (cons "1" empty))1) 
  (check-expect (character-count empty)0)
 (check-expect (character-count (cons "" empty))0)
 (check-expect (character-count (cons ""(cons "" empty)))0)
;(define (character-count a-los) 0) ;stub

(define (character-count a-los)
  (cond [(empty? a-los) 0]
        [(cons? a-los) ( + (string-length (first a-los))
                           (character-count (rest a-los)))]))

;QUESTION 6
;numeric-strings: ListOfString -> ListOfString
; consumes a ListOfString, produces the same ListOfString with only the strings of the orginal list that consist of only numeric characters
(check-expect (numeric-strings empty) empty)
(check-expect (numeric-strings (cons "String" (cons "string" empty)))empty)
(check-expect (numeric-strings (cons "String"(cons "String" (cons "string" empty))))empty)
(check-expect (numeric-strings (cons "11" (cons "string" empty)))(cons "11" empty))
(check-expect (numeric-strings (cons "String"(cons "2910" (cons "string" empty))))(cons "2910" empty))
(check-expect (numeric-strings (cons "1920"(cons "2910" (cons "string" empty))))(cons "1920"(cons "2910" empty)))
;(define (numeric-strings a-los) empty) ;stub

(define (numeric-strings a-los)
  (cond [(empty? a-los) empty]
        [(cons? a-los) (if (not (boolean? (string->number (first a-los)))) 
                           (cons (first a-los) (numeric-strings (rest a-los)))
                           (numeric-strings (rest a-los)))]))

;QUESTION 7
; a ListOfNatural is one of
; - empty
; - (cons Natural ListOfNatural)
;interp:  ListOfNatural represents a list of Natural numbers 

;lengths-of-strings: ListOfString -> ListOfNatural
; consumes a ListOfString, produces a ListOfNatural of the length of the respective strings in the original list
(check-expect (lengths-of-strings empty) empty)
(check-expect (lengths-of-strings (cons "String" (cons "string" empty)))(cons 6 (cons 6 empty)))
(check-expect (lengths-of-strings (cons "String"(cons "String" (cons "string" empty))))(cons 6 (cons 6 (cons 6 empty))))
(check-expect (lengths-of-strings (cons "103"(cons "3" (cons "ak1" empty))))(cons 3 (cons 1 (cons 3 empty))))
(check-expect (lengths-of-strings (cons "10dm1i"(cons "dfkmg4g" (cons "fdk3fo3mf-" empty))))(cons 6 (cons 7 (cons 10 empty))))
;(define (lengths-of-strings a-los) empty);stub

(define (lengths-of-strings a-los)
  (cond [(empty? a-los) empty]
        [(cons? a-los) (cons (string-length (first a-los))
                             (lengths-of-strings (rest a-los)))]))

