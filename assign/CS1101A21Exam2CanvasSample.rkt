;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname CS1101A21Exam2CanvasSample) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;EXAM 2  Supplemental Permitted Materials 
  

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
;

;Question 1:

(define-struct boat (name max-hp capacity))
;;a Boat is a (make-boat String Natural Natural))
;;name is the name of the boat
;;max-hp is the top horsepower of the boat
;;capacity is the number of guests that can sail on the boat 

;;A ListOfBoat is one of:
;;  - empty
;;  (cons Boat ListOfBoat)

; ;; boat-fcn:  Boat ->
; ;;
; (define (boat-fcn a-boat)
;   (...  (boat-name      a-boat)
;         (boat-max-hp    a-boat)
;         (boat-capacity  a-boat)



; ;; lob-fcn:  ListOfBoat ->
; ;;
; (define (lob-fcn alob)
;   (cond [(empty? alob)  (...) ]
;         [(cons?  alob)  (...     (boat-fcn (first alob))
;                                  (lob-fcn  (rest alob)))]))


;Write a function to satisfy the following signature and purpose.  You must develop a helper function and use the helper in your solution. Provide a signature and purpose for your helper.



;;beastly-boats:  ListOfBoat -> Natural
;;consumes a list of boats and returns the number of boats that both 
;;generate more than 1000 horsepower and have a capacity of at least 25


;Question 2:

(define MASS (cons "woo" (cons "train" empty)))
(define GLOBE (list "world" "nation" "planet" ))
(define WPI "goat")





;Question 3:

;;Build a couple of BSTs and answer some questions about them


;Question 4:

(define-struct taxi (medallion driver year left right))
;;a Taxi is a (make-taxi Natural String Natural BST BST))
;;medallion is the taxi's (unique) medallion [number]
;;driver is the name of the taxi's driver
;;year is the model year of the taxi
;;left  is a BST
;;right is a BST

;;a BST is one of
;;   - false
;;   - Taxi
;;
;;invariant: all medallions in the left BST of a taxi are
;;smaller than the taxi's medallion, and all medallions in the right 
;;BST of a taxi are larger than the taxi's medallion.   

;;;template for functions on Taxi:
;#;(define (fcn-for-Taxi   a-taxi)
;  (... (taxi-medallion    a-taxi)
;       (taxi-driver       a-taxi)
;       (taxi-year         a-taxi)
;       (taxi-left         a-taxi)
;       (taxi-right        a-taxi)))
;

;;;(recursive) template for functions on BinaryTrees:
;#;(define (fcn-for-Taxi a-taxi)
;    (cond [(boolean? a-taxi) (... )];base case
;          [(taxi?    a-taxi) (... (taxistuff ... )
;                                  ( ... )
;                                  ( ... a-taxi)
;                                  (fcn-for-Taxi (taxi-left  a-taxi))
;                                  (fcn-for-Taxi (taxi-right a-taxi)))]))



;Write a function with the following signature and purpose.  Your code should take advantage of the fact that the tree is a Binary Search Tree, finding the appropriate place where the new taxi will be inserted as quickly as possible.


;;insert-taxi: BST Natural String Natural -> Taxi
;;consumes a binary search tree, medallion, driver, and a year to 
;;produce a taxi with the new taxi in the appropriate place in the Taxi(BST) 

(define ALLCABS (make-taxi 100 "Hildy" 2020
                           (make-taxi 50 "Travis" 2019 false false)
                           (make-taxi 150 "Bickle" 2018 false
                                      (make-taxi 200 "Max" 2019 false false))))

(check-expect (insert-taxi (make-taxi 5 "b" 2020 false false) ALLCABS)
              (make-taxi 100 "Hildy" 2020
                         (make-taxi 50 "Travis" 2019
                                    (make-taxi 5 "b" 2020 false false) false)
                         (make-taxi 150 "Bickle" 2018 false
                                    (make-taxi 200 "Max" 2019 false false))))
(check-expect (insert-taxi (make-taxi 55 "b" 2020 false false) ALLCABS)
              (make-taxi 100 "Hildy" 2020
                         (make-taxi 50 "Travis" 2019
                                    false (make-taxi 55 "b" 2020 false false))
                         (make-taxi 150 "Bickle" 2018 false
                                    (make-taxi 200 "Max" 2019 false false))))
