#lang racket

;; 

(require "advent10-data.rkt")

(module+ test
  (require rackunit))

(define (cycle-cpu d)
  (for/fold ([acc empty]             
             [cycle 1]
             [x 1]
             #:result (reverse acc))
            ([v (in-list d)])
    (cond
      [(null? v)
       (values (cons x acc) (add1 cycle) x)]
      [else
       (let ([acc (cons x acc)]) 
         (values (cons x acc) (+ cycle 2) (+ x v)))])))

(define (probe? cycle)
  (cond
    [(< cycle 20) #f]
    [(= cycle 20) #t]
    [else (zero? (remainder (- cycle 20) 40))]))

(define (sum-of-signal-strengths l)
  (for/sum ([i (in-naturals)]
            [p (in-list l)])
    (if (probe? (add1 i))
        (* (add1 i) p)
        0)))
    
(sum-of-signal-strengths (cycle-cpu test-data))
(sum-of-signal-strengths (cycle-cpu data))

(define crt-width 40)
(define crt-height 6)

(define (in-sprite? pos x)
  (for/or ([i (in-inclusive-range (- x 1) (+ x 1))])
    (= pos i)))

(define (load-crt-buffer l)
  (define buffer-size (* crt-width crt-height))
  (for/vector #:length buffer-size ([i (in-range buffer-size)]
                                    [x (in-list l)])
    (if  (in-sprite? (remainder i crt-width) x)
         #\#
         #\.)))
    
(define (display-crt buffer)
  (let loop ([buf-list (vector->list buffer)])
    (unless (empty? buf-list)
      (let-values ([(h t) (split-at buf-list crt-width)])
        (println (list->string h))
        (loop t)))))

(display-crt (load-crt-buffer (cycle-cpu test-data)))
(display-crt (load-crt-buffer (cycle-cpu data)))