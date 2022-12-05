#lang racket

;; 

(require "advent05-data.rkt")

(define (from-pos s)
  (- (step-from s) 1))

(define (to-pos s)
  (- (step-to s) 1))

(define (rearrange-stacks model crates directions)
  (let ([fix-taken
         (cond
           [(equal? model "9000") (λ (x) (reverse x))]
           [(equal? model "9001") (λ (x) x)]
           [else (error (format ("unknown model ~s" model)))])])
    (for ([s (in-list directions)])
      (let-values ([(taken remain) (split-at (vector-ref crates (from-pos s)) (step-count s))])
        (vector-set! crates (from-pos s) remain)
        (vector-set! crates (to-pos s) (append (fix-taken taken) (vector-ref crates (to-pos s))))))
    crates))

(define (message crates)
  (list->string (map first (vector->list crates))))

(message (rearrange-stacks "9000" (vector-copy test-crates) test-directions))
(message (rearrange-stacks "9000" (vector-copy crates) directions))
(message (rearrange-stacks "9001" (vector-copy test-crates) test-directions))
(message (rearrange-stacks "9001" (vector-copy crates) directions))
