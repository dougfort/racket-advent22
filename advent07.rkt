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

(define needed-space 30000000)

(define (size-to-delete fs)
  (define unused-space (- total-space (fs-dir-size fs root-path)))  
  (apply min (filter (λ (x) (> (+ unused-space x) needed-space))  (fs-dir-sizes fs))))

(size-to-delete test-fs)
(size-to-delete fs)