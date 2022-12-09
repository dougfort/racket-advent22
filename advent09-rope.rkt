#lang racket


;; 

(provide make-rope move-rope rope-tail)

(module+ test
  (require rackunit))

;; a point is a pair (x . y)
;; a rope is a pair of points (head . tail)

;; return  a rope with both head and til at the origin
(define (make-rope)
  (cons (cons 0 0) (cons 0 0)))

;; return the head of the rope
(define (rope-head rope)
  (car rope))

;; return the tail of the rope
(define (rope-tail rope)
  (cdr rope))

;; add the move-vector to the point
(define (move-point point move-vector)
  (cons (+ (car point) (car move-vector)) (+ (cdr point) (cdr move-vector))))

;; return a move-vector that will move p1 to p2
(define (compute-distance p1 p2)
  (cons (- (car p2) (car p1)) (- (cdr p2) (cdr p1))))


(define (is-touching? dist-vector)
  (and (<= (abs (car dist-vector)) 1) (<= (abs (cdr dist-vector)) 1)))

;; move the tail to pursue the head, folowing the rules
(define (move-tail tail-point dist-vector)
  (cond
    [(is-touching? dist-vector) tail-point]    
    ; If the head is ever two steps directly up, down, left, or right from the tail,
    ; the tail must also move one step in that direction so it remains close enough:
    ; we divide by 2 to preserve the sign
    [(zero? (car dist-vector))
     (cons (car tail-point) (+ (cdr tail-point) (quotient (cdr dist-vector) 2)))] 
    [(zero? (cdr dist-vector))
     (cons (+ (car tail-point) (quotient (car dist-vector) 2)) (cdr tail-point))]
    ; if the head and tail aren't touching and aren't in the same row or column,
    ; the tail always moves one step diagonally to keep up
    [else
     (cons
      (+ (car tail-point) (if (negative? (car dist-vector)) -1 1))
      (+ (cdr tail-point) (if (negative? (cdr dist-vector)) -1 1)))]))

(module+ test
  (check-equal? (cons 1 1) (move-tail (cons 1 1) (cons 0 0)))
  (check-equal? (cons 1 2) (move-tail (cons 1 1) (cons 0 2)))
  (check-equal? (cons 2 1) (move-tail (cons 1 1) (cons 2 0)))
  (check-equal? (cons 2 2) (move-tail (cons 1 1) (cons 2 2))))

 
;; move the rope by moving the head and then movint the tail to catch up
(define (move-rope rope move-vector)
  (define next-head (move-point (rope-head rope) move-vector))
  (define dist-vector (compute-distance (rope-tail rope) next-head))
  (define next-tail (move-tail (rope-tail rope) dist-vector))
  (cons next-head next-tail))

(module+ test
  (test-begin
   (define moves '(
                   (1 . 0)
                   (1 . 0)
                   (1 . 0)
                   (1 . 0)
                   (0 . 1)
                   (0 . 1)
                   (0 . 1)
                   (0 . 1)
                   (-1 . 0)
                   (-1 . 0)
                   (-1 . 0)))
   (define expecteds '(
                       (0 . 0)
                       (1 . 0)
                       (2 . 0)
                       (3 . 0)
                       (3 . 0)
                       (4 . 1)
                       (4 . 2)
                       (4 . 3)
                       (4 . 3)
                       (3 . 4)
                       (2 . 4)))
   (for/fold ([rope (make-rope)])
             ([i (in-naturals)]
              [move (in-list moves)]
              [expected (in-list expecteds)])
     (let ([next-rope (move-rope rope move)])
       (check-equal? (rope-tail next-rope) expected (format "~s) ~s -> ~s" i rope next-rope))
       next-rope))))
