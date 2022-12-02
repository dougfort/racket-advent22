#lang racket

(require "advent02-data.rkt")

(define shape-symbols #hash(("A" . 'rock) ("B" . 'paper) ("C" . 'scissors)))
(define (shape-symbol s)
  (hash-ref shape-symbols s))

(define strategy-symbols #hash(("X" . 'rock) ("Y" . 'paper) ("Z" . 'scissors)))
(define (strategy-symbol s)
  (hash-ref strategy-symbols s))

(define shape-scores #hash(('rock . 1) ('paper . 2) ('scissors . 3)))

(define (shape-score sh) 
  (hash-ref shape-scores sh))

(define outcome-scores #hash(
                        (('rock . 'rock) . 3)
                        (('rock . 'scissors) . 0)
                        (('rock . 'paper) . 6)
                        (('scissors . 'rock) . 6)
                        (('scissors . 'scissors) . 3)
                        (('scissors . 'paper) . 0)
                        (('paper . 'rock) . 0)
                        (('paper . 'scissors) . 6)
                        (('paper . 'paper) . 3)))

(define (outcome-score op se)
  (hash-ref outcome-scores (cons op se)))

(define (round-score op se)
  (+ (shape-score se) (outcome-score op se)))

(define (total-score l)
  (apply + (map (λ (p) (round-score (shape-symbol(first p)) (strategy-symbol (second p)))) l)))

(total-score test-data)
(total-score data)