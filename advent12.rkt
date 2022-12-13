#lang racket

;; 

(require "advent12-data.rkt")
(require "advent12-heightmap.rkt")

(module+ test
  (require rackunit))

; a path is a list of positions - most recent at head
; a queue is a list of paths 
; create a queue loaded with the starting path
(define (make-queue pos)
  (list (list pos)))

; returns the updated queue
(define (queue-push-list l path)
  (append l path))

; returns (values path queue)
(define (queue-pop q)
  (define-values (path-list rest) (split-at q 1))
  (values (first path-list) rest))

(define (find-best-signal hm start-pos)
  (define db (make-hash (list (cons start-pos #t))))
  (let loop ([acc empty]
             [q (make-queue start-pos)])
    (cond
      [(empty? q) acc]
      [else
       (define-values (path next-q) (queue-pop q))
       (cond
         [(= (first path) (heightmap-end-pos hm))
          (loop (cons path acc) next-q)]
         [else
          (define neighbors (heightmap-neighbors hm (car path)))
          (cond
            [(empty? neighbors)
             (loop acc next-q)]
            [else
             (define pos-val (heightmap-ref hm (car path)))
             (let ([new-paths (for/fold ([acc empty])
                                        ([n-pos (in-list neighbors)])
                                (cond
                                  [(not (hash-ref db n-pos #f))
                                   (define n-val (heightmap-ref hm n-pos))
                                   (cond
                                     [(or (<= n-val pos-val) (= (- n-val 1) pos-val))
                                      (hash-set! db n-pos #t)
                                      (cons (cons n-pos path) acc)]
                                     [else acc])]
                                  [else acc]))])
               (loop acc (queue-push-list next-q new-paths)))])])])))

(define (count-from-heightmap-start hm)
  (- (apply min (map length (find-best-signal hm (heightmap-start-pos hm)))) 1))

(count-from-heightmap-start test-heightmap)
(count-from-heightmap-start live-heightmap)

(define (count-from-heightmap-low-points hm)
  (let ([counts (for/fold ([acc empty])
                          ([start-pos (heightmap-low-points hm)])
                  (let ([signals (find-best-signal hm start-pos)])
                    (if (empty? signals)
                        acc
                        (cons (- (apply min (map length signals)) 1) acc))))]) 
    (apply min counts)))

(count-from-heightmap-low-points test-heightmap)
(count-from-heightmap-low-points live-heightmap)
