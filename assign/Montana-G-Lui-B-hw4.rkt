;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Montana-G-Lui-B-hw4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Gustave Montana gmmontana
;Brandon Lui blui

; Homework 4

;QUESTION 1

(define-struct student (name email))
; a Student is a (make-student String String)
; interp: represents a Student where
;         name represents the student's full name
;         email represents the student's school issued email

(define BRANDON (make-student "Brandon Lui" "blui@wpi.edu"))
(define PARKER (make-student "Parker Goodrum" "pgoodrum@wpi.edu"))
(define JULIE (make-student "Julie Braker" "jbraker@wpi.edu"))
(define JOHNB (make-student "John Brown" "jbrown@wpi.edu"))
(define JAQUAVIOUS (make-student "Jaquavious Smith" "jsmith@wpi.edu"))
(define JESSIE (make-student "Jessie James" "jjames@wpi.edu"))
(define EMILY (make-student "Emily Moham" "emoham@wpi.edu"))
(define NICK (make-student "Nick Trust" "ntrust@wpi.edu"))
(define LIV (make-student "Liv Young" "lyoung@wpi.edu"))
(define DANIEL (make-student "Dan D. Lyon" "ddlyon@wpi.edu"))
(define HOLLY (make-student "Holly Banks" "hbanks@wpi.edu"))
(define HEATHER (make-student "Heather Universe" "huniverse@wpi.edu"))
(define PAUL (make-student "Paul F. Costello" "pfcostello@wpi.edu"))
(define MOHAMMAD (make-student "Mohammad Auy" "mauy@wpi.edu"))
(define MCLOVIN (make-student "Mclovin" "mclovin@wpi.edu"))

(define JOHNDOE (make-student "John Doe" "jdoe@wpi.edu"))
(define JANEDOE (make-student "Jane Doe" "jdoe1@wpi.edu"))
(define JACKDOE (make-student "Jack Doe" "jdoe2@wpi.edu"))



; a ListOfStudent is one of
;  - empty
;  - (cons Student ListOfStudent)
; interp: represents a list of students

(define CLASSROSTER0 (list BRANDON PARKER))
(define CLASSROSTER1 (list JOHNDOE JANEDOE JACKDOE))
(define CLASSROSTER2 (list EMILY JESSIE JULIE))
(define CLASSROSTER3 (list EMILY BRANDON JULIE))
(define CLASSROSTER4 (list JULIE PARKER JESSIE))
(define CLASSROSTER5 (list LIV JULIE JESSIE JACKDOE DANIEL))
(define CLASSROSTER6 (list JANEDOE DANIEL JAQUAVIOUS JACKDOE NICK))
(define CLASSROSTER7 (list PARKER EMILY HOLLY JOHNDOE JOHNB))
(define CLASSROSTER8 (list HEATHER JANEDOE JULIE BRANDON EMILY))

;; a BST is one of
;;  - false
;;  - CourseNode

(define-struct coursenode (course-id title instructor students left right))
; a CourseNode is a (make-coursenode Number String String ListOfStudent BST BST)
; interp: represents a course node where
;         course-id represents the course id (coursenode key) of the course; (ex 92.102) before the decimal is the department (92), after represents te course (102)
;         title represents the title of the course
;         instructor represents the instructor of the course
;         left represents the left subtree
;         right represent the right subtree
; INVARIANT:
;    course-id > all course-id in its left subtree
;    course-id < all course-id in its right subtree
;All course-id are unique, no key appears twice in the tree

;QUESTION 2
(define COURSES0 (make-coursenode 60.001 "English" "Olivia" CLASSROSTER3
                                  (make-coursenode 20.001 "Math" "Jack Doe" CLASSROSTER5
                                                   (make-coursenode 10.001 "Football" "Yoast" CLASSROSTER1
                                                                    false
                                                                    (make-coursenode 15.001 "Track" "Holly" CLASSROSTER0
                                                                                     (make-coursenode 12.001 "Cross" "Jack" CLASSROSTER6 false false)
                                                                                     false))
                                                   (make-coursenode 39.001 "Gym" "Jack" CLASSROSTER6 false false))
                                  (make-coursenode 70.001 "French" "Eddy" CLASSROSTER2
                                                   (make-coursenode 65.001 "Chemistry Lab" "Hunt" CLASSROSTER5 false false)
                                                   (make-coursenode 75.001 "Ice Hockey" "Smith" CLASSROSTER2 false false))))
