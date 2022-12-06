#lang racket

;; 

(require "advent06-data.rkt")

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

(define (find-start-of-message data)
    (find-unique-characters 14 data))
