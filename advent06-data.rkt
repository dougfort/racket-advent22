#lang racket

;; 

(provide raw-test-data raw-data)

(define raw-test-data
  "
mjqjpqmgbljsphdztnvjfqwrcgsmlb
")

(define raw-data
  (port->string (open-input-file "advent06.data") #:close? #t))
