;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Lui-B-Lab3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Brandon Lui blui
;Lab 3

;QUESTION 1

(define-struct menu-item (name kind vegetarian? quantity cost))
; a Menu-item is a (make-menu-item String String Boolean Natural Number)
; interp: represents a menu item in a restraunt where
; name is the name of the menu item
; kind is the type of menu item (appetizer, entree, dessert, or beverage)
; vegetarian? is if the item is vegetarian (true if the menu item is vegetarian, false otherwise)
; quantity is the number of items ordered
; cost is the cost of a single item in USD

(define MOZ-STICKS (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50))
(define FRENCH-FRIES (make-menu-item "Fries" "appetizer" true 1 2.50))
(define MEATBALLS (make-menu-item "Meatballs" "appetizer" false 1 5.50))
(define STEAKTIPS (make-menu-item "Steak Tips with Mashed Potatos and Gravy" "entree" false 1 15.50))
(define WATER (make-menu-item "Water" "beverage" true 1 0))
(define BEER (make-menu-item "Beer" "beverage" true 1 2.50))
(define LAVA-CAKE (make-menu-item "Lava Cake with Vanilla Ice Cream" "dessert" true 1 7.50))

;QUESTION 2

#; (define (menu-item-fcn a-menu-item) ; Menu-item function template
     (... (menu-item-name a-menu-item)
          (menu-item-kind a-menu-item)
          (menu-item-vegetarian? a-menu-item)
          (menu-item-quantity a-menu-item)
          (menu-item-cost a-menu-item)))

;QUESTION 3

;a Order is one of
; - empty
; - (cons Menu-item Order)
; interp: represents a list of Menu-item as an Order

(define ORDER0 (cons MOZ-STICKS (cons FRENCH-FRIES (cons MEATBALLS empty))))
(define ORDER1 (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50) (cons (make-menu-item "Meatballs" "appetizer" false 1 5.50) empty)))
(define ORDER2 (cons (make-menu-item "Grilled Chicken and Lime Rice" "entree" false 1 9.50) (cons (make-menu-item "Beef Burrito Bowl" "entree" false 1 9.50) empty)))


;QUESTION 4
;Order fcn template
#; (define (order-fcn a-order) 
     (cond [(empty? a-order) (...)]
           [(cons? a-order) (... (menu-item-fcn (first a-order)) 
                                 (order-fcn (rest a-order)))]))

;QUESTION 5
;count-appetizers: Order -> Number
; consumes an Order, returns the number of menu-items in the order that are appetizers
(check-expect (count-appetizers  empty)
              0)
(check-expect (count-appetizers (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50) empty))
              1)
(check-expect (count-appetizers (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50) empty))))
              3)
(check-expect (count-appetizers (cons BEER (cons LAVA-CAKE (cons (make-menu-item "Dish" "dessert" true 1 8.50) empty))))
              0)
(check-expect (count-appetizers (cons BEER (cons LAVA-CAKE (cons (make-menu-item "Dish" "appetizer" true 1 8.50) empty))))
              1)
(check-expect (count-appetizers (cons LAVA-CAKE (cons BEER (cons (make-menu-item "Dish" "dessert" true 1 8.50) empty))))
              0)
(check-expect (count-appetizers (cons MOZ-STICKS (cons MEATBALLS (cons (make-menu-item "Dish" "dessert" true 1 8.50) empty))))
              2)
          ;(define (count-appetizers a-order) 0);stub
(define (count-appetizers a-order) 
             (cond [(empty? a-order) 0]
                   [(cons? a-order) (if (menu-item-appetizer? (first a-order))
                                        (+ 1 (count-appetizers (rest a-order)))
                                        (count-appetizers (rest a-order)))]))   


; menu-item-appetizer?: Menu-item -> Boolean
; consumes a Manu-item, produces true if the item is an appetizer, false if not
(check-expect (menu-item-appetizer? MOZ-STICKS) true)
(check-expect (menu-item-appetizer? FRENCH-FRIES) true)
(check-expect (menu-item-appetizer? MEATBALLS) true)
(check-expect (menu-item-appetizer? BEER) false)
(check-expect (menu-item-appetizer? WATER) false)
(check-expect (menu-item-appetizer? LAVA-CAKE) false)
(check-expect (menu-item-appetizer? STEAKTIPS) false)
(check-expect (menu-item-appetizer? (make-menu-item "Dish" "dessert" true 1 8.50)) false)
(check-expect (menu-item-appetizer? (make-menu-item "Dish" "appetizer" true 1 8.50)) true)
;(define (menu-item-appetizer? a-menu-item) true);stub
(define (menu-item-appetizer? a-menu-item) 
     (string=? 
          (menu-item-kind a-menu-item)
          "appetizer"))

