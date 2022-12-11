#lang racket

;; 

(provide test-data data)

(define (parse d)
  (map string-split (string-split (string-trim d) "\n")))

(define raw-test-data
  "
A Y
B X
C Z
")
(define test-data (parse raw-test-data))

(define raw-data
  (port->string (open-input-file "advent02.data") #:close? #t))
(define data (parse raw-data))
