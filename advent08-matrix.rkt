#lang racket

;; 

(provide make-matrix matrix-width matrix-ref)

;; expect a list of rows, each of which is a list of column entries
(define (make-matrix row-list)
  (define width (length (car row-list)))
  (define pos (λ (r c) (+ (* r width) c)))
  (define vec (make-vector (* width width) 0))
  (for ([row (in-naturals)]
        [col-list (in-list row-list)])
    (for ([col (in-naturals)]
          [col-value (in-list col-list)])
      (vector-set! vec (pos row col) col-value)))
  vec)

(define (matrix-width matrix)
  (sqrt (vector-length matrix)))

;; the value of the matrix at (row . col)
(define (matrix-ref matrix loc)
  (define width (sqrt (vector-length matrix)))
  (define pos (λ (loc) (+ (* (car loc) width) (cdr loc))))
  (vector-ref matrix (pos loc)))