(check-expect (insert-taxi (make-taxi 205 "b" 2020 false false) ALLCABS)
              (make-taxi 100 "Hildy" 2020
                         (make-taxi 50 "Travis" 2019
                                    false false)
                         (make-taxi 150 "Bickle" 2018 false
                                    (make-taxi 200 "Max" 2019 false (make-taxi 205 "b" 2020 false false)))))
(check-expect (insert-taxi (make-taxi 5 "b" 2020 false false) (make-taxi 10 "b" 2020 false false))
              (make-taxi 10 "b" 2020
                         (make-taxi 5 "b" 2020 false false)
                         false))
(check-expect (insert-taxi (make-taxi 15 "b" 2020 false false) (make-taxi 10 "b" 2020 false false))
              (make-taxi 10 "b" 2020
                         false
                         (make-taxi 15 "b" 2020 false false)))

#;(define (fcn-for-Taxi a-taxi)
    (cond [(boolean? a-taxi) (... )];base case
          [(taxi?    a-taxi) (... (taxistuff ... )
                                  ( ... )
                                  ( ... a-taxi)
                                  (fcn-for-Taxi (taxi-left  a-taxi))
                                  (fcn-for-Taxi (taxi-right a-taxi)))]))

(define (insert-taxi newTaxi a-BST)
  (cond [(boolean? a-BST) newTaxi]
        [(taxi? a-BST) 
         (cond 
           [(< (taxi-medallion newTaxi) (taxi-medallion a-BST))
            (make-taxi (taxi-medallion    a-BST)
                       (taxi-driver a-BST)
                       (taxi-year  a-BST)
                       (insert-taxi newTaxi (taxi-left a-BST))
                       (taxi-right a-BST))]
           [(> (taxi-medallion newTaxi) (taxi-medallion a-BST))
            (make-taxi (taxi-medallion    a-BST)
                       (taxi-driver a-BST)
                       (taxi-year  a-BST)
                       (taxi-left a-BST)
                       (insert-taxi newTaxi (taxi-right a-BST)))])]))
#|
 [(and (< (taxi-medallion newTaxi) (taxi-medallion a-BST)) (not (taxi? (taxi-left a-BST))))
         (make-taxi (taxi-medallion    a-BST)
                    (taxi-driver a-BST)
                    (taxi-year  a-BST)
                    newTaxi
                    (taxi-right a-BST))]
        [(and (> (taxi-medallion newTaxi) (taxi-medallion a-BST)) (not (taxi? (taxi-right a-BST))))
         (make-taxi (taxi-medallion    a-BST)
                    (taxi-driver a-BST)
                    (taxi-year  a-BST)
                    (taxi-left a-BST)
                    newTaxi)]
|#


;update-taxi: Natural String Taxi  -> Taxi
; consumes a existing medallisn, new driver name and existing Taxi , produces new taxi with new name

(check-expect (update-taxi 15 "hello" (make-taxi 55 "b" 2020 (make-taxi 15 "b" 2020 false false) false))
              (make-taxi 55 "b" 2020 (make-taxi 15 "hello" 2020 false false) false))
(check-expect (update-taxi 65 "hello" (make-taxi 55 "b" 2020  false (make-taxi 65 "b" 2020 false false)))
              (make-taxi 55 "b" 2020  false (make-taxi 65 "hello" 2020 false false)))
(check-expect (update-taxi 10 "hello" (make-taxi 55 "b" 2020  false (make-taxi 65 "b" 2020 false false)))
              (make-taxi 55 "b" 2020  false (make-taxi 65 "b" 2020 false false))) ;not updated /found

