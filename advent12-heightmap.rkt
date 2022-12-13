#lang racket

;; 

(provide
 heightmap
 heightmap-start-pos
 heightmap-end-pos
 heightmap-neighbors
 heightmap-ref
 heightmap-low-points)

(struct heightmap (height width vec start-pos end-pos)
  #:transparent)

; convert a pos to row and column
(define (heightmap-row-col hm pos)
  (values (quotient pos (heightmap-width hm)) (remainder pos (heightmap-width hm))))

(define (heightmap-pos hm r c)
  (+ (* r (heightmap-width hm)) c))

(define (heightmap-ref hm pos)
  (vector-ref (heightmap-vec hm) pos))

;; returns a list pos for < left  ^ up > right v down
(define (heightmap-neighbors hm pos)
  (define-values (r c) (heightmap-row-col hm pos))
  (define left (if (zero? c) #f (heightmap-pos hm r (- c 1))))
  (define up (if (zero? r) #f (heightmap-pos hm (- r 1) c)))
  (define right (if (= c (- (heightmap-width hm) 1)) #f (heightmap-pos hm r (add1 c))))
  (define down (if (= r (- (heightmap-height hm) 1)) #f (heightmap-pos hm (add1 r) c)))
  (filter (λ (x) x) (list left up right down)))

;; returns a list of the positions of all the lowest ('a') points in the heightmap
(define (heightmap-low-points hm)
  (for/list ([i (in-naturals)]
             [val (in-list (vector->list (heightmap-vec hm)))]
             #:when (= val 1))
    i))