;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Exam3FunctionTemplates) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #t)))
(define hey "Below are built-in higher order function signatures.")
;; build-list: Natural (Natural -> X)  -> ListOfX
;; filter:     (X -> Boolean)  ListOfX -> ListOfX
;; map:        (X -> Y) ListOfX        -> ListOfY
;; andmap:     (X -> Boolean)  ListOfX -> Boolean
;; ormap:      (X -> Boolean)  ListOfX -> Boolean
;; apply:      (X X -> X) ListOfX      -> X
;; foldr:      (X Y -> Y) Y ListOfX    -> Y
;; foldl:      (X Y -> Y) Y ListOfX    -> Y


;template higher order
#;(define (higher-order-tem a-lox ...)
     (local [
             (define (helper-fcn x ...)
               (... x)
               )
             ]
       (...a-higher-order-fn... helper-fcn a-lox)
       )
     )

;template accumulator
#;(define (acc-function-template a-lox ...)
  (local [
          (define (acc-function-template acc a-lox ...)
            (cond [(empty? a-lox) acc]
                  [(cons? a-lox) (... (helper-fcn (first a-lox))
                                     (acc-function-template acc (rest a-lox))  ;change accumulator in first or second as necessary 
                                     (acc-function-template acc (rest a-lox))
                                     )
                                 ]))
          (define (helper-fcn x)
            (... x))
          ]
    (acc-function-template ...base-case... a-lox ...)
    ))


;template set! with accumulator 
#;(define (set!-fcn-template ...)
  (set! ...VAR... (acc-function-template ...VAR... ...)))
 
#;(define (acc-function-template a-lox ...)
  (local [
          (define (acc-function-template acc a-lox ...)
            (cond [(empty? a-lox) acc]
                  [(cons? a-lox) (... (helper-fcn (first a-lox))
                                     (acc-function-template acc (rest a-lox))  ;change accumulator in first or second as necessary 
                                     (acc-function-template acc (rest a-lox))
                                     )
                                 ]))
          (define (helper-fcn x)
            (... x))
          ]
    (acc-function-template ...base-case... a-lox ...)
    ))