;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname boa) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct boa (name length food))
;; a Boa is a (make-boa String Natural String)
;interp: representa a bos constrictor where
;name is the boa's name
;lenth is its length (in feet)
;food is its favorite food

(define HARVEY (make-boa "Harvey" 4 "apples"))
(define JIM (make-boa "Jim" 8 "pancakes"))

(boa-length JIM)
;;make-boa: String Natural String -> Boa
;;consume a boa's name, length, favorite food; produce a boa

;;boa-name: Boa -> String
;; consume a boa; produce a boa's name

;boa-length: Boa -> Natural
;; consume a boa; produce a boa's length

;boa-doos: Boa -> String
;; consume a boa; produce a boa's favorite food

;;boa? any -> Boolean
; consumes anything and produces true if it is a boa


;;boa-twins?: Boa Boa -> Boolean
; consumes two boa constrictors and returns true if t


;; area: Number -> Number
;; given length of one side of square, produce the area of the square
(check-expect (area 3) 9)
(check-expect (area 9) 81)
; (define (area s) 0)  ;stub
;(define (area s) (... s)) ; template

    (define (area s)
      (* s s))
    
  (require 2htdp/image)

;; image-area: Image -> Natural
;; produce an image's width * height (area)
(check-expect (image-area (rectangle 2 3 "solid" "red")) 6)
#; (define (image-area i) (... (image-width i) (image-height i))) ;stub

(define (image-area i)
  (* (image-width i) (image-height i)))



;; apple-cost: Natural -> Natural
;; produce the amount it would cost to by a box of apples taking in apple amount, each apple cost 1 dollar with the cart it comes it costing 3 dollars
(check-expect (apple 3) 6)
(check-expect (apple 0) 3)
(check-expect (apple 1) 4)
; (define (apple a) 0) ; stub
#; (define (apple a) ; template
(... (... a) 1))

(define (apple a)
(+ (* 1 a) 3)
  )

;; tall?: Image -> Boolean
;; consume a image, produce true if image length is larger than image width
(check-expect (tall? (rectangle 2 3 "solid" "red") )true)
(check-expect (tall? (rectangle 3 2 "solid" "red") )false)
        ;    (define  (tall? i) true) ;stub
(define  (tall? i)
  (if
  (< (image-width i) (image-height i))
  true false))


;;boa-fit-cage?: Boa Natural -> Boolean
;; consumes a boa constrictor and the length of a cage (in feet) and if the
;; length of the boa is less than the cage length, produces true

; (define (boa-fit-cage? a-boa cage-length) true) ;stub
;test-cases
(check-expect (boa-fit-cage? (make-boa "Homer" 8 "donuts") 9) true)
(check-expect (boa-fit-cage? HARVEY 4) false)
(check-expect (boa-fit-cage? HARVEY 5) true)

(define (boa-fit-cage? a-boa cage-length)
(< (boa-length a-boa) cage-length))

(define-struct dillo (length dead?))
;A dillo can be constructed by using (make-dillo Natural Boolean)
;interp: represents an armadillo where
;length is the dillo's length in feet
;dead? is true if the dillo is dead, false if it's alive
  (define HUGO (make-dillo 4 false))
(define TINY (make-dillo 1 true))


;; hit-with-truck: Dillo -> Dillo
;; consumes a dillo and produces a dead dillo one unit longer
;(define (hit-with-truck a-dillo) HUGO) ;stub

(check-expect (hit-with-truck TINY) (make-dillo 2 true))
(check-expect (hit-with-truck (make-dillo 2 true)) (make-dillo 3 true))

(define (hit-with-truck a-dillo) (make-dillo (+ 1 (dillo-length a-dillo)) true))

(define-struct tiger (name
                                  