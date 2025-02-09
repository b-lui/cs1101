;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Lui-B-Lab6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;Brandon Lui blui

; Lab 6

;QUESTION 1

(define-struct message (username text read?))
; a Message is a (make-message String String Boolean)
; INTERP: represets a message in a mailbox system  where
;         username is the sender user's username
;         text is the contents of the mesage
;         read? is true if the message has been opened, false otherwise

; a ListOfMessage is one of
; - empty
; (cons Message ListOfMessage)
;INTERP: represents a list of messages

(define-struct user (username mailbox))
; a User is a (make-user String ListOfMessage)
; INTERP: represets a user in a mailbox system where
;         username is the user's username
;         mailbox is the messages in the user's mailbox

; a ListOfUser one of
; - empty
; - (cons User ListOfUser)
; INTERP: represents a list of users in a email-system

; a Email-system is a ListOfUser
; INTERP: represents an email system with a list of users

;QUESTION 2

;;MAILSYS is a Email-system
;;remembers information about each user's account
(define MAILSYS empty)

;;NEWUSER is a User
;;remembers information about the Newuser account
(define NEWUSER (make-user "Newuser" empty))

;QUESTION 3
;add-user: String -> void
; consumes a username and produces void, adding user to mailsystem with an empty mailbox
; EFFECT:changes MAILSYS with addition of a new user

(define (add-user username)
  (set! MAILSYS (add-user--lou username MAILSYS)))

; add-user--lou: String Email-system -> Email-system
; consumes a new username as a string and an existing Email-system aka (listof User) and produces a new Email-system with the new user
; created with empty messages in the new user's inbox

;add-user--test: String -> void
; consumes a username and produces void, adding user to mailsystem SYS-TEST-0 with an empty mailbox
; EFFECT:changes SYS-TEST-0 with addition of a new user

;;SYS-TEST-0 is a Email-system
;;remembers information about each user's account
(define SYS-TEST-0 empty)
(check-expect (begin (add-user--test "Brandon" ) SYS-TEST-0)  (list (make-user "Brandon" empty)))
(check-expect (begin (add-user--test "Lucca" ) SYS-TEST-0)
              (list (make-user "Lucca" empty)  (make-user "Brandon" empty) ))
(check-expect (begin (add-user--test "Eddie" )SYS-TEST-0)
              (list (make-user "Eddie" empty) (make-user "Lucca" empty)  (make-user "Brandon" empty) ))
(check-expect (begin (add-user--test "Natty W") SYS-TEST-0)
              (list (make-user "Natty W" empty) (make-user "Eddie" empty) (make-user "Lucca" empty)  (make-user "Brandon" empty)))
(define (add-user--test username)
  (set! SYS-TEST-0 (add-user--lou username SYS-TEST-0)))

(define (add-user--lou username a-lou)
  (cons (make-user username empty) a-lou))
  

;QUESTION 4
;send-email: String String String -> void
; consumes the name of the sender of an email, the name of the recipient of the email, and the text of an email message, and produces void
; EFFECT: changes user's mailbox adding a new unread message in the recipient's mailbox

(define (send-email sender-username recipient-username message)
  (send-email--email-system sender-username recipient-username message MAILSYS))

;send-email--email-system: String String String Email-system -> void
;consumes the name of the sender of an email, the name of the recipient of the email, and the text of an email message, and produces a new email-system
; EFFECT: changes user mailbox in given Email-system adding a new unread message in the recipient's mailbox

;;BRANDON is a User
;;remembers information about the user's account — username and mailbox
(define BRANDON (make-user "Brandon" empty))
;;LUCCA is a User
;;remembers information about the user's account — username and mailbox  
(define LUCCA (make-user "Lucca" empty))
;;SYS-TEST-1 is a Email-system
;;remembers information about each user's account
(define SYS-TEST-1 (list LUCCA
                         BRANDON))
(check-error (send-email--email-system "Brandon" "Lucca" "Hahahahah" empty)
             "Account does not exist.")
(check-expect (begin (send-email--email-system "Brandon" "Lucca" "Hahahahah" SYS-TEST-1 ) SYS-TEST-1)
              (list (make-user "Lucca" (cons (make-message "Brandon" "Hahahahah" false) empty))
                    (make-user "Brandon" empty)))
(check-expect  (begin (send-email--email-system "Lucca" "Brandon" "Thats funny" SYS-TEST-1) SYS-TEST-1)
               (list  (make-user "Lucca" (list (make-message "Brandon" "Hahahahah" false)))
                      (make-user "Brandon" (list (make-message "Lucca" "Thats funny" false)))))
;(define (send-email--email-system sender-username recipient-username message a-lou) empty);stub

