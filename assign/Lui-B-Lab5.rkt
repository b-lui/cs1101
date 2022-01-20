;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Lui-B-Lab5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;Brandon Lui blui

; Lab 5
;PART 1
;QUESTION 1

(define-struct river (name pH do tributaries))
; a River is a (make-river String Natural Natural ListOfRiver)
; INTERP: represents a river where
;         name is the name of the river
;         pH is the the pH of the water from 0-14 inclusive
;         do is the Dissolved Oxygen in mg/L (ppm) of the water
;         tributaries are the list of the  (rivers) that feed into the river as a ListOfRiver

; a ListOfRiver is one of
; - empty
; - (cons River ListOfRiver)
; INTERP: represents a list of rivers

;QUESTION 2

(define RIVER-EX (make-river "Hello" 7.0 10 (list (make-river "Sup" 7.01 12.9 empty)
                                                  (make-river "North River" 8.0 11 (list  (make-river "Mimm" 9.1 12.1 
                                                                                                      (list  (make-river "River into river" 8.4 11.1 empty)))
                                                                                          (make-river "HAHAHA" 5.19 12.01 empty)
                                                                                          (make-river "SOO MANY rivers" 5.0 12.88 empty)
                                                                                          (make-river "AcID RiVEr" 1.1 0.5 empty)))
                                                  (make-river "Sourth River" 6.2 20 empty)
                                                  (make-river "Our River" 7.1 18.0 empty)
                                                  (make-river "Haha River" 6.9 17.2 empty)
                                                  )))

;QUESTION 3
; River Template
; river-fcn: River -> ???
; ...
#; (define (river-fcn a-river)
     (... (river-name a-river) ;String
          (river-pH a-river)  ;Natural
          (river-do a-river)  ;Natural
          (list-of-river-fcn (river-tributaries a-river))))  

; ListOfRiver Template
; list-of-river-fcn: ListOfRiver -> ???
; ...
#; (define (list-of-river-fcn a-lor)
     (cond
       [(empty? a-lor) (...)]
       [(cons? a-lor) (...
                       (river-fcn (first a-lor)) 
                       (list-of-river-fcn (rest a-lor)))]))

;QUESTION 4
;list-acidic-rivers: River -> ListOfString
; consumes a river system and produces a ListOfString of all rivers under pH 6.5
(check-expect (list-acidic-rivers (make-river "Sup" 7.01 12.9 empty)) empty)
(check-expect (list-acidic-rivers (make-river "Sup" 6.5 12.9 empty)) empty)
(check-expect (list-acidic-rivers (make-river "Sup" 6.45 12.9 empty)) (list "Sup"))
(check-expect (list-acidic-rivers (make-river "Sup" 6.45 12.9 (list (make-river "Sup" 6.45 12.9 empty))) )(list "Sup" "Sup"))
(check-expect (list-acidic-rivers RIVER-EX) (list "HAHAHA" "SOO MANY rivers" "AcID RiVEr" "Sourth River"))
(check-expect (list-acidic-rivers--lor empty) empty)
(check-expect (list-acidic-rivers--lor (list (make-river "Sup" 7.01 12.9 empty)
                                             (make-river "North River" 8.0 11 (list  (make-river "Mimm" 9.1 12.1 
                                                                                                 (list  (make-river "River into river" 8.4 11.1 empty)))
                                                                                     (make-river "HAHAHA" 5.19 12.01 empty)
                                                                                     (make-river "SOO MANY rivers" 5.0 12.88 empty)
                                                                                     (make-river "AcID RiVEr" 1.1 0.5 empty)))
                                             (make-river "Sourth River" 6.2 20 empty)
                                             (make-river "Our River" 7.1 18.0 empty)
                                             (make-river "Haha River" 6.9 17.2 empty)
                                             )) (list "HAHAHA" "SOO MANY rivers" "AcID RiVEr" "Sourth River"))