(define COURSES1 (make-coursenode 50.001 "Math" "Mr. Brown" CLASSROSTER0
                                  (make-coursenode 40.001 "English" "Mrs. Jackson" (list JOHNB BRANDON JULIE)
                                                   false
                                                   (make-coursenode 45.001 "Martial Arts" "Mr. U" (list JESSIE JOHNB PARKER BRANDON)
                                                                    false
                                                                    false))
                                  (make-coursenode 60.001 "Foreign Language" "Mr. Kent" (list PARKER BRANDON JULIE)
                                                   (make-coursenode 59.001 "Arts" "Mrs. Kent" (list PARKER JESSIE JAQUAVIOUS BRANDON)
                                                                    (make-coursenode 58.001 "Dark Arts" "Dr. Rood" CLASSROSTER3 false false)
                                                                    false)
                                                   false)))
(define COURSES2 (make-coursenode 40.001 "Computer Engineering" "Jimard" CLASSROSTER0
                                  (make-coursenode 20.001 "English" "Jimmy" CLASSROSTER1
                                                   false
                                                   (make-coursenode 30.001 "Calc" "Jane" CLASSROSTER0
                                                                    false
                                                                    (make-coursenode 35.001 "Chinese" "Jack" CLASSROSTER4 false false)))
                                  (make-coursenode 60.001 "French" "Eddy" CLASSROSTER2              
                                                   (make-coursenode 50.001 "Robotics" "Taren" CLASSROSTER0 false false)
                                                   (make-coursenode 65.001 "Italian" "Rotinssi" CLASSROSTER3 false false))))
(define COURSES3 (make-coursenode 50.001 "Russian" "Ryan" CLASSROSTER7
                                  false
                                  (make-coursenode 60.001 "Web Development" "Frank Ocean" CLASSROSTER4 false false)))
                                                                              


;QUESTION 3
; Student function template
; student-fcn: Student ... -> ???
; ...
#;(define (student-fcn a-student)
    (... (student-name a-student)
         (student-email a-student)))

; ListOfStudent function template
; listofstudent-fcn: ListOfStudent ... -> ???
; ...
#; (define (listofstudent-fcn a-los)
     (cond
       [(empty? a-los) (...)]
       [(cons? a-los) (... (student-helper-fcn (first a-los))
                           (listofstudent-fcn (rest a-los)))]))

; CourseNode function template
; coursenode-fcn: CourseNode ... -> ???
; ...

#; (define (coursenode-fcn a-cn)
     (cond
       [(boolean? a-cn) (...)]
       [(coursenode? a-cn) (... (coursenode-course-id a-cn)
                                (coursenode-title a-cn)
                                (coursenode-instructor a-cn)
                                (listofstudent-fcn (coursenode-students a-cn))
                                (coursenode-fcn (coursenode-left a-cn))
                                (coursenode-fcn (coursenode-right a-cn)))]))

;QUESTION 4
;any-taught-by?: BST String -> Boolean
; conumes a CourseNode BST (binary search tree) and name of an instrctor (String) and produces true if the instructor teachs any of the courses
(check-expect (any-taught-by? false "") false)
(check-expect (any-taught-by? false "Hello") false)
(check-expect (any-taught-by? COURSES1 "") false)
(check-expect (any-taught-by? COURSES1 "Mrs. Jackson") true)
(check-expect (any-taught-by? COURSES1 "Hello") false)
(check-expect (any-taught-by? (make-coursenode 50.001 "Math" "Jim" (list BRANDON PARKER) false false) "Jim") true)
(check-expect (any-taught-by? (make-coursenode 50.001 "Math" "Jim" (list BRANDON PARKER)
                                               (make-coursenode 40.001 "Math" "Jim" (list BRANDON PARKER) false false)
                                               (make-coursenode 60.001 "Math" "Jim" (list BRANDON PARKER)
                                                                (make-coursenode 51.001 "Math" "Jeff" (list BRANDON PARKER) false false)
                                                                false))
                              "Jeff") true)
