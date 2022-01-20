;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Lui-B-Lab2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Brandon Lui blui

;QUESTION 1 and 2

(define-struct hurricane (name category max-sustained-winds velocity heading))
; A Hurricane is a (make-hurricane String Natural Natural Natural String)
; interp: represents a hurricane where
; name is the hurricane's name
; category is the hurricane's category from 1-5 inclusive, 5 is largest
; max-sustained-winds is the hurricane's maximum sustained winds in miles per hour
; velocity is the hurricane's velocity in miles per hour
; heading is the hurricane's heading (ex. NNW)
(define HURRICANE-KAT (make-hurricane "Katrina" 5 175 200 "NNW"))

(define-struct thunderstorm (inches-rainfall max-wind-gust velocity heading))
; A Thunderstorm is a (make-thunderstorm Natural Natural Natural String)
; interp: represents a hurricane where
; inches-rainfall is the thunderstorm's maximum raindall in inches
; max-wind-gust is the thunderstorm's maximum wind gust in miles per hour
; velocity is the thunderstorm's velocity in miles per hour
; heading is the thunderstorm's heading (ex. NNW)
(define THUNDER-B (make-thunderstorm 4 50 55 "W"))

(define-struct fire (sq-miles days ppl-displaced))
; A Fire is a (make-thunderstorm Natural Natural Natural)
; interp: represents a fire where
; sq-miles is the fire's coverage in square miles
; days is the number of days the fire has been raging 
; ppl-displaced is the number of people the fire has displaced
(define FIRE-1 (make-fire 100 14 10000))

       
;a Storm is one of 
;- Hurricane
;- Thunderstorm
;- Fire
;interp: Storm represents an itemization of data definitions of storms
(define STORM-EX (make-fire 2 1 2))

;QUESTION 2
#; (define (hurricane-fcn a-hurricane ...) ;template
     (... (hurricane-name a-hurricane) 
          (hurricane-category a-hurricane) 
          (hurricane-max-sustained-winds a-hurricane) 
          (hurricane-velocity a-hurricane) 
          (hurricane-heading a-hurricane) ))

#; (define (tunderstorm-fcn a-thunderstorm ...) ;template
     (... (thunderstorm-inches-rainfall a-thunderstorm) 
          (thunderstorm-max-wind-gust a-thunderstorm) 
          (thunderstorm-velocity a-thunderstorm) 
          (thunderstorm-heading a-thunderstorm) ))

#; (define (fire-fcn a-fire ...) ;template
     (... (fire-sq-miles a-fire)
          (fire-days a-fire)
          (fire-ppl-displaced a-fire) ))

#;(define (storm-fcn a-storm ...) ;template
  (cond [(hurricane? a-storm) (... (hurricane-category a-storm))]
        [(thunderstorm? a-storm) (... (thunderstorm-inches-rainfall a-storm))]
        [(fire? a-storm) (... (fire-days a-storm))]
        [else ...]))
;QUESTION 3
;high-impact?: Storm -> Boolean
; consumes a storm, produces true if hurricane is category 4 or 5, if thunderstorm is > 3 in rain and >60mph, or if fire covers > 50 sq miles
(check-expect (high-impact? HURRICANE-KAT) true)
(check-expect (high-impact? (make-hurricane "Example" 4 175 200 "NNW")) true)
(check-expect (high-impact? (make-hurricane "Example" 1 175 200 "NNW")) false)
(check-expect (high-impact? (make-thunderstorm 4 50 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 4 60 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 3 70 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 3 50 55 "W")) false)
(check-expect (high-impact? (make-thunderstorm 4 61 55 "W")) true)
(check-expect (high-impact? (make-thunderstorm 4 80 55 "W")) true)
(check-expect (high-impact? (make-fire 100 14 10000)) true)
(check-expect (high-impact? (make-fire 50 14 10000)) false)
(check-expect (high-impact? (make-fire 40 14 10000)) false)
(check-expect (high-impact? 4) false)
(check-expect (high-impact? "a-string") false)
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
(check-expect (change-heading "NotAStorm" "Random" ) "Not a Storm")
;(define (change-heading a-storm a-heading) HURRICANE-KAT) ;stub

(define (change-heading a-storm a-heading) 
  (cond [(hurricane? a-storm) (make-hurricane (hurricane-name a-storm) (hurricane-category a-storm) (hurricane-max-sustained-winds a-storm) (hurricane-velocity a-storm) a-heading)]
        [(thunderstorm? a-storm) (make-thunderstorm (thunderstorm-inches-rainfall a-storm) (thunderstorm-max-wind-gust a-storm) (thunderstorm-velocity a-storm) a-heading)]
        [(fire? a-storm) a-storm]
        [else "Not a Storm"]))

;QUESTION 5
;; a ListOfString is one of
;; - empty
;; - (cons String ListOfString)
;; interp:  ListOfString represents a list of strings
(define S-LISTTEST (cons "String" (cons "string2" empty)))


