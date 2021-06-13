#lang racket/base


(module+ test

  (require
   rackunit
   "main.rkt"
   )


  (check-true (procedure? make-meter))
  (check-true (procedure? make-counter))

  (define c0+2 (make-meter 0 + 2))
  (define c1+2 (make-meter 1 + 2))
  (define c2+2 (make-meter 2 + 2))
  (void (c0+2 1) (c0+2 2) (c0+2 3)
        (c1+2 1) (c1+2 2) (c1+2 3)
        (c2+2 1) (c2+2 2) (c2+2 3)
        )
  (check-equal? (c0+2 0) 12)
  (check-equal? (c1+2 0) 13)
  (check-equal? (c2+2 0) 14)

  (define c0-2 (make-meter 0 - 2))
  (define c1-2 (make-meter 1 - 2))
  (define c2-2 (make-meter 2 - 2))
  (void (c0-2 1) (c0-2 2) (c0-2 3)
        (c1-2 1) (c1-2 2) (c1-2 3)
        (c2-2 1) (c2-2 2) (c2-2 3)
        )
  (check-equal? (c0-2 0) -12)
  (check-equal? (c1-2 0) -11)
  (check-equal? (c2-2 0) -10)

  (define c0*2 (make-meter 0 * 2))
  (define c1*2 (make-meter 1 * 2))
  (define c2*2 (make-meter 2 * 2))
  (void (c0*2 1) (c0*2 2) (c0*2 3)
        (c1*2 1) (c1*2 2) (c1*2 3)
        (c2*2 1) (c2*2 2) (c2*2 3)
        )
  (check-equal? (c0*2 0) 0)
  (check-equal? (c1*2 0) 64)
  (check-equal? (c2*2 0) 128)

  (define c0/2 (make-meter 0 / 2))
  (define c1/2 (make-meter 1 / 2))
  (define c2/2 (make-meter 2 / 2))
  (void (c0/2 1) (c0/2 2) (c0/2 3)
        (c1/2 1) (c1/2 2) (c1/2 3)
        (c2/2 1) (c2/2 2) (c2/2 3)
        )
  (check-equal? (c0/2 0) 0)
  (check-equal? (c1/2 0) (/ 1 64))
  (check-equal? (c2/2 0) (/ 1 32))

  )
