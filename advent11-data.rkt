#lang racket

;; 

(provide test-data data)

;; a monkey is a function that takes a worry level
;; and returns a pair of (destination-monkey . new-worry-level)

(define (parse-queue raw-queue)
  (map string->number (string-split (string-trim (string-trim raw-queue) "Starting items: ") ", ")))

(define (parse-test test-string true-string false-string)
  (define divisor (string->number (string-trim (string-trim test-string) "Test: divisible by ")))
  (define true-value (string->number (string-trim (string-trim true-string) "If true: throw to monkey "))) 
  (define false-value (string->number (string-trim (string-trim false-string) "If false: throw to monkey ")))
  (λ (l) (if (zero? (remainder l divisor)) true-value false-value)))

(define (parse-op s)
  (cond
    [(equal? s "*") *]
    [(equal? s "+") +]
    [else (error (format "unknown op ~s" s))]))

(define test-modulus (apply * (list 23 19 13 17)))
(define modulus (apply * (list 2 13 5 3 11 17 7 19)))
(define (modular-add m)
  (λ (lhs rhs) (remainder (+ lhs rhs) m)))

(define (modular-multiply m)
  (λ (lhs rhs) (remainder (* lhs rhs) m)))

(define (parse-modular-op m s)
  (cond
    [(equal? s "*") (modular-multiply m)]
    [(equal? s "+") (modular-add m)]
    [else (error (format "unknown op ~s" s))]))

;; parse operation returns λ that takes a worry value and returns a new worry value
(define (parse-operation raw-operation)
  (let ([l (string-split (string-trim (string-trim raw-operation) "Operation: new = old "))])
    (let ([op (parse-op (first l))]
          [rhs (string->number (second l))])
      (if (number? rhs)
          (λ (old) (op old rhs))
          (λ (old) (op old old))))))

(define (parse-modular-operation m raw-operation)
  (let ([l (string-split (string-trim (string-trim raw-operation) "Operation: new = old "))])
    (let ([op (parse-modular-op m (first l))]
          [rhs (string->number (second l))])
      (if (number? rhs)
          (λ (old) (op old rhs))
          (λ (old) (op old old))))))

;; each monkey has a queue of worry levels, identifying pensing items
(define (parse-relief-monkey raw-monkey)
  (define relief (λ (l) (quotient l 3)))
  (define split-monkey (string-split raw-monkey "\n"))
  (define queue (parse-queue (second split-monkey)))
  (define operation (parse-operation (third split-monkey)))
  (define test-fn (parse-test (fourth split-monkey) (fifth split-monkey) (sixth split-monkey)))
  (define monkey (λ (old)
                   (let* ([new (relief (operation old))]
                          [next-monkey (test-fn new)])
                     (cons new next-monkey))))
  (list monkey queue))

(define (parse-modular-monkey m raw-monkey)
  (define relief (λ (l) (quotient l 3)))
  (define split-monkey (string-split raw-monkey "\n"))
  (define queue (parse-queue (second split-monkey)))
  (define operation (parse-modular-operation m (third split-monkey)))
  (define test-fn (parse-test (fourth split-monkey) (fifth split-monkey) (sixth split-monkey)))
  (define monkey (λ (old)
                   (let* ([new (operation old)]
                          [next-monkey (test-fn new)])
                     (cons new next-monkey))))
  (list monkey queue))

;; parse returns a list of pairs of (monkey . queue)
(define (parse-relief raw)
  (for/list ([raw-monkey (string-split (string-trim raw) "\n\n")])
    (parse-relief-monkey raw-monkey)))
  
;; parse returns a list of pairs of (monkey . queue)
(define (parse-modular m raw)
  (for/list ([raw-monkey (string-split (string-trim raw) "\n\n")])
    (parse-modular-monkey m raw-monkey)))

(define raw-test-data
  "
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1")
(define test-data (parse-modular test-modulus raw-test-data))

(define raw-data
  (port->string (open-input-file "advent11.data") #:close? #t))

(define data (parse-modular modulus raw-data))
