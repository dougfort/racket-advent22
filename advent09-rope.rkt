#lang racket


;; 

(provide make-rope move-rope)

(module+ test
  (require rackunit))

;; a point is a pair (x . y)
;; a rope is a list of knots at points (head ...)

;; return  a rope with all knots at the start
(define (make-rope n start)
  (make-list n start))

;; add the move-vector to the knot
(define (move-point point move-vector)
  (cons (+ (car point) (car move-vector)) (+ (cdr point) (cdr move-vector))))

;; return a move-vector that will move p1 to p2
(define (compute-distance p1 p2)
  (cons (- (car p2) (car p1)) (- (cdr p2) (cdr p1))))

(define (is-touching? dist-vector)
  (and (<= (abs (car dist-vector)) 1) (<= (abs (cdr dist-vector)) 1)))

;; move the knot to pursue the preceding knot, folowing the rules
(define (move-knot knot-point dist-vector)
  (cond
    [(is-touching? dist-vector) knot-point]    
    ; If the prev is ever two steps directly up, down, left, or right from this knot,
    ; this knot must also move one step in that direction so it remains close enough:
    [(zero? (car dist-vector))
     (cons (car knot-point) (+ (cdr knot-point) (if (negative? (cdr dist-vector)) -1 1)))] 
    [(zero? (cdr dist-vector))
     (cons (+ (car knot-point) (if (negative? (car dist-vector)) -1 1)) (cdr knot-point))]
    ; if the prev and this knot aren't touching and aren't in the same row or column,
    ; this knot always moves one step diagonally to keep up
    [else
     (cons
      (+ (car knot-point) (if (negative? (car dist-vector)) -1 1))
      (+ (cdr knot-point) (if (negative? (cdr dist-vector)) -1 1)))]))

(module+ test
  (check-equal? (cons 1 1) (move-knot (cons 1 1) (cons 0 0)))
  (check-equal? (cons 1 2) (move-knot (cons 1 1) (cons 0 2)))
  (check-equal? (cons 2 1) (move-knot (cons 1 1) (cons 2 0)))
  (check-equal? (cons 2 2) (move-knot (cons 1 1) (cons 2 2))))

 
;; move the rope by moving the head and then moving each node to catch up
(define (move-rope rope move-vector)
  (for/fold ([acc (list (move-point (car rope) move-vector))]
             #:result (reverse acc))
            ([knot (in-list (cdr rope))])
    (let ([dist-vector (compute-distance knot (car acc))])
      (cons (move-knot knot dist-vector) acc))))

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
                       ((0 . 0))
                       ((1 . 0))
                       ((2 . 0))
                       ((3 . 0))
                       ((3 . 0))
                       ((4 . 1))
                       ((4 . 2))
                       ((4 . 3))
                       ((4 . 3))
                       ((3 . 4))
                       ((2 . 4))))
   (for/fold ([rope (make-rope 2 (cons 0 0))])
             ([i (in-naturals)]
              [move (in-list moves)]
              [expected (in-list expecteds)])
     (let ([next-rope (move-rope rope move)])
       (check-equal? (cdr next-rope) expected (format "~s) ~s -> ~s" i rope next-rope))
       next-rope))))