(define (send-email--email-system sender-username recipient-username message a-lou)
  (local [(define (user=? a-user a-username)
            (string=? (user-username a-user) a-username))
          
          (define (send-email--user a-user)
            (set-user-mailbox! a-user
                               (cons (make-message sender-username message false)
                                     (user-mailbox a-user)))) 
            
          (define (send-email--acc a-lou )
            (cond [(empty? a-lou) (error "Account does not exist.")]
                  [(cons? a-lou)
                   (if (user=? (first a-lou) recipient-username)
                       (send-email--user (first a-lou))
                       (send-email--acc (rest a-lou)))]))
          ]
    (send-email--acc a-lou )))


;QUESTION 5
; get-unread-messages: String -> ListOfMessage
; consumes the user's username and produces their list of messages
; EFFECT: Changes the requested user's messages to read in CITIBANG
(define (get-unread-messages username)
  (get-unread-messages--lou username MAILSYS))

; get-unread-messages--lou: String Email-system -> ListOfMessage
; consumes the user's username and produces their list of messages
; EFFECT: Changes the requested user's messages to read in the given Email-system

;;BRANDON-2 is a User
;;remembers information about the user's account — username and mailbox  
(define BRANDON-2 (make-user "Brandon" (list (make-message "Lucca" "Hahahahah" false) (make-message "Lucca" "Hahahahah" false))))
;;LUCCA-2 is a User
;;remembers information about the user's account — username and mailbox  
(define LUCCA-2 (make-user "Lucca" (list (make-message "Brandon" "Hahahahah" false) (make-message "Hdog" "Hahahahah" false))))
;;HDOG-2 is a User
;;remembers information about the user's account — username and mailbox  
(define HDOG-2 (make-user "Hdog" (list (make-message "Brandon" "lol" true) (make-message "Brandon" "Hahahahah" false))))
;;SYS-TEST-2 is a Email-system
;;remembers information about each user's account
(define SYS-TEST-2 (list LUCCA-2
                         BRANDON-2 HDOG-2))
(check-error (get-unread-messages--lou "Hi" SYS-TEST-2)
             "Account does not exist.")
(check-expect  (get-unread-messages--lou "Brandon" SYS-TEST-2) 
               (list (make-message "Lucca" "Hahahahah" false) (make-message "Lucca" "Hahahahah" false)))
(check-expect (get-unread-messages--lou "Brandon" SYS-TEST-2)
              empty)
(check-expect (get-unread-messages--lou "Lucca" SYS-TEST-2) 
              (list (make-message "Brandon" "Hahahahah" false) (make-message "Hdog" "Hahahahah" false)))
(check-expect (get-unread-messages--lou "Lucca" SYS-TEST-2) 
              empty)
(check-expect  (get-unread-messages--lou "Hdog" SYS-TEST-2) 
               (list (make-message "Brandon" "Hahahahah" false)))
(check-expect (get-unread-messages--lou "Hdog" SYS-TEST-2) 
              empty)

(define (get-unread-messages--lou username a-lou)
  (local [
          (define (get-unread-messages--user a-lou)
            (cond [(empty? a-lou) (error "Account does not exist.")]
                  [(cons? a-lou)
                   (local [(define (user=? a-user)
                             (string=? (user-username a-user) username))]
                     (if (user=? (first a-lou))
                         (read-message--user (first a-lou))
                         (get-unread-messages--user (rest a-lou))))]))

          (define (read-message--user a-user)
            (local [
                    (define (reversebegin fn1 fn2) fn1)

                    (define (read-all--lom a-lom )
                      (map read-all--message a-lom))
          
                    (define (read-all--message a-message)
                      (make-message
                       (message-username a-message)
                       (message-text a-message)
                       true))
                    ]
              (reversebegin
               (filter (lambda (a-message) (not (message-read? a-message))) (user-mailbox a-user))
               (set-user-mailbox! a-user (read-all--lom (user-mailbox a-user))))))
          ]
    (get-unread-messages--user a-lou)))

;QUESTION 6
;most-messages: -> User
; does not consume anything, produces the user in MAILSYS with the largest number of messages in his/her mailbox
(define (most-messages)
  (most-messages--email-system MAILSYS))


;most-messages--email-system: Email-system -> User
; consumes a Email-system, produces the user in the given mailsystem with the largest number of messages in his/her mailbox

