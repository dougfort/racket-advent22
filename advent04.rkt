#lang racket

;; 

(require "advent04-data.rkt")

(define (contains? elf1-range elf2-range)
  (and (<= (first elf1-range) (first elf2-range)) (>= (second elf1-range) (second elf2-range))))

(define (range-overlaps? elf1-range elf2-range)
  (and (<= (first elf1-range) (first elf2-range)) (>= (second elf1-range) (first elf2-range))))

(define (redundant? elf-pair)
  (let ([elf1-range (first elf-pair)]
        [elf2-range (second elf-pair)])
    (or (contains? elf1-range elf2-range) (contains? elf2-range elf1-range))))

(define (pair-overlaps? elf-pair)
  (let ([elf1-range (first elf-pair)]
        [elf2-range (second elf-pair)])
    (or (range-overlaps? elf1-range elf2-range) (range-overlaps? elf2-range elf1-range))))

(define (redundant-count d)
  (length (filter redundant? d)))

(redundant-count test-data)
(redundant-count data)

(define (overlap-count d)
  (length (filter pair-overlaps? d)))

(overlap-count test-data)
(overlap-count data)