(check-expect (any-taught-by? (make-coursenode 50.001 "Math" "Joe" (list BRANDON PARKER)
                                               (make-coursenode 40.001 "Math" "Geoff" (list BRANDON PARKER) false false)
                                               (make-coursenode 60.001 "Math" "Jim" (list BRANDON PARKER)
                                                                (make-coursenode 51.001 "Math" "Jeff" (list BRANDON PARKER) false false)
                                                                false)) "Matt") false)
;(define (any-taught-by? a-bst a-string) false);stub

(define (any-taught-by? a-cn a-string)
  (cond
    [(boolean? a-cn) false]
    [(coursenode? a-cn) (or (string=? a-string
                                      (coursenode-instructor a-cn))
                            (any-taught-by? (coursenode-left a-cn ) a-string)
                            (any-taught-by? (coursenode-right a-cn) a-string))]))

;QUESTION 5
;drop-student: BST Natural String -> BST
; consumes a BST, course number, and email address of a student — produces a new BST with the student removed
(check-expect (drop-student false 0 "") false)
(check-expect (drop-student (make-coursenode 50.001 "Math" "Jim" (list BRANDON PARKER) false false) 50.001 "sis@wpi.edu")
              (make-coursenode 50.001 "Math" "Jim" (list BRANDON PARKER) false false))
(check-expect (drop-student (make-coursenode 50.001 "Math" "Jim" (list BRANDON PARKER) false false) 49.001 "blui@wpi.edu")
              (make-coursenode 50.001 "Math" "Jim" (list BRANDON PARKER) false false) )
(check-expect (drop-student (make-coursenode 50.001 "Math" "Jim" (list BRANDON PARKER) false false) 50.001 "blui@wpi.edu")
              (make-coursenode 50.001 "Math" "Jim" (list PARKER) false false))
(check-expect (drop-student COURSES2 65.001 "blui@wpi.edu")
              (make-coursenode 40.001 "Computer Engineering" "Jimard" CLASSROSTER0
                               (make-coursenode 20.001 "English" "Jimmy" CLASSROSTER1
                                                false
                                                (make-coursenode 30.001 "Calc" "Jane" CLASSROSTER0
                                                                 false
                                                                 (make-coursenode 35.001 "Chinese" "Jack" CLASSROSTER4 false false)))
                               (make-coursenode 60.001 "French" "Eddy" CLASSROSTER2              
                                                (make-coursenode 50.001 "Robotics" "Taren" CLASSROSTER0 false false)
                                                (make-coursenode 65.001 "Italian" "Rotinssi" (list EMILY JULIE) false false)))
              )
(check-expect (drop-student COURSES0 39.001 "jdoe2@wpi.edu")
              (make-coursenode 60.001 "English" "Olivia" CLASSROSTER3
                               (make-coursenode 20.001 "Math" "Jack Doe" CLASSROSTER5
                                                (make-coursenode 10.001 "Football" "Yoast" CLASSROSTER1
                                                                 false
                                                                 (make-coursenode 15.001 "Track" "Holly" CLASSROSTER0
                                                                                  (make-coursenode 12.001 "Cross" "Jack" CLASSROSTER6 false false)
                                                                                  false))
                                                (make-coursenode 39.001 "Gym" "Jack" (list (make-student "Jane Doe" "jdoe1@wpi.edu") (make-student "Dan D. Lyon" "ddlyon@wpi.edu") (make-student "Jaquavious Smith" "jsmith@wpi.edu") (make-student "Nick Trust" "ntrust@wpi.edu")) false false))
                               (make-coursenode 70.001 "French" "Eddy" CLASSROSTER2
                                                (make-coursenode 65.001 "Chemistry Lab" "Hunt" CLASSROSTER5 false false)
                                                (make-coursenode 75.001 "Ice Hockey" "Smith" CLASSROSTER2 false false))
                               ))
              
              
(check-expect (drop-student COURSES0 39.001 "asdufhisdhf@wpi.edu")
              COURSES0)