;(define (list-acidic-rivers a-river) empty);stub


(define (list-acidic-rivers a-river)
  (if (<   (river-pH a-river) 6.5) ;Natural
      (cons (river-name a-river) (list-acidic-rivers--lor (river-tributaries a-river)))
      (list-acidic-rivers--lor (river-tributaries a-river))))  

; list-acidic-rivers--lor: ListOfRiver -> ListOfString
; consumes a ListOfRiver,  produces a ListOfString of all rivers under pH 6.5
(define (list-acidic-rivers--lor a-lor)
  (cond
    [(empty? a-lor) empty]
    [(cons? a-lor) (append
                    (list-acidic-rivers (first a-lor)) 
                    (list-acidic-rivers--lor (rest a-lor)))]))
;QUESTION 5
; unhealthy?: River -> Boolean
; consumes river , produces true if any river has a pH below 6.5 or over 8.5 or a DO under 6ppm
(check-expect (unhealthy? (make-river "Sup" 6.45 12.9 empty)) true)
(check-expect (unhealthy? (make-river "Sup" 6.5 6 empty)) false)
(check-expect (unhealthy? (make-river "Sup" 8 6 empty)) false)
(check-expect (unhealthy? (make-river "Sup" 6 6 empty)) true)
(check-expect (unhealthy? (make-river "Sup" 6.5 5 empty)) true)
(check-expect (unhealthy? (make-river "Sup" 8.1 8 empty)) true)
(check-expect (unhealthy? (make-river "Sup" 8 8 (list
                                                 (make-river "sisi" 7.1 8 empty)) ))false)
(check-expect (unhealthy? RIVER-EX) true)
(check-expect (unhealthy? (make-river "Hello" 7.0 10 (list (make-river "Sup" 7.01 12.9 empty)
                                                           (make-river "North River" 8.0 11 (list  (make-river "Mimm" 6.5 12.1 
                                                                                                               (list  (make-river "River into river" 6.8 11.1 empty)))
                                                                                                   (make-river "HAHAHA" 8.0 12.01 empty)
                                                                                                   (make-river "SOO MANY rivers" 6.5 12.88 empty)
                                                                                                   (make-river "AcID RiVEr" 6.5 10 empty)))
                                                           (make-river "Sourth River" 7 20 empty)
                                                           (make-river "Our River" 8.0 18.0 empty)
                                                           (make-river "Haha River" 6.9 17.2 empty)
                                                           )))
              false)
(check-expect (unhealthy?--lor (list (make-river "Sup" 7.01 12.9 empty)
                                     (make-river "North River" 8.0 11 (list  (make-river "Mimm" 6.5 12.1 
                                                                                         (list  (make-river "River into river" 6.8 11.1 empty)))
                                                                             (make-river "HAHAHA" 8.0 12.01 empty)
                                                                             (make-river "SOO MANY rivers" 6.5 12.88 empty)
                                                                             (make-river "AcID RiVEr" 6.5 10 empty)))
                                     (make-river "Sourth River" 7 20 empty)
                                     (make-river "Our River" 8.0 18.0 empty)
                                     (make-river "Haha River" 6.9 17.2 empty)
                                     ))false)
(check-expect (unhealthy?--lor empty) false)
;(define (unhealthy? a-river) false);stub


(define (unhealthy? a-river)
  (if 
   (or  (< (river-pH a-river) 6.5)
        (>  (river-pH a-river) 8.0)  ;Natural
        (< (river-do a-river) 6))  ;Natural
   true
   (unhealthy?--lor (river-tributaries a-river))))  


; unhealthy?--lor: ListOfRiver -> Boolean
; consumes ListOfRiver, produces true if any river has a pH below 6.5 or over 8.5 or a DO under 6ppm
(define (unhealthy?--lor a-lor)
  (cond
    [(empty? a-lor) false]
    [(cons? a-lor) (or
                    (unhealthy? (first a-lor)) 
                    (unhealthy?--lor (rest a-lor)))]))

