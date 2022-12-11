#lang racket
;; 

(provide test-crates test-directions crates directions step-count step-from step-to)

(define (parse-crates raw width)
  (define raw-list (string-split raw "\n"))
  (define truncated-list (take raw-list (- (length raw-list) 1)))
  (define vec (make-vector width null))
  (for ([line (in-list truncated-list)])
    (for ([i (in-range (vector-length vec))])
      (let ([j (add1 (* i 4))])
        (let ([ch (string-ref line j)])
          (unless (char-whitespace? ch)
            (vector-set! vec i (cons ch (vector-ref vec i))))))))
  (vector-map reverse vec))

(struct step (count from to)
  #:transparent)

(define (parse-directions raw)
  (for/list ([line (string-split raw "\n")])
    (let* ([split-line (string-split line)]
           [split-line-num (map string->number split-line)])
      (step (list-ref split-line-num 1) (list-ref split-line-num 3) (list-ref split-line-num 5)))))
  
(define raw-test-data
  "
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
")
(define raw-test-crates (first (string-split raw-test-data "\n\n")))
(define test-crates (parse-crates raw-test-crates 3))
(define raw-test-directions (second (string-split raw-test-data "\n\n")))
(define test-directions (parse-directions raw-test-directions))

(define raw-data
  (port->string (open-input-file "advent05.data") #:close? #t))

(define raw-crates (first (string-split raw-data "\n\n")))
(define crates (parse-crates raw-crates 9))
(define raw-directions (second (string-split raw-data "\n\n")))
(define directions (parse-directions raw-directions))