;QUESTION 6
; list-expensive-vegetarian: Order Number -> Order
; consumes an Order and a price, produces an order with only vegetarian items that costs more than the given amount
(check-expect (list-expensive-vegetarian empty 0)
              empty)
(check-expect (list-expensive-vegetarian (cons (make-menu-item "Dish" "dessert" true 1 8.50) empty) 7)
              (cons (make-menu-item "Dish" "dessert" true 1 8.50)  empty))
(check-expect (list-expensive-vegetarian (cons (make-menu-item "Dish" "dessert" true 1 6.5) empty) 7)
             empty)
(check-expect (list-expensive-vegetarian (cons (make-menu-item "Dish" "dessert" true 1 8.50) (cons (make-menu-item "Dish" "dessert" true 1 10.50) (cons (make-menu-item "Dish" "dessert" true 1 7) empty))) 7)
              (cons (make-menu-item "Dish" "dessert" true 1 8.50) (cons (make-menu-item "Dish" "dessert" true 1 10.50)  empty)))
(check-expect (list-expensive-vegetarian (cons (make-menu-item "Dish" "entree" true 1 5) (cons (make-menu-item "Dish" "dessert" true 1 7) (cons (make-menu-item "Dish" "dessert" true 1 6) empty) ))7)
             empty)
(check-expect (list-expensive-vegetarian (cons (make-menu-item "Dish" "entree" true 1 5) (cons (make-menu-item "Dish" "dessert" true 1 7) (cons (make-menu-item "Dish" "dessert" true 1 6) empty) ))4)
             (cons (make-menu-item "Dish" "entree" true 1 5) (cons (make-menu-item "Dish" "dessert" true 1 7) (cons (make-menu-item "Dish" "dessert" true 1 6) empty))))

;(define (list-expensive-vegetarian a-order price)empty);stub
(define (list-expensive-vegetarian a-order price) 
     (cond [(empty? a-order) empty]
           [(cons? a-order) (if (expensive-vegetarian? (first a-order) price)
                                (cons (first a-order) (list-expensive-vegetarian (rest a-order) price))
                                 (list-expensive-vegetarian (rest a-order) price))]))

;expensive-vegetarian?: Menu-item Number -> Boolean
; consumes a Menu-item and price, produces true if menu item is vegeterian and greater than given price
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" true 1 5) 5)
              false)
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" false 1 5) 5)
              false)
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" true 1 5) 6)
              false)
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" true 1 6) 5)
              true)
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" false 1 6) 5)
              false)
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" true 1 7) 6)
              true)
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" true 1 1) 0)
              true)
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" true 1 0) 10)
              false)
(check-expect (expensive-vegetarian? (make-menu-item "Dish" "entree" false 1 0) 10)
              false)
;(define (expensive-vegetarian? a-menu-item price) false);stub
(define (expensive-vegetarian? a-menu-item price) 
     (and
          (menu-item-vegetarian? a-menu-item)
          (> (menu-item-cost a-menu-item) price)))

;QUESTION 7
;order-total: Order -> Number
; consumes an Order, produces the total cost of the order as a number
(check-expect (order-total empty)
              0)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 8.50) empty))
              8.5)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 0 8.50) empty))
              0)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 0) empty))
              0)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 0 5)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 2 0)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 0 5) empty))))
              0)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 5 5) empty))
              25)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 5)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 5)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 2 5) empty))))
              20)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 5 5)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 5 5) empty)))
              50)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 5)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 5)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 1 5) empty))))
              15)
(check-expect (order-total (cons (make-menu-item "Mozzarella Sticks" "appetizer" true 2 5)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 2 5)(cons (make-menu-item "Mozzarella Sticks" "appetizer" true 2 5) empty))))
              30)
;(define (order-total a-order) 0);stub
