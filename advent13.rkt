#lang racket

;; 

(require "advent13-data.rkt")

(module+ test
  (require rackunit))

; returns #f if the packets are out of order
(define (compare-lists l1 l2)
  ; pad the lists to the same size
  (define length-delta (- (length l1) (length l2)))
  (define-values (l1p l2p) (cond
                             [(negative? length-delta)
                              (values (append l1 (make-list (abs length-delta) #f)) l2)]
                             [(zero? length-delta)
                              (values l1 l2)]
                             [else
                              (values l1 (append l2 (make-list length-delta #f)))]))
  (unless (= (length l1p) (length l2p))
    (error (format "lists of differing size ~s ~s" l1p l2p))) 
  (for/and ([lhs (in-list l1p)]
            [rhs (in-list l2p)]
            ; If both values are integers, the lower integer should come first.
            #:break (and (number? lhs) (number? rhs) (< lhs rhs)))
            (cond
              ; If the left list runs out of items first, the inputs are in the right order
              [(not lhs) #t]
              ; If the right list runs out of items first, the inputs are not in the right order
              [(not rhs) #f]
              [else
               (cond
                 ; If the left integer is higher than the right integer, the inputs are not in the right order.
                 [(and (number? lhs) (number? rhs) (> lhs rhs)) #f]
                 ; if the inputs are the same integer; continue checking the next part of the input.
                 [(and (number? lhs) (number? rhs) (= lhs rhs)) #t]
                 ; If exactly one value is an integer, convert the integer to a list
                 [(and (number? lhs) (list? rhs)) (compare-lists (list lhs) rhs)]
                 [(and (list? lhs) (number? rhs)) (compare-lists lhs (list rhs))]
                 [(and (list? lhs) (list? rhs)) (compare-lists lhs rhs)]
                 [else (error (format "unknown input lhs=~s; rhs=~s\n" lhs rhs))])])))                                            

(module+ test
  (check-true (compare-lists '() '()) "both lists empty") ; 
  (check-false (compare-lists '(()) '()) "right list runs out first")
  (check-false (compare-lists '(() ()) '()) "right list runs out first")
  (check-true (compare-lists '() '(())) "left list runs out first")
  (check-true (compare-lists '() '(() ())) "left list runs out first")
  (check-false (compare-lists '(1) '(0)) "left integer is higher")
  (check-true (compare-lists '(1 1 3 1 1) '(1 1 5 1 1)))
  (check-true (compare-lists '((1) (2 3 4)) '((1) 4)))
  (check-false (compare-lists '(9) '((8 7 6))))
  (check-true (compare-lists '((4 4) 4 4) '((4 4) 4 4 4)))
  (check-false (compare-lists '(1 (2 (3 (4 (5 6 7)))) 8 9) '(1 (2 (3 (4 (5 6 0)))) 8 9)))
  (check-true (compare-lists '(4) '((4))))
  (check-true (compare-lists '((4)) '((4))))
  (check-true (compare-lists '((4)) '(4)))
  (check-false (compare-lists '(((7 0 7 3)) () (6 1 (0) 9)) '(((8 10 9)) (7 (7 () (9 3 6) (1 2 4 7))) (0 2 ())))))

; returns #f if the packets are out of order
(define (compare-packets p1 p2)  ; we expect each packet to be wrapped in a list at thsi point
  (unless (and (list? p1) (list? p2))
    (error (format "expecting packts to be lists ~s ~s" p1 p2)))
  (let ([in-order (compare-lists p1 p2)])
    (unless #t ; in-order
      (printf "out of order ~s\n" p1)
      (printf "             ~s\n" p2))
    in-order))

(define (compare d)
  (for/list ([i (in-naturals)]
             [x (in-list d)]
             #:when (compare-packets (first x) (second x)))
;    (printf "in-order ~s ~s\n" i x)
    (add1 i)))

(module+ test
  (check-equal? 13 (apply + (compare test-data))))
(apply + (compare data))
