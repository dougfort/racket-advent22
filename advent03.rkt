#lang racket

(require racket/set)
(require "advent03-data.rkt")

(define (shared-item l)
  (let-values ([(lhs rhs) (split-at l (quotient (length l) 2))])
    (first (set->list (set-intersect (list->set lhs) (list->set rhs))))))

(define (sum-of-priorities d)
  (for/sum ([i (in-list d)])
    (priority (shared-item i))))

(sum-of-priorities test-data)
(sum-of-priorities data)

