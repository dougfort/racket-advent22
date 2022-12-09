#lang racket

;; 

(require "advent09-data.rkt")
(require "advent09-rope.rkt")

(module+ test
  (require rackunit))

(define (rope-journey n start moves)
  (define rope (make-rope n start))
  (define db (make-hash (list (cons start #t))))
  (for/fold ([rope rope]
             [db db]
             #:result db)
            ([move (in-list moves)])
    (let ([next-rope (move-rope rope move)])
      (hash-set! db (last next-rope) #t)
      (values next-rope db))))

(hash-count (rope-journey 2 '(0 . 0) test-2rope-data))
(hash-count (rope-journey 2 '(0 . 0) data))
(hash-count (rope-journey 10 '(0 . 0) test-2rope-data))
(hash-count (rope-journey 10 '(11 . 5) test-10rope-data))
(hash-count (rope-journey 10 '(0 . 0) data))
