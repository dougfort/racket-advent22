#lang racket

;; 

(require "advent07-filesystem.rkt")
(require "advent07-data.rkt")

(module+ test
  (require rackunit))

(define (sum-low-dirs fs)
  (apply + (filter (λ (x) (<= x 100000)) (fs-dir-sizes fs))))

(sum-low-dirs test-fs)
(sum-low-dirs fs)