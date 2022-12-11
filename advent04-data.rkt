#lang racket

;; 

(provide test-data data)

;; ((elf-pair)...)
(define (parse raw-data)
  (for/list ([raw-elf-pair (string-split (string-trim raw-data) "\n")])
    (for/list ([raw-elf-tasks (string-split raw-elf-pair ",")])
      (for/list ([raw-section (string-split raw-elf-tasks "-")])
        (string->number raw-section)))))

(define raw-test-data
  "
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
")
(define test-data (parse raw-test-data)) 

(define raw-data
  (port->string (open-input-file "advent04.data") #:close? #t))

(define data (parse raw-data)) 
