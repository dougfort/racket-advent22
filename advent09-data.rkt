#lang racket

;; 

(provide test-2rope-data test-10rope-data data)

;; return a vector pair to add to a location
(define (create-move s)
  (cond
    [(equal? s "L") (cons -1 0)]
    [(equal? s "R") (cons  1 0)]
    [(equal? s "U") (cons  0 1)]
    [(equal? s "D") (cons  0 -1)]
    [else (error (format "unknown move ~s" s))]))

;; return a list of move vectors 
(define (create-moves s)
  (define l (string-split s))
  (make-list (string->number (second l)) (create-move (first l)))) 
    
;; return a consolidated list of move vectors
(define (parse d)
  (for/fold ([acc empty])
            ([s (string-split (string-trim d) "\n")])
  (append acc (create-moves s))))

(define raw-test-2rope-data
  "
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
")
(define test-2rope-data (parse raw-test-2rope-data))

(define raw-test-10rope-data
  "
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
")
(define test-10rope-data (parse raw-test-10rope-data))

(define raw-data
  (port->string (open-input-file "advent09.data") #:close? #t))

(define data (parse raw-data))
