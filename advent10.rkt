#lang racket

;; 

(require "advent10-data.rkt")

(module+ test
  (require rackunit))

(define (cycle-cpu d)
  (for/fold ([acc empty]             
             [cycle 1]
             [x 1]
             #:result (reverse acc))
            ([v (in-list d)])
    (cond
      [(null? v)
       (values (cons x acc) (add1 cycle) x)]
      [else
       (let ([acc (cons x acc)]) 
         (values (cons x acc) (+ cycle 2) (+ x v)))])))

(define (probe? cycle)
  (cond
    [(< cycle 20) #f]
    [(= cycle 20) #t]
    [else (zero? (remainder (- cycle 20) 40))]))

(define (sum-of-signal-strengths l)
  (for/sum ([i (in-naturals)]
            [p (in-list l)])
    (if (probe? (add1 i))
        (* (add1 i) p)
        0)))
    
(sum-of-signal-strengths (cycle-cpu test-data))
(sum-of-signal-strengths (cycle-cpu data))
