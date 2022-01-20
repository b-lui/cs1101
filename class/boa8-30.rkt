;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Untitled) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))


(define-struct boa (name length food))
;; a Boa is a (make-boa String Natural String)
;interp: representa a bos constrictor where
;name is the boa's name
;lenth is its length (in feet)
;food is its favorite food

(define HARVEY (make-boa "Harvey" 4 "apples"))
(define JIM (make-boa "Jim" 8 "pancakes"))

(boa-length JIM)
;;make-boa String Natural String -> Boa
;;consume a boa's name, length, favorite food; produce a boa

;;boa-name: Boa -> String
;; consume a boa; produce a boa's name

;boa-length: Boa -> Natural
;; consume a boa; produce a boa's length

;boa-doos: Boa -> String
;; consume a boa; produce a boa's favorite food

;;boa? any -> Boolean
; consumes anything and produces true if it is a boa