;QUESTION 6
; lower-all-ph: River -> River
; consumes a river, produces river system with all rivers pH lowered by 0.3
(check-expect (lower-all-ph (make-river "Sup" 6.45 12.9 empty)) (make-river "Sup" 6.15 12.9 empty))
(check-expect (lower-all-ph (make-river "Sup" 6.5 6 empty)) (make-river "Sup" 6.2 6 empty))
(check-expect (lower-all-ph (make-river "Sup" 8 6 empty)) (make-river "Sup" 7.7 6 empty))
(check-expect (lower-all-ph (make-river "Sup" 6 6 empty)) (make-river "Sup" 5.7 6 empty))
(check-expect (lower-all-ph (make-river "Sup" 6.5 5 empty)) (make-river "Sup" 6.2 5 empty))
(check-expect (lower-all-ph (make-river "Sup" 8.1 8 empty)) (make-river "Sup" 7.8 8 empty))
(check-expect (lower-all-ph--lor empty) empty)
(check-expect (lower-all-ph--lor (list (make-river "Sup" 8.1 8 empty))) (list (make-river "Sup" 7.8 8 empty)))
(check-expect (lower-all-ph--lor (list (make-river "Sup" 8.3 8 empty))) (list (make-river "Sup" 8 8 empty)))
(check-expect (lower-all-ph (make-river "Matt" 6.5 5 (list
                                                      (make-river "Sup" 6.3 12.9 (list
                                                                                  (make-river "Sup" 6.3 12.9 (list (make-river "Sup" 5.3 12.9 empty)))
                                                                                  (make-river "Sup" 6.3 12.9 empty)
                                                                                  (make-river "Sup" 4.3 12.9 empty)))
                                                      (make-river "Sup" 1.3 12.9 empty)
                                                      (make-river "Sup" 0.3 12.9 empty))))
              (make-river "Matt" 6.2 5 (list
                                        (make-river "Sup" 6 12.9 (list
                                                                  (make-river "Sup" 6 12.9 (list (make-river "Sup" 5 12.9 empty)))
                                                                  (make-river "Sup" 6 12.9 empty)
                                                                  (make-river "Sup" 4 12.9 empty)))
                                        (make-river "Sup" 1 12.9 empty)
                                        (make-river "Sup" 0 12.9 empty))))
(check-expect (lower-all-ph (make-river "Sup" 8.1 8 empty)) (make-river "Sup" 7.8 8 empty))

;(define (lower-all-ph a-river) (make-river "Sup" 8.1 8 empty));stub


(define (lower-all-ph a-river)
  (make-river (river-name a-river) 
              (- (river-pH a-river) 0.3)  
              (river-do a-river)  
              (lower-all-ph--lor (river-tributaries a-river))))  

; lower-all-ph--lor: ListOfRiver -> ListOfRiver
; consumes a river, produces a ListOfRiver with all pH lowered by 0.3
(define (lower-all-ph--lor a-lor) ;using map
  (map lower-all-ph a-lor))

#;(define (lower-all-ph--lor a-lor) ; not using map
    (cond
      [(empty? a-lor) empty]
      [(cons? a-lor) (cons 
                      (lower-all-ph (first a-lor)) 
                      (lower-all-ph--lor (rest a-lor)))]))

;QUESTION 7
;find-subsystem: String River -> River or false
; consumes a name of a river (String ) and a River, produces the River with the same name or false if not found