(check-expect (drop-student COURSES1 60.001 "pgoodrum@wpi.edu")

              (make-coursenode 50.001 "Math" "Mr. Brown" CLASSROSTER0
                               (make-coursenode 40.001 "English" "Mrs. Jackson" (list JOHNB BRANDON JULIE)
                                                false
                                                (make-coursenode 45.001 "Martial Arts" "Mr. U" (list JESSIE JOHNB PARKER BRANDON)
                                                                 false
                                                                 false))
                               (make-coursenode 60.001 "Foreign Language" "Mr. Kent" (list  BRANDON JULIE)
                                                (make-coursenode 59.001 "Arts" "Mrs. Kent" (list PARKER JESSIE JAQUAVIOUS BRANDON)
                                                                 (make-coursenode 58.001 "Dark Arts" "Dr. Rood" CLASSROSTER3 false false)
                                                                 false)
                                                false)))
              
             
                   
;(define (drop-student a-bst a-nat a-str) false);stub
(define (drop-student a-cn a-nat a-str)
  (cond
    [(boolean? a-cn) false]
    [(coursenode? a-cn) (cond
                          [ (< a-nat (coursenode-course-id a-cn))
                            (make-coursenode (coursenode-course-id a-cn)
                                             (coursenode-title a-cn)
                                             (coursenode-instructor a-cn)
                                             (coursenode-students a-cn)
                                             (drop-student (coursenode-left a-cn) a-nat a-str)
                                             (coursenode-right a-cn))
                            ]
                          [ (> a-nat (coursenode-course-id a-cn))
                            (make-coursenode (coursenode-course-id a-cn)
                                             (coursenode-title a-cn)
                                             (coursenode-instructor a-cn)
                                             (coursenode-students a-cn)
                                             (coursenode-left a-cn)
                                             (drop-student (coursenode-right a-cn) a-nat a-str)
                                             )]
                          [ (= a-nat (coursenode-course-id a-cn))
                            (make-coursenode (coursenode-course-id a-cn)
                                             (coursenode-title a-cn)
                                             (coursenode-instructor a-cn)
                                             (drop-student--los (coursenode-students a-cn) a-str)
                                             (coursenode-left a-cn)
                                             (coursenode-right a-cn))
                            ])]))

; drop-student--los: ListOfStudent String -> ListOfStudent
; consumes a ListOfStudent and a student's email (String), produces a ListOfStudent with the student with matching email removed
(define (drop-student--los a-los a-str)
  (cond
    [(empty? a-los) empty]
    [(cons? a-los) (if (drop-student--keep-stu? (first a-los) a-str)
                       (cons (first a-los) (drop-student--los (rest a-los) a-str))
                       (drop-student--los (rest a-los) a-str))]))
