#lang racket

;; 

(require "advent08-data.rkt")
(require "advent08-matrix.rkt")

(module+ test
  (require rackunit))

(define (visibles matrix trav)
  (for/fold ([acc empty]
             [prev -1]
             #:result acc)
            ([loc (in-list trav)])
    (let ([val (matrix-ref matrix loc)])
      (if (> val prev)
          (values (cons loc acc) val)
          (values acc prev)))))

;; a list of (row . col) pairs to traverse a row from left to right
(define (left-traversal width row)
  (for/list ([col (in-range width)])
    (cons row col)))

;; a list of (row . col) pairs to traverse a row from right to left
(define (right-traversal width row)
  (for/list ([col (in-inclusive-range (- width 1) 0 -1)])
    (cons row col)))

;; a list of (row . col) pairs to traverse a column from top to bottom
(define (top-traversal width col)
  (for/list ([row (in-range width)])
    (cons row col)))

;; a list of (row . col) pairs to traverse a row from bottom to top
(define (bottom-traversal width col)
  (for/list ([row (in-inclusive-range (- width 1) 0 -1)])
    (cons row col)))

(define (find-visible d)
  (define visible-set (make-hash))
  (define matrix (make-matrix d))
  (define width (matrix-width matrix))
  (for ([row (in-range width)])
    (let ([v (visibles matrix (left-traversal width row))])
      (for-each (λ (loc) (hash-set! visible-set loc #t)) v))
    (let ([v (visibles matrix (right-traversal width row))])
      (for-each (λ (loc) (hash-set! visible-set loc #t)) v)))
  (for ([col (in-range width)])
    (let ([v (visibles matrix (top-traversal width col))])
      (for-each (λ (loc) (hash-set! visible-set loc #t)) v))
    (let ([v (visibles matrix (bottom-traversal width col))])
      (for-each (λ (loc) (hash-set! visible-set loc #t)) v)))
  visible-set)

(hash-count (find-visible test-data))
(hash-count (find-visible data))

(define (left-viewing-distance matrix loc)
  (define row (car loc))
  (define col (cdr loc))
  (define val (matrix-ref matrix loc))
  (if (zero? col)
      0
      (let ([block-col (for/or ([c (in-inclusive-range (- col 1) 0 -1)])
                         (let ([block-val (matrix-ref matrix (cons row c))])
                           (if (>= block-val val)
                               c
                               #f)))])
        (if block-col
            (- col block-col)
            col))))

(define (right-viewing-distance matrix loc)
  (define row (car loc))
  (define col (cdr loc))
  (define right-boundary (- (matrix-width matrix) 1))
  (define val (matrix-ref matrix loc))
  (if (= col right-boundary)
      0
      (let ([block-col (for/or ([c (in-inclusive-range (add1 col) right-boundary)])
                         (let ([block-val (matrix-ref matrix (cons row c))])
                           (if (>= block-val val)
                               c
                               #f)))])
        (if block-col
            (- block-col col)
            (- right-boundary col)))))

(define (up-viewing-distance matrix loc)
  (define row (car loc))
  (define col (cdr loc))
  (define val (matrix-ref matrix loc))
  (if (zero? row)
      0
      (let ([block-row (for/or ([r (in-inclusive-range (- row 1) 0 -1)])
                         (let ([block-val (matrix-ref matrix (cons r col))])
                           (if (>= block-val val)
                               r
                               #f)))])
        (if block-row
            (- row block-row)
            row))))

(define (down-viewing-distance matrix loc)
  (define row (car loc))
  (define col (cdr loc))
  (define bottom-boundary (- (matrix-width matrix) 1))
  (define val (matrix-ref matrix loc))
  (if (= row bottom-boundary)
      0
      (let ([block-row (for/or ([r (in-inclusive-range (add1 row) bottom-boundary)])
                         (let ([block-val (matrix-ref matrix (cons r col))])
                           (if (>= block-val val)
                               r
                               #f)))])
        (if block-row
            (- block-row row)
            (- bottom-boundary row)))))

(define (viewing-distances matrix loc)
  (for/list ([f (list up-viewing-distance
              down-viewing-distance
              left-viewing-distance
              right-viewing-distance)])
    (f matrix loc)))

(define (scenic-score matrix loc)
  (apply * (viewing-distances matrix loc)))

(define (scenic-scores d)
  (define matrix (make-matrix d))
  (define width (matrix-width matrix))
  (for*/list ([row (in-range width)]
              [col (in-range width)])
    (scenic-score matrix (cons row col))))

(apply max (scenic-scores test-data))
(apply max (scenic-scores data))