(check-expect (find-subsystem "HAHAHA" RIVER-EX) (make-river "HAHAHA" 5.19 12.01 empty))
(check-expect (find-subsystem "Sourth River" RIVER-EX) (make-river "Sourth River" 6.2 20 empty))
(check-expect (find-subsystem "Sourth fsdaoifi" RIVER-EX) false)
(check-expect (find-subsystem--lor "" empty) false)
(check-expect (find-subsystem--lor "AcID RiVEr" (list (make-river "Sup" 7.01 12.9 empty)
                                                      (make-river "North River" 8.0 11 (list  (make-river "Mimm" 9.1 12.1 
                                                                                                          (list  (make-river "River into river" 8.4 11.1 empty)))
                                                                                              (make-river "HAHAHA" 5.19 12.01 empty)
                                                                                              (make-river "SOO MANY rivers" 5.0 12.88 empty)
                                                                                              (make-river "AcID RiVEr" 1.1 0.5 empty)))
                                                      (make-river "Sourth River" 6.2 20 empty)
                                                      (make-river "Our River" 7.1 18.0 empty)
                                                      (make-river "Haha River" 6.9 17.2 empty)
                                                      ))   (make-river "AcID RiVEr" 1.1 0.5 empty))

;(define (find-subsystem rivname a-river) false);stub
(define (find-subsystem rivname a-river)
  (if (string=? rivname (river-name a-river)) ;String
      a-river
      (find-subsystem--lor rivname (river-tributaries a-river))))

; list-of-river-fcn: ListOfRiver -> River or false
; consumes a string and list of rivers (ListOfRiver ), produces the River with the same name or false if not found
(define (find-subsystem--lor rivname a-lor)
  (cond
    [(empty? a-lor) false]
    
    [(cons? a-lor) (local [(define SUBSYS-TRY (find-subsystem rivname (first a-lor)))]
                     (if (not (false? SUBSYS-TRY))
                         SUBSYS-TRY
                         (find-subsystem--lor rivname (rest a-lor))))]))

;PART 2
;QUESTION 8

(define-struct menu-item (name kind vegetarian? quantity price))
;; a MenuItem is a (make-menu-item String String Boolean Natural Number)
;; interp:
;;        MenuItem represents an item for an electronic menu system in a restaurant, where
;;        name is the name of the menu item
;;        kind indicates whether the item is a beverage, entree, appetizer, dessert
;;        vegetarian?  is true if the item is vegetarian
;;        qty is the number of that item that has been ordered
;;        price is the cost of a single item

