;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exam2reviewA21-Blui) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;Exam 2 Review A2021

;QUESTION 1

(define-struct vacation (company duration cost ?guided))
;;an Vacation is a (make-vacation String Natural Natural Boolean))
;;company is the name of the travel agency/website booking the package
;;duration is the length of stay (in days) for the vacation package 
;;cost is the dollar value of the package
;;?guided is true iff the vacation package includes a guided tour of Nomanisan Island

;;A ListOfVacations is one of:
;;  - empty
;;  (cons Vacation ListOfVacations)

;;cheap&guided: Natural ListOfVacations -> ListOfVacations
;;consumes a dollar amount and ListOfVacations, returns a list of all vacation packages WITH
;;guided tours of Nomanisan Island that cost less than the entered amount
(check-expect (cheap&guided 500 empty)
              empty)
(check-expect (cheap&guided 500 (list (make-vacation "Com" 2 400 true)))
              (list (make-vacation "Com" 2 400 true)))
(check-expect (cheap&guided 500 (list (make-vacation "Com" 2 500 true)))
              empty)
(check-expect (cheap&guided 500 (list (make-vacation "Com" 2 400 false)))
              empty)
(check-expect (cheap&guided 500 (list (make-vacation "Com" 2 400 true)
                                      (make-vacation "Com" 2 500 true)
                                      (make-vacation "Com" 2 400 false)
                                      (make-vacation "Com2" 2 400 true)
                                      (make-vacation "Com" 2 300 false)))
              (list (make-vacation "Com" 2 400 true)
                    (make-vacation "Com2" 2 400 true)))
;(define (cheap&guided nat a-lov) empty);stub

(define (cheap&guided nat a-lov)
  (cond [(empty? a-lov) empty]
        [(cons? a-lov) (if (cheap&guided--true? nat (first a-lov))
                           (cons (first a-lov) (cheap&guided nat (rest a-lov)))
                           (cheap&guided nat (rest a-lov)))]))
                                     
;cheap&guided--true?: Natural Vacation -> Boolean
;consumes a dollar amount and vacation, returns true if Vacation is a
;guided tours of Nomanisan Island and cost less than the entered amount
(define (cheap&guided--true? nat a-vacation)
  (and (< (vacation-cost a-vacation) nat) (vacation-?guided a-vacation)))

;QUESTION 2
;Assume these constants are defined in the DrRacket definitions pane.
(define WPI-COLORS (cons "crimson" (cons "gray" empty)))
(define WOO-TOWN (list "worm" "heart" "7hills"))
(define MASCOT "Gompei")
#|
a).  Create:  (What expression will produce the following?)
1).(list "crimson" "gray" "Gompei")
2).(list "crimson" "gray" "7hills")
3).(list "Gompei" "heart")

b).  Evaluate:  (What will these expression produce in the interactive pane?)
1).(append MASCOT WOO-TOWN)
2).(list (first WPI-COLORS) (first WOO-TOWN))
3).(append WPI-COLORS WOO-TOWN WPI-COLORS) |#

;(append WPI-COLORS (cons MASCOT empty))
;(append WPI-COLORS (list (first (rest (rest WOO-TOWN)))))
;(list  MASCOT (first (rest WOO-TOWN)))

;QUESTION 3
(define-struct wishes3 (name metal djinn1 djinn2 djinn3))
;;A Wishes3 is a (make-wishes3 String String Genie Genie Genie)
;;name is the name of the Genie granting wishes
;;metal is the material of the lamp from which the Genie emerged
;;djinn1 is the first  wish
;;djinn2 is the second wish
;;djinn3 is the third  wish

;;A Genie is one of:
;;  - String    (a granted wish)
;;  - Wishes3   (a new genie to grant three more wishes)

(define SMOKEY (make-wishes3 "Smokey" "silver" "car" "goat" "goat"))
(define ROBIN  (make-wishes3 "Robin"  "gold"   "love" "happiness" SMOKEY))
(define WILLS  (make-wishes3 "WillS"  "copper" "hit movie" ROBIN "success"))
(define GENE.E (make-wishes3 "Gene E." "platinum" WILLS "house" "vacation"))

