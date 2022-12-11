#lang racket

;; 

(provide test-fs fs)

(require "advent07-filesystem.rkt")

(define (is-command? s)
  (string-prefix? s "$"))

(define (parse text)
  (for/fold ([fs (make-filesystem)]
             #:result fs)
            ([line (in-list text)])
    (cond
      [(member line '("$ cd /" "$ ls" )) fs]
      [(string-prefix? line "$ cd ")
       (define dir (string-trim line "$ cd "))
       (if (equal? dir "..")
           (fs-pop-dir fs)
           (fs-push-dir fs dir))]
      [(string-prefix? line "dir ")
       (define dir (string-trim line "dir "))
       (fs-add-dir fs dir)]
      [else
       (let* ([split-line (string-split line)]
              [file-size (string->number (first split-line))]
              [file-name (second split-line)])
         (fs-add-file fs file-name file-size))])))

(define (split raw)
  (string-split (string-trim raw) "\n"))

(define raw-test-data
  "
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
")
(define test-fs (parse (split raw-test-data))) 

(define raw-data
  (port->string (open-input-file "advent07.data") #:close? #t))

(define fs (parse (split raw-data))) 
