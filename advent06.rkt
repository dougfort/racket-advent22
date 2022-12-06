#lang racket

;; 

(require "advent06-data.rkt")

(module+ test
  (require rackunit))

(define (find-unique-characters size data)
  (define buffer ((compose1 list->vector string->list string-trim) data))
  (for/or ([i (in-range (vector-length buffer))])
    (let* ([last-pos (+ i size)]
           [vec (vector-copy buffer i last-pos)])
      (if (check-duplicates (vector->list vec) #:default #f)
          #f
          last-pos))))


(define (find-start-of-packet data)
  (find-unique-characters 4 data))

(module+ test
  (check-equal? (find-start-of-packet raw-test-data)
                7)
  (check-equal? (find-start-of-packet "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
                11))

(define (find-start-of-message data)
    (find-unique-characters 14 data))

(module+ test
  (check-equal? (find-start-of-message raw-test-data)
                19)
  (check-equal? (find-start-of-message "bvwbjplbgvbhsrlpgdmjqwftvncz")
                23))
  