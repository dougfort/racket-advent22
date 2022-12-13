#lang racket

;; 

(require "advent12-heightmap.rkt")

(provide test-heightmap live-heightmap)

(define (parse raw)
  (define split-data (map string->list (string-split (string-trim raw) "\n")))
  (define height (length split-data))
  (define width (length (first split-data)))
  (define vec (make-vector  (* height width)))
  (define-values (start-pos end-pos) (for/fold ([sp 0]
                                                [ep 0]
                                                #:result (values sp ep))
                                      ([i (in-naturals)]
                                      [ch (in-list (flatten split-data))])
                (cond
                  [(equal? ch #\S)
                   (vector-set! vec i 1)
                   (values i ep)]                
                  [(equal? ch #\E)
                   (vector-set! vec i 26)
                   (values sp i)]
                  [else
                   (vector-set! vec i (add1 (- (char->integer ch) (char->integer #\a))))
                   (values sp ep)])))
  (values height width vec start-pos end-pos))

(define raw-test-data
  "
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
")
(define test-heightmap (call-with-values (lambda () (parse raw-test-data)) heightmap))

(define raw-data
  (port->string (open-input-file "advent12.data") #:close? #t))
(define live-heightmap (call-with-values (lambda () (parse raw-data)) heightmap))
