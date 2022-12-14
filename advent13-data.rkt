#lang racket

;; 

(module+ test
  (require rackunit))

(provide test-data data)

;; split a list of ch into a single ch and the rest of the list
(define (split-ch chs)
  (let-values ([(c r) (split-at chs 1)])
    (values (first c) r)))

(define (parse-number chs)
  (define-values (ch rst) (split-ch chs))
  ;  (printf "parse-number ch ~s rst ~s\n" ch rst)
  (let loop ([acc 0]
             [ch ch]
             [rst rst])
    (cond
      [(equal? ch #\]) (values acc (cons #\] rst))]
      [(equal? ch #\,) (values acc rst)]
      [else
       (define n (- (char->integer ch) (char->integer #\0))) 
       (let-values ([(c r) (split-ch rst)])
         (loop (+ (* acc 10) n) c r))])))

(define numbers #hash(
                 (#\0 . #t)
                 (#\1 . #t)
                 (#\2 . #t)
                 (#\3 . #t)     
                 (#\4 . #t)     
                 (#\5 . #t)     
                 (#\6 . #t)     
                 (#\7 . #t)     
                 (#\8 . #t)     
                 (#\9 . #t)))

(define (parse-list chs)
  (define-values (ch rst) (split-ch chs))
  ;  (printf "parse-list ch ~s rst ~s\n" ch rst)
  (let loop ([acc empty]
             [ch ch]
             [rst rst])
    (cond
      [(equal? ch #\]) (values (reverse acc) rst)]
      [(equal? ch #\[) 
       (let-values ([(n r) (parse-list rst)])
         (let-values ([(c r) (split-ch r)])
           (loop (cons n acc) c r)))]
      [(equal? ch #\,)
       (let-values ([(c r) (split-ch rst)])
         (loop acc c r))]
      [else
       (unless (hash-has-key? numbers ch)
         (error (format "not a number ~s" ch)))
       (let-values ([(n r) (parse-number (cons ch rst))])
         (let-values ([(c r) (split-ch r)])
           (loop (cons n acc) c r)))])))

(define (parse-packet packet)
  ; we assum the packet is contained in a list
  (define-values (ch rst) (split-ch (string->list packet))) 
  (unless (equal? ch #\[)
    (error (format "expecting packet to start with a list '~s'" packet)))
  (let-values ([(l rst) (parse-list rst)])
    (unless (empty? rst)
      (error (format ("leftovers in packet ~s ~s\n" rst packet))))
    l))
        
(define (parse-packet-pair packet-pair)
  (list (parse-packet (first packet-pair)) (parse-packet (second packet-pair))))

(define (parse raw)
  (let ([split-data (for/list ([r (string-split (string-trim raw) "\n\n")])                      
                      (string-split r "\n"))])
    (for/list ([packet-pair (in-list split-data)])
      (parse-packet-pair packet-pair))))

(module+ test
  (test-begin
   (let-values ([(l r) (parse-number (list #\0 #\,))])
     (check-equal? l 0 (format "l ~s; r ~s" l r)))
   (let-values ([(l r) (parse-number (list #\5 #\,))])
     (check-equal? l 5 (format "l ~s; r ~s" l r)))
   (let-values ([(l r) (parse-number (list #\1 #\0 #\,))])
     (check-equal? l 10 (format "l ~s; r ~s" l r)))
   (let-values ([(l r) (parse-number (list #\1 #\0 #\]))])
     (check-equal? l 10 (format "l ~s; r ~s" l r)))
   (let-values ([(l r) (parse-list (list #\]))])
     (check-equal? l empty (format "l ~s; r ~s" l r)))
   (let-values ([(l r) (parse-list (list #\[ #\] #\]))])
     (check-equal? l '(()) (format "l ~s; r ~s" l r)))
   (let-values ([(l r) (parse-list (list #\[ #\5 #\] #\]))])
     (check-equal? l '((5)) (format "l ~s; r ~s" l r)))
   (let-values ([(l r) (parse-list (list #\[ #\4 #\, #\5 #\] #\]))])
     (check-equal? l '((4 5)) (format "l ~s; r ~s" l r)))
   (let-values ([(l r) (parse-list (list #\[ #\8 #\] #\, #\[ #\1 #\] #\]))])
     (check-equal? l '((8) (1)) (format "l ~s; r ~s" l r)))))

(define raw-test-data
  "
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
")
(define test-data (parse raw-test-data))

(define raw-data
  (port->string (open-input-file "advent13.data") #:close? #t))
(define data (parse raw-data))
