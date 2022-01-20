;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Montana-G-Lui-B-hw3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Gus Montana gmmontana
;; Brandon Lui blui

(define-struct menu-item (name kind vegetarian? quantity cost))
;; a menu-item is a (make-menu-item String String Boolean Natural Natural)
;; interp: represents a menu item where
;;   name is the name of the menu item
;;   kind is "appetizer", "entree", "dessert, or "beverage"
;;   vegetarian? is whether the menu item is vegetarian or not
;;   quantity is the number of the item that was ordered
;;   cost is the cost of a single of the item

(define WINGS   (make-menu-item "Wings" "Appetizer" #false 2 12))
(define MOZZ    (make-menu-item "Mozz Sticks" "Appetizer" #true 2 5))
(define SALAD   (make-menu-item "Salad" "Entree" #true 1 7))
(define SALMON  (make-menu-item "Salmon" "Entree" #true 1 16))
(define BURGER  (make-menu-item "Hamburger" "Entree" #false 1 15))
(define CAKE    (make-menu-item "Cake" "Dessert" #true 2 10))
(define BROWNIE (make-menu-item "Brownie" "Dessert" #true 1 7))
(define SPRITE  (make-menu-item "Sprite" "Beverage" #true 3 3))
(define WATER   (make-menu-item "Water" "Beverage" #true 4 0))

;; menu-item-fcn: Menu-item -> ...
;;
;; (define (menu-item-fcn a-menu-item)
;;   (... (menu-item-name        a-menu-item)
;;        (menu-item-type        a-menu-item)
;;        (menu-item-vegetarian? a-menu-item)
;;        (menu-item-quantity    a-menu-item)
;;        (menu-item-cost        a-menu-item)))

;; an Order is one of
;;   empty
;;   (cons Menu-item Order)

(define TABLE1 (cons (make-menu-item "Mozz Sticks" "Appetizer" #true 1 5)
               (cons BURGER
               (cons (make-menu-item "Salmon" "Entree" #true 1 18)
               (cons CAKE empty)))))
(define TABLE2 (cons WATER
               (cons (make-menu-item "Steak" "Entree" #false 1 19)
               (cons (make-menu-item "Grilled Cheese" "Entree" #true 1 10)
               (cons SPRITE empty)))))

;; lomi-fcn: Order -> ...
;;
;; (define (lomi-fcn a-lomi)
;;   (cond [(empty? a-lomi) (...)]
;;         [(cons?  a-lomi) (... (menu-item-fcn (first a-lomi))
;;                          (lomi-fcn (rest a-lomi)))]))