;;create a template for functions on Genies
#;(define (fn-for-genie a-genie)
    (cond [(string? a-genie) (...)]
          [(wishes3? a-genie) (... (wishes3-name a-genie)
                                   (wishes3-metal a-genie)
                                   (fn-for-genie (wishes3-djinn1 a-genie))
                                   (fn-for-genie (wishes3-djinn2 a-genie))
                                   (fn-for-genie (wishes3-djinn3 a-genie)))]))

(define G1 (make-wishes3 "Ali Baba" "gold" "Maserati" "lobster" "Bahama"))
(define G2 (make-wishes3 "Solomon" "silver" "Ferrari" "Ferrari" "Ferrari"))
(define G3 (make-wishes3 "Bob" "copper" "Astin Martin"  "Ferrari" "moon of Mars"))
(define G4 (make-wishes3 "Sam" "gold" G1 G2 G3))
(define G5 (make-wishes3 "Bill" "tin" "VW" "salad" G4))

;;sum-wishes: Genie -> Natural
;;find total number of wishes granted
(check-expect (sum-wishes G1) 3)
(check-expect (sum-wishes G2) 3)
(check-expect (sum-wishes G4) 9)
(check-expect (sum-wishes G5) 11)
;(define (sum-wishes a-genie) 0);stub
(define (sum-wishes a-genie)
  (cond [(string? a-genie) 1]
        [(wishes3? a-genie) ( +
                              (sum-wishes (wishes3-djinn1 a-genie))
                              (sum-wishes (wishes3-djinn2 a-genie))
                              (sum-wishes (wishes3-djinn3 a-genie)))]))

;;any-copper-genie?: Genie -> Boolean
; consumes a genie , produces true if there is a copper genie and false otherwise
(check-expect (any-copper-genie? G1) false)
(check-expect (any-copper-genie? G2) false)
(check-expect (any-copper-genie? G3) true)
(check-expect (any-copper-genie? G4) true)
(check-expect (any-copper-genie? G5) true)
;(define (any-copper-genie? a-genie) true);stb

(define (any-copper-genie? a-genie)
  (cond [(string? a-genie) false]
        [(wishes3? a-genie) 
         (or (string=? (wishes3-metal a-genie) "copper")
             (any-copper-genie? (wishes3-djinn1 a-genie))
             (any-copper-genie? (wishes3-djinn2 a-genie))
             (any-copper-genie? (wishes3-djinn3 a-genie)))]))

;;silver-genie: Genie -> String
;;returns the name of a Genie from a silver lamp
(check-expect (silver-genie G1) false)
(check-expect (silver-genie G2) "Solomon")
(check-expect (silver-genie G4) "Solomon")
(check-expect (silver-genie G5) "Solomon")
(check-expect (silver-genie (make-wishes3 "Ali Baba" "gold" (make-wishes3 "Ali Baba" "silver" "Maserati" "lobster" "Bahama") "lobster" "Bahama")) "Ali Baba")
;(define (silver-genie a-genie) "");stub

(define (silver-genie a-genie)
  (cond [(string? a-genie) false]
        [(wishes3? a-genie) (if 
                             (string=? (wishes3-metal a-genie) "silver")
                             (wishes3-name a-genie)
                             (local [(define DJINN1-TRY (silver-genie (wishes3-djinn1 a-genie)))
                                     (define DJINN2-TRY (silver-genie (wishes3-djinn2 a-genie)))
                                     (define DJINN3-TRY (silver-genie (wishes3-djinn3 a-genie)))]
                             (cond
                               [(not (false? DJINN1-TRY)) DJINN1-TRY]
                               [(not (false? DJINN2-TRY)) DJINN2-TRY]
                               [(not (false? DJINN3-TRY)) DJINN3-TRY]
                               [else false])))]
                            ))

;;edit-wish: Genie String String -> Genie
;;consumes a genie and two strings, change first wish into second



