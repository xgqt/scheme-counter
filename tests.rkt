#lang racket/base


(module+ test

  (require
   rackunit
   "main.rkt"
   )


  (check-true (procedure? make-meter))
  (check-true (procedure? make-counter))
  (check-true (procedure? (make-counter 0)))
  (check-eq?  ((make-counter 0) #t)       1)
  (check-eq?  ((make-counter 0) 'runs 0)  0)
  (check-eq?  ((make-counter 0) 'show)  0)
  (check-eq?  ((make-counter 99) 'show)  99)

  (define c0+2 (make-meter 0 + 2))
  (define c1+2 (make-meter 1 + 2))
  (define c2+2 (make-meter 2 + 2))
  (void (c0+2 'runs 1) (c0+2 'runs 2) (c0+2 'runs 3) (c0+2)
        (c1+2 'runs 1) (c1+2 'runs 2) (c1+2 'runs 3) (c1+2)
        (c2+2 'runs 1) (c2+2 'runs 2) (c2+2 'runs 3) (c2+2)
        )
  (check-equal?  (c0+2 'get 'val)  14)
  (check-equal?  (c1+2 'get 'val)  15)
  (check-equal?  (c2+2 'get 'val)  16)

  (define c0-2 (make-meter 0 - 2))
  (define c1-2 (make-meter 1 - 2))
  (define c2-2 (make-meter 2 - 2))
  (void (c0-2 'runs 1) (c0-2 'runs 2) (c0-2 'runs 3) (c0-2)
        (c1-2 'runs 1) (c1-2 'runs 2) (c1-2 'runs 3) (c1-2)
        (c2-2 'runs 1) (c2-2 'runs 2) (c2-2 'runs 3) (c2-2)
        )
  (check-equal?  (c0-2 'get 'val)  -14)
  (check-equal?  (c1-2 'get 'val)  -13)
  (check-equal?  (c2-2 'get 'val)  -12)

  (define c0*2 (make-meter 0 * 2))
  (define c1*2 (make-meter 1 * 2))
  (define c2*2 (make-meter 2 * 2))
  (void (c0*2 'runs 1) (c0*2 'runs 2) (c0*2 'runs 3) (c0*2)
        (c1*2 'runs 1) (c1*2 'runs 2) (c1*2 'runs 3) (c1*2)
        (c2*2 'runs 1) (c2*2 'runs 2) (c2*2 'runs 3) (c2*2)
        )
  (check-equal?  (c0*2 'get 'val)  0)
  (check-equal?  (c1*2 'get 'val)  128)
  (check-equal?  (c2*2 'get 'val)  256)

  (define c0/2 (make-meter 0 / 2))
  (define c1/2 (make-meter 1 / 2))
  (define c2/2 (make-meter 2 / 2))
  (void (c0/2 'runs 1) (c0/2 'runs 2) (c0/2 'runs 3) (c0/2)
        (c1/2 'runs 1) (c1/2 'runs 2) (c1/2 'runs 3) (c1/2)
        (c2/2 'runs 1) (c2/2 'runs 2) (c2/2 'runs 3) (c2/2)
        )
  (check-equal?  (c0/2 'get 'val)  0)
  (check-equal?  (c1/2 'get 'val)  (/ 1 128))
  (check-equal?  (c2/2 'get 'val)  (/ 1 64))

  )
