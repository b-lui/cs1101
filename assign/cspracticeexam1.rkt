;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Untitled) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (fn-question a-string) (string-append (substring a-string 1 3) (substring a-string 7 10)))

(define EXAM1 (cons 3 (cons 2 (cons 1 empty))))

(check-expect (keeper? 3.25 false)false) ; has to be more than 3.25 inches, testing equal case
(check-expect (keeper? 3 false)false) ; has to be more than 3.25 inches
(check-expect (keeper? 5 false)false) ;has to be less than 5 in, testing equal
(check-expect (keeper? 5.5 false)false); hast to be less than 5 inches

(check-expect (keeper? 4 false)true) ;testing true case
(check-expect (keeper? 3.5 false)true) ;testing true case
(check-expect (keeper? 4 true)false)  ;in between range, but has eggs
(check-expect (keeper? 3.5 true)false);in between range, but has eggs
(check-expect (keeper? 5.5 true)false) ;not in between range, but has eggs

;A Crossing is one of
;- Bridge
;- Tunnel
;- Ferry
;interp: Crossing represents an itemization of the three data definitions above

(define-struct tunnel (name time clogged?))
(define-struct bridge (name time ))
(define-struct ferry (name time freq))
(define MYTUNNEL (make-tunnel "My Tunnel" 30 false))

(define (max-expected-time a-crossing)
  (cond
    [(bridge? a-crossing) (bridge-time a-crossing)]
    [(tunnel? a-crossing) (if (tunnel-clogged? a-crossing) (* 2 (tunnel-time a-crossing)) (tunnel-time a-crossing))]
    [(ferry? a-crossing) (+ (ferry-freq a-crossing) (ferry-time a-crossing))]))