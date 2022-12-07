#lang racket

;; 

(provide
 total-space
 root-path
 make-filesystem
 fs-pop-dir
 fs-push-dir
 fs-add-dir
 fs-add-file
 fs-dir-size
 fs-dir-sizes)

(module+ test
  (require rackunit))

(struct filesystem (db path work)
  #:transparent)

(struct directory (name children files)
  #:transparent)

(define (dir-size dir)
  (for/sum ([f (in-list (directory-files dir))])
    (file-size f)))

(struct file (name size)
  #:transparent)

(define root-dir-name "/")

(define root-path (list root-dir-name))

(define total-space 70000000)

(define (make-filesystem)
  (define db (make-hash))
  (define root-dir (directory root-dir-name empty empty))
  (hash-set! db root-path root-dir)
  (filesystem db root-path root-dir))

(define (fs-pop-dir fs)
  (let* ([path (list-tail (filesystem-path fs) 1)]
         [work (hash-ref (filesystem-db fs) path)])   
    (filesystem (filesystem-db fs) path work))) 

(define (fs-push-dir fs dir-name)
  (let* ([path (cons dir-name (filesystem-path fs))]
         [work (hash-ref (filesystem-db fs) path)])
    (filesystem (filesystem-db fs) path work)))

(define (fs-add-dir fs child-name)
  (let* ([child-path (cons child-name (filesystem-path fs))]
         [child-work (directory child-name empty empty)])
    (hash-set! (filesystem-db fs) child-path child-work)
    (let ([work (directory
                 (directory-name (filesystem-work fs))
                 (cons child-name (directory-children (filesystem-work fs)))
                 (directory-files (filesystem-work fs)))])
      (hash-set! (filesystem-db fs) (filesystem-path fs) work)
      (filesystem (filesystem-db fs) (filesystem-path fs) work))))

(define (fs-add-file fs file-name file-size)
  (let ([work (directory
               (directory-name (filesystem-work fs))
               (directory-children (filesystem-work fs))
               (cons (file file-name file-size) (directory-files (filesystem-work fs))))])
    (hash-set! (filesystem-db fs) (filesystem-path fs) work)
    (filesystem (filesystem-db fs) (filesystem-path fs) work)))

(define (fs-dir-size fs path)
  (let* ([work-dir (hash-ref (filesystem-db fs) path)]
         [work-size (dir-size work-dir)])
    (let ([child-size (for/sum ([child-name (in-list (directory-children work-dir))])
                        (fs-dir-size fs (cons child-name path)))])
      (+ work-size child-size))))

(define (fs-dir-sizes fs)
  (for/list ([path (in-list (hash-keys (filesystem-db fs)))])
    (fs-dir-size fs path)))
     
(module+ test
  (test-begin
   (let ([fs (make-filesystem)])
     (let ([fs1 (fs-add-dir fs "a")])
       (check-equal? (directory-children (filesystem-work fs1)) (list "a"))
       (let ([fs2 (fs-push-dir fs1 "a")])
         (check-equal? (filesystem-path fs2) '("a" "/"))
         (let ([fs3 (fs-pop-dir fs2)])
           (check-equal? (filesystem-path fs3) '("/"))))))))
