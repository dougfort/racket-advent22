#lang racket

;; 

(require "advent10-data.rkt")

(module+ test
  (require rackunit))

(define (probe? cycle)
  (cond
    [(< cycle 20) #f]
    [(= cycle 20) #t]
    [else (zero? (remainder (- cycle 20) 40))]))

(define (analyze-cpu d)
  (for/fold ([acc empty]             
             [cycle 1]
             [x 1]
             #:result (reverse acc))
            ([v (in-list d)])
    (cond
      [(null? v)
       (if (probe? cycle)
           (values (cons (cons cycle x) acc) (add1 cycle) x)
           (values acc (add1 cycle) x))]
      [else
       (cond
         [(probe? cycle)
          (values (cons (cons cycle x) acc) (+ cycle 2) (+ x v))]
         [(probe? (add1 cycle))
          (values (cons (cons (add1 cycle) x) acc) (+ cycle 2) (+ x v))]
         [else (values acc (+ cycle 2) (+ x v))])])))

(define (sum-of-signal-strengths l)
  (for/sum ([p (in-list l)])
    (* (car p) (cdr p))))

(sum-of-signal-strengths (analyze-cpu test-data))
(sum-of-signal-strengths (analyze-cpu data))
