#lang racket

;; 

(require "advent02-data.rkt")

(define shape-symbols #hash(("A" . 'rock) ("B" . 'paper) ("C" . 'scissors)))
(define (shape-symbol s)
  (hash-ref shape-symbols s))

(define first-strategy-symbols #hash(("X" . 'rock) ("Y" . 'paper) ("Z" . 'scissors)))
(define (first-strategy-symbol s)
  (hash-ref first-strategy-symbols s))

(define second-strategy-symbols #hash(("X" . 'lose) ("Y" . 'draw) ("Z" . 'win)))
(define (second-strategy-symbol s)
  (hash-ref second-strategy-symbols s))

(define second-strategy-choices #hash(
                        (('rock . 'win) . 'paper)
                        (('rock . 'lose) . 'scissors)
                        (('rock . 'draw) . 'rock)
                        (('scissors . 'win) . 'rock)
                        (('scissors . 'lose) . 'paper)
                        (('scissors . 'draw) . 'scissors)
                        (('paper . 'win) . 'scissors)
                        (('paper . 'lose) . 'rock)
                        (('paper . 'draw) . 'paper)))
(define (second-strategy-choice op se)
  (hash-ref second-strategy-choices (cons op se)))

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

(define (first-total-score l)
  (for*/sum ([p (in-list l)])
    (let ([op (shape-symbol(first p))]
          [se (first-strategy-symbol (second p))])
      (round-score op se))))

(define (second-total-score l)
  (for*/sum ([p (in-list l)])
    (let* ([op (shape-symbol(first p))]
          [se (second-strategy-choice op (second-strategy-symbol (second p)))])
      (round-score op se))))

(first-total-score test-data)
(first-total-score data)

(second-total-score test-data)
(second-total-score data)