;; an Order (ListOfMenuItem) is either
;; empty, or
;; (cons MenuItem Order)
(define WINGS   (make-menu-item "Wings" "Appetizer" #false 2 12))
(define SALMON  (make-menu-item "Salmon" "Entree" #true 1 16))
(define BURGER  (make-menu-item "Hamburger" "Entree" #false 1 15))
(define SALAD   (make-menu-item "Salad" "Entree" #true 1 7))
(define MOZ-STICKS (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50))
(define FRENCH-FRIES (make-menu-item "Fries" "appetizer" true 1 2.50))
(define MEATBALLS (make-menu-item "Meatballs" "appetizer" false 1 5.50))
(define STEAKTIPS (make-menu-item "Steak Tips with Mashed Potatos and Gravy" "entree" false 1 15.50))
(define WATER (make-menu-item "Water" "beverage" true 1 0))
(define LEM-WATER (make-menu-item "Lemon Water" "beverage" true 1 0.5))
(define BEER (make-menu-item "Beer" "beverage" true 1 2.50))
(define LAVA-CAKE (make-menu-item "Lava Cake with Vanilla Ice Cream" "dessert" true 1 7.50))

(define ORDER0 (cons MOZ-STICKS (cons FRENCH-FRIES (cons MEATBALLS empty))))
(define ORDER1 (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50)
                     (cons (make-menu-item "Meatballs" "appetizer" false 1 5.50) empty)))
(define ORDER2 (cons (make-menu-item "Grilled Chicken and Lime Rice" "entree" false 1 9.50)
                     (cons (make-menu-item "Beef Burrito Bowl" "entree" false 1 9.50) empty)))
(define ORDER3 (list BEER LAVA-CAKE WATER MEATBALLS LEM-WATER))
(define ORDER4 (list BEER LAVA-CAKE WATER MEATBALLS SALAD BURGER))
(define ORDER5 (list BEER  WATER  LEM-WATER ))

;; dollar-menu-items:  ListOfMenu-items -> ListOfString
;; consumes a list of menu items and produces a list of the names of all the items with prices of $1 or less
(check-expect (dollar-menu-items empty) empty)
(check-expect (dollar-menu-items ORDER0) empty)
(check-expect (dollar-menu-items ORDER1) empty)
(check-expect (dollar-menu-items ORDER3) (list "Water" "Lemon Water"))
(check-expect (dollar-menu-items ORDER4) (list "Water" ))
(check-expect (dollar-menu-items ORDER5) (list "Water" "Lemon Water"))

(define (dollar-menu-items a-order)
  (local [(define (dollar-menu-items--order a-order)
            (map menu-item-name (filter dollar-menu-items--menu-item? a-order)))

          (define (dollar-menu-items--menu-item? a-mi)
            (<= (menu-item-price a-mi) 1))
          ]
    (dollar-menu-items--order a-order)))


;QUESTION 9
;; all-same-kind?:  ListOfMenu-item String -> Boolean
;; consumes a Order (ListOfMenu-items) and a kind of food and produces true if every item is of that kind
(check-expect (all-same-kind? empty "") true)
(check-expect (all-same-kind? ORDER4 "beverage") false)
(check-expect (all-same-kind? ORDER5 "beverage") true)
(check-expect (all-same-kind? ORDER2 "beverage") false)
(check-expect (all-same-kind? ORDER2 "entree") true)
(check-expect (all-same-kind? ORDER1 "beverage") false)
(check-expect (all-same-kind? ORDER1 "appetizer") true)
(check-expect (all-same-kind? ORDER0 "appetizer") true)
(check-expect (all-same-kind? ORDER3 "appetizer") false)
;(define (all-same-kind? a-order kind) false) ;stub

(define (all-same-kind? a-order kind)
  (local [
          (define (all-same-kind?--order a-order)
            (empty? (filter all-same-kind?--menu-item? a-order)))
          (define (all-same-kind?--menu-item? a-mi)
            (not (string=? (menu-item-kind a-mi) kind)))
          ]
    (all-same-kind?--order a-order)))

;#;(define (all-same-kind? a-order kind)
;   (cond [(empty? a-order) true]
;          [(cons? a-order) (if (not (all-same-kind?--menu-item? (first a-order) kind))
;                               false
;                               (all-same-kind? (rest a-order) kind))]))
          
;#;(define (all-same-kind?--menu-item? a-menu-item kind)
;    (string=? (menu-item-kind a-menu-item) kind))


;QUESTION 10
;; list-expensive-vegetarian:  ListOfMenu-item Number -> ListOfMenu-item
;; consumes a list of menu items and returns a list of those that exceed the given amount
(check-expect (list-expensive-vegetarian empty 1)
              empty)
(check-expect (list-expensive-vegetarian ORDER1 1)
              (list (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.5)))
(check-expect (list-expensive-vegetarian ORDER1 1)
              (list (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.5)))
(check-expect (list-expensive-vegetarian ORDER1 10)
              empty)
(check-expect (list-expensive-vegetarian ORDER3 1)
              (list
               (make-menu-item "Beer" "beverage" true 1 2.5)
               (make-menu-item "Lava Cake with Vanilla Ice Cream" "dessert" true 1 7.5)
               ))
;(define (list-expensive-vegetarian a-order num) empty);stub

(define (list-expensive-vegetarian a-order num)
  (local [
          (define (list-expensive-vegetarian--order a-order)
            (filter list-expensive-vegetarian--menu-item? a-order))
          (define (list-expensive-vegetarian--menu-item? a-mi)
            (and (> (menu-item-price a-mi) num) (menu-item-vegetarian? a-mi)))
          ]
    (list-expensive-vegetarian--order a-order)))
