#lang racket

;; 

(provide test-data data)

(define (parse raw)
  (for/list ([rs (string-split (string-trim raw) "\n\n")])
    (map string->number (string-split rs))))

(define raw-test-data
  (port->string (open-input-file "advent01-test.data") #:close? #t))
(define test-data (parse raw-test-data))

(define raw-data
  (port->string (open-input-file "advent01.data") #:close? #t))
(define data (parse raw-data))