;;BRANDON-3 is a User
;;remembers information about the user's account — username and mailbox 
(define BRANDON-3 (make-user "Brandon" (list (make-message "Lucca" "Hahahahah" false) (make-message "Lucca" "Hahahahah" false))))
;;LUCCA-3 is a User
;;remembers information about the user's account — username and mailbox 
(define LUCCA-3 (make-user "Lucca" (list (make-message "Brandon" "Hahahahah" false) (make-message "Hdog" "Hahahahah" false) (make-message "Hdog" "Hahahahah" false))))
;;HDOG-3 is a User
;;remembers information about the user's account — username and mailbox 
(define HDOG-3 (make-user "Hdog" (list (make-message "Brandon" "lol" true) (make-message "Brandon" "Hahahahah" false))))
;;HENRY-3 is a User
;;remembers information about the user's account — username and mailbox 
(define HENRY-3 (make-user "Henry" (list (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "Hahahahah" false))))
;;SYS-TEST-3 is a Email-system
;;remembers information about each user's account
(define SYS-TEST-3 (list LUCCA-3
                         BRANDON-3 HDOG-3 HENRY-3))
;;SYS-TEST-3-1 is a Email-system
;;remembers information about each user's account
(define SYS-TEST-3-1 (list 
                         BRANDON-3 LUCCA-3 HDOG-3 ))
;;SYS-TEST-3-2 is a Email-system
;;remembers information about each user's account
(define SYS-TEST-3-2 (list 
                         BRANDON-3  HENRY-3 HDOG-3  LUCCA-3))

(check-error (most-messages--email-system empty)
             "There are no users in the given Email-system.")
(check-expect (most-messages--email-system SYS-TEST-3)
             HENRY-3)
(check-expect (most-messages--email-system SYS-TEST-3-1)
             LUCCA-3)
(check-expect (most-messages--email-system SYS-TEST-3-2)
             HENRY-3)

(define (most-messages--email-system a-email-system)
  (local [(define (most-messages--lou acc a-lou)
            (cond [(empty? a-lou) acc]
                  [(cons? a-lou) (if (mailbox-greater?  acc (first a-lou))
                                     (most-messages--lou acc (rest a-lou))
                                     (most-messages--lou (first a-lou) (rest a-lou))
                                    )]))
          (define (mailbox-greater? mb1 mb2)
            (> (length (user-mailbox mb1)) (length (user-mailbox mb2))))
          ]
  (if (empty? a-email-system)
      (error "There are no users in the given Email-system.")
      (most-messages--lou (first a-email-system) (rest a-email-system)))))

;QUESTION 7

;;BRANDON-4 is a User
;;remembers information about the user's account — username and mailbox 
(define BRANDON-4 (make-user "Brandon" (list (make-message "Lucca" "Hahahahah" false) (make-message "Lucca" "Hahahahah" false))))
;;LUCCA-4 is a User
;;remembers information about the user's account — username and mailbox 
(define LUCCA-4 (make-user "Lucca" (list (make-message "Brandon" "Hahahahah" false) (make-message "Hdog" "Hahahahah" false) (make-message "Hdog" "Hahahahah" false))))
;;HDOG-4 is a User
;;remembers information about the user's account — username and mailbox 
(define HDOG-4 (make-user "Hdog" (list (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "Hahahahah" false))))
;;HENRY-4 is a User
;;remembers information about the user's account — username and mailbox 
(define HENRY-4 (make-user "Henry" (list (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "lol" true) (make-message "Brandon" "Hahahahah" false))))

;;SYS-TEST-4 is a Email-system
;;remembers information about each user's account
(define SYS-TEST-4 empty)
;;SYS-TEST-4-1 is a Email-system
;;remembers information about each user's account
(define SYS-TEST-4-1 (list BRANDON-4 LUCCA-4 HDOG-4 HENRY-4))

;add-user--test2: String -> void
;consumes a username, creates new user in SYS-TEST-4 with empty mailbox
; EFFECT: adds new user to SYS-TEST-4 Email-system
(define (add-user--test2 username)
  (set! SYS-TEST-4 (add-user--lou username SYS-TEST-4)))

(check-expect (begin (add-user--test2 "Natty W") SYS-TEST-4)
              (list (make-user "Natty W" empty) ))
(check-error (send-email--email-system "Hello" "Heyyyy" "Hahahahah" SYS-TEST-4-1)
             "Account does not exist.")
  (check-expect (begin (send-email--email-system "Brandon" "Lucca" "Hahahahah" SYS-TEST-4-1 ) SYS-TEST-4-1)
              (list BRANDON-4 LUCCA-4 HDOG-4 HENRY-4))
(check-expect (get-unread-messages--lou "Brandon" SYS-TEST-4-1) 
              (list (make-message "Lucca" "Hahahahah" false) (make-message "Lucca" "Hahahahah" false)))
(check-error (most-messages--email-system empty)
             "There are no users in the given Email-system.")
(check-expect (most-messages--email-system SYS-TEST-4-1)
             HDOG-4)

;QUESTION 8
; a ListOfString is one of
; - empty
; - (cons String ListOfString)
;INTERP: represents a list of strings 

; total-string-length: ListOfString -> Natural
; consumes a ListOfString, produces the sum of all of the string lengths