; drop-student--keep-stu?: Student String -> Boolean
; consumes a Student and an email, produces true if student is to be kept (given email does not match student's email) and false otherwise
(define (drop-student--keep-stu? a-student a-str)
  (not (string=? a-str
                 (student-email a-student))
       ))

;QUESTION 6
;a ListOfString is one of
; - empty
; - (cons String ListOfString)

;list-titles-in-order-by-coursenum: BST -> ListOfString
;consumes a binary search tree BST, produces a list of the titles of the courses, sorted in order by ascending course number
(check-expect (list-titles-in-order-by-coursenum (make-coursenode 30.001 "Calc1" "Jane" CLASSROSTER0 false false))
              (list  "Calc1" ))
(check-expect (list-titles-in-order-by-coursenum (make-coursenode 30.001 "Calc1" "Jane" CLASSROSTER0  (make-coursenode 29.001 "Calc0" "Jane" CLASSROSTER0 false false)  (make-coursenode 31.001 "Calc2" "Jane" CLASSROSTER0 false false)))
              (list "Calc0" "Calc1" "Calc2"  ))
(check-expect (list-titles-in-order-by-coursenum COURSES2)
              (list "English" "Calc" "Chinese" "Computer Engineering" "Robotics" "French" "Italian"))
(check-expect (list-titles-in-order-by-coursenum COURSES1)
              (list "English" "Martial Arts" "Math" "Dark Arts" "Arts" "Foreign Language"))

(define (list-titles-in-order-by-coursenum a-bst)
  (cond [(boolean? a-bst) empty]
        [(coursenode? a-bst)
         (append (list-titles-in-order-by-coursenum (coursenode-left a-bst))
                 (cons (coursenode-title a-bst)
                       (list-titles-in-order-by-coursenum (coursenode-right a-bst))))]))


;QUESTION 7
;add-course: BST Number String String -> BST
; consumes a BST, course number (Number), a course title (String), and the name of the instructor (String)
; produces a new BST with a new course added and no student enrollemnt in the new course
(check-expect (add-course COURSES3 40 "Math with Proofs" "Barry Allen" )
              (make-coursenode 50.001 "Russian" "Ryan" CLASSROSTER7
                               (make-coursenode 40 "Math with Proofs" "Barry Allen"  empty false false)
                               (make-coursenode 60.001 "Web Development" "Frank Ocean" CLASSROSTER4
                                                false
                                                false)))
(check-expect (add-course COURSES3 55 "Math with Proofs" "Barry Allen" )
              (make-coursenode 50.001 "Russian" "Ryan" CLASSROSTER7
                               false
                               (make-coursenode 60.001 "Web Development" "Frank Ocean" CLASSROSTER4
                                                (make-coursenode 55 "Math with Proofs" "Barry Allen" empty false false)
                                                false)))
(check-expect (add-course COURSES3 65 "Math with Proofs" "Barry Allen" )
              (make-coursenode 50.001 "Russian" "Ryan" CLASSROSTER7
                               false
                               (make-coursenode 60.001 "Web Development" "Frank Ocean" CLASSROSTER4
                                                false
                                                (make-coursenode 65 "Math with Proofs" "Barry Allen" empty false false))))
(check-expect (add-course COURSES2 67 "Math with Proofs" "Barry Allen" )
              (make-coursenode 40.001 "Computer Engineering" "Jimard" CLASSROSTER0
                               (make-coursenode 20.001 "English" "Jimmy" CLASSROSTER1
                                                false
                                                (make-coursenode 30.001 "Calc" "Jane" CLASSROSTER0
                                                                 false
                                                                 (make-coursenode 35.001 "Chinese" "Jack" CLASSROSTER4 false false)))
                               (make-coursenode 60.001 "French" "Eddy" CLASSROSTER2              
                                                (make-coursenode 50.001 "Robotics" "Taren" CLASSROSTER0 false false)
                                                (make-coursenode 65.001 "Italian" "Rotinssi" CLASSROSTER3
                                                                 false
                                                                 (make-coursenode 67 "Math with Proofs" "Barry Allen" empty false false)))))
(check-expect (add-course COURSES2 62.5 "Math with Proofs" "Barry Allen" )
              (make-coursenode 40.001 "Computer Engineering" "Jimard" CLASSROSTER0
                               (make-coursenode 20.001 "English" "Jimmy" CLASSROSTER1
                                                false
                                                (make-coursenode 30.001 "Calc" "Jane" CLASSROSTER0
                                                                 false
                                                                 (make-coursenode 35.001 "Chinese" "Jack" CLASSROSTER4 false false)))
                               (make-coursenode 60.001 "French" "Eddy" CLASSROSTER2              
                                                (make-coursenode 50.001 "Robotics" "Taren" CLASSROSTER0 false false)
                                                (make-coursenode 65.001 "Italian" "Rotinssi" CLASSROSTER3
                                                                 (make-coursenode 62.5 "Math with Proofs" "Barry Allen" empty false false)
                                                                 false))))
;(define (add-course a-bst a-num title instructor) false);stub

(define (add-course a-cn coursenum title instructor)
  (cond
    [(boolean? a-cn) (make-coursenode coursenum title instructor empty false false)]
    [(coursenode? a-cn)  (cond
                           [(< coursenum (coursenode-course-id a-cn))
                            (make-coursenode (coursenode-course-id a-cn)
                                             (coursenode-title a-cn)
                                             (coursenode-instructor a-cn)
                                             (coursenode-students a-cn)
                                             (add-course (coursenode-left a-cn) coursenum title instructor)
                                             (coursenode-right a-cn) )]
                           [(> coursenum (coursenode-course-id a-cn))
                            (make-coursenode (coursenode-course-id a-cn)
                                             (coursenode-title a-cn)
                                             (coursenode-instructor a-cn)
                                             (coursenode-students a-cn)
                                             (coursenode-left a-cn)
                                             (add-course (coursenode-right a-cn) coursenum title instructor)
                                             )])]))