;(define (update-taxi medallian driver a-taxi) "");st
(define (update-taxi medallian driver a-taxi)
  (cond [(boolean? a-taxi) false];base case
        [(taxi?    a-taxi) (cond [(< medallian (taxi-medallion a-taxi) )
                                  (make-taxi (taxi-medallion a-taxi)
                                             (taxi-driver a-taxi)
                                             (taxi-year  a-taxi)
                                             (update-taxi medallian driver (taxi-left  a-taxi))
                                             (taxi-right a-taxi))]
                                 [(> medallian (taxi-medallion a-taxi) )
                                  (make-taxi (taxi-medallion a-taxi)
                                             (taxi-driver a-taxi)
                                             (taxi-year  a-taxi)
                                             (taxi-left  a-taxi)
                                             (update-taxi medallian driver (taxi-right a-taxi)))]
                                 [(= medallian (taxi-medallion a-taxi) )
                                  (make-taxi (taxi-medallion a-taxi)
                                             driver
                                             (taxi-year  a-taxi)
                                             (taxi-left  a-taxi)
                                             (taxi-right a-taxi))]
                                               
                                 )]))

;Question 5:


(define-struct horb (name atmosphere system))
;;A Horb is a (make-horb String String ListOfHorb)
;;name is the name of the horb
;;atmosphere is the principal gas in the horb's atmosphere 
;;system is a list of horbs that orbit the horb

;;A ListOfHorb is one of
;;  - empty
;;  - (cons Horb ListOfHorb)

;Write a function (or functions) to satisfy the following signature/purpose:


;;no-atmosphere: Horb -> ListOfString
;;consumes a heavenly orb and returns a list of names of heavenly
;;orbs in the overall system with no atmosphere
;;that is, the atmosphere is officially "none"
;; no-atmosphere--loh:  ListOfHorb -> ListOfString
;;consumes a list of heavenly orb and returns a list of names of heavenly
;;orbs in the overall system with no atmosphere
;;that is, the atmosphere is officially "none"
(check-expect (no-atmosphere APHRODITE) empty)
(check-expect (no-atmosphere SOL) (list "The Moon" "Phobos" "Deimos"))
(check-expect (no-atmosphere ARES) (list "Phobos" "Deimos"))
(check-expect (no-atmosphere TERRA) (list "The Moon"))
(check-expect (no-atmosphere--loh empty) empty)
(check-expect (no-atmosphere--loh (list LUNA)) (list "The Moon"))
(check-expect (no-atmosphere--loh (list APHRODITE)) empty)
(check-expect (no-atmosphere--loh (list LUNA APHRODITE)) (list "The Moon"))
(check-expect (no-atmosphere--loh (list LUNA APHRODITE ARES)) (list "The Moon" "Phobos" "Deimos"))
;(define (no-atmosphere a-horb) empty);stub
;(define (no-atmosphere--loh a-horb) empty);stub

(define (no-atmosphere a-horb)
  (if (string=? (horb-atmosphere a-horb) "none")
      (cons (horb-name a-horb)  (no-atmosphere--loh (horb-system a-horb)))
      (no-atmosphere--loh (horb-system a-horb))))

(define (no-atmosphere--loh aloh)
  (cond [(empty? aloh) empty]
        [(cons? aloh)
         (append (no-atmosphere (first aloh))
                 (no-atmosphere--loh (rest aloh)))]))


; ;; horb-fcn:  Horb ->
; ;;
; (define (horb-fcn a-horb)
;     (...  (horbstuff ...)
;           ( ... )
;           ( ...   a-horb)
;           (loh-fcn (horb-system a-horb))))
;   
;   
; ;; loh-fcn:  ListOfHorb ->
; ;;
; (define (loh-fcn aloh)
;     (cond [(empty? aloh) (...)]
;           [(cons? aloh)  (...  (horb-fcn (first aloh))
;                                (loh-fcn (rest aloh)))]))



;                            The  Sun
;                           /   |    \
;                          /    |     \
;                         /     |      \
;                     Venus   Earth     Mars
;                               |       /   \
;                               |      /     \
;                             The    Phobos   Deimos
;                             Moon


;(define-struct horb (name atmosphere system))

(define APHRODITE  (make-horb "Venus" "CO2" empty))
(define FEAR (make-horb "Phobos" "none" empty))
(define PANIC (make-horb "Deimos" "none" empty))
(define ARES (make-horb "Mars" "CO2" (list FEAR PANIC)))
(define LUNA (make-horb "The Moon" "none" empty))
(define TERRA (make-horb "Earth" "nitrogen" (list LUNA)))
(define SOL (make-horb "The Sun" "hydrogen" (list APHRODITE TERRA ARES)))

;SOL is this whole system
