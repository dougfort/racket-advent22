#lang racket

(require "advent01-data.rkt")

(define (list-of-sums d)
  (map (λ (x) (apply + x)) d))

(define (max-calories d)
  (apply max (list-of-sums d)))

(define (sum-top-three d)
  (apply + (take (sort (list-of-sums d) >) 3)))