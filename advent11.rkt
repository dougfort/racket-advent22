#lang racket

;; 

(require "advent11-data.rkt")

(module+ test
  (require rackunit))

; in a turn, a monkey examines each item in its queue
; and returns a list of pairs of (new-worry-level . next-monkey)
(define (turn monkey queue)
  (for/list ([worry-level (in-list queue)])
    (monkey worry-level)))
    
;; in a round, each monkey takes a turn in order
(define (round monkeys scores queue-vec)
  (let ([new-scores (for/list ([i (in-naturals)]
                               [monkey (in-list monkeys)]
                               [old-score (in-list scores)])
                      (let ([queue (vector-ref queue-vec i)])
                        (for ([pr (in-list (turn monkey queue))])
                          (let* ([worry-level (car pr)]
                                 [j (cdr pr)])
                            (vector-set! queue-vec j (append (vector-ref queue-vec j) (list worry-level))))
                          (vector-set! queue-vec i empty))
                        (+ old-score (length queue))))])
    (values new-scores queue-vec)))

(define (watch-monkeys n d)
  (define queue-vec (make-vector (length d) empty))
  (let ([monkeys (for/list ([i (in-naturals)]
                            [pr (in-list d)])                 
                   (let ([monkey (first pr)]
                         [queue (second pr)])
                     (vector-set! queue-vec i queue)
                     monkey))])
    (let loop ([i 0]
               [scores (make-list (length monkeys) 0)]
               [queue-vec queue-vec])
      (let-values ([(new-scores queue-vec) (round monkeys scores queue-vec)])
        (let ([next-i (add1 i)])
          (if (= next-i n)
              new-scores
              (loop next-i new-scores queue-vec)))))))
               
(define (monkey-business d)
  (let ([scores (take (sort (watch-monkeys 20 d) >) 2)])
    (* (first scores) (second scores))))

(monkey-business test-data)
(monkey-business data)