#lang racket

(require racket/set)
(require "advent03-data.rkt")

(define (shared-item l)
  (let-values ([(lhs rhs) (split-at l (quotient (length l) 2))])
    (first (set->list (set-intersect (list->set lhs) (list->set rhs))))))

(define (sum-of-shared-item-priorities d)
  (for/sum ([i (in-list d)])
    (priority (shared-item i))))

(sum-of-shared-item-priorities test-data)
(sum-of-shared-item-priorities data)

(define (find-badge-in lhs)
  (let ([l (list->set (first lhs))]
        [m (list->set (second lhs))]
        [r (list->set (third lhs))])
    (first (set->list (set-intersect l m r)))))

(define (sum-of-badge-priorities d)
  (let loop ([acc 0]
             [lhs (take d 3)]
             [rhs (drop d 3)])
    (let ([s (priority (find-badge-in lhs))])
        (if (empty? rhs)
            (+ acc s)
            (loop (+ acc s) (take rhs 3) (drop rhs 3)))))) 
         
          
    
             
              
          
