#lang racket

;; 

(provide test-data data)

(define (parse d)
  (for/list ([row (string-split (string-trim d) "\n")])
    (for/list ([ch (string->list row)])
      (let ([zero (char->integer #\0)])
        (- (char->integer ch) zero)))))

(define raw-test-data
  "
30373
25512
65332
33549
35390
")
(define test-data (parse raw-test-data))

(define raw-data
  (port->string (open-input-file "advent08.data") #:close? #t))

(define data (parse raw-data))
