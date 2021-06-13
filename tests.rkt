#lang racket/base


(module+ test

  (require
   rackunit
   "main.rkt"
   )


  (check-true (procedure? make-meter))
  (check-true (procedure? make-counter))
  (check-true (procedure? (make-counter 0)))
  (check-true (procedure? ((make-counter 0) #t)))
  (check-eq?  (((make-counter 0) #t))       1)
  (check-eq?  (((make-counter 0) 'runs) 0)  0)

  (define c0+2 (make-meter 0 + 2))
  (define c1+2 (make-meter 1 + 2))
  (define c2+2 (make-meter 2 + 2))
  (void ((c0+2 'runs) 1) ((c0+2 'runs) 2) ((c0+2 'runs) 3)
        ((c1+2 'runs) 1) ((c1+2 'runs) 2) ((c1+2 'runs) 3)
        ((c2+2 'runs) 1) ((c2+2 'runs) 2) ((c2+2 'runs) 3)
        )
  (check-equal? ((c0+2 'get)) 12)
  (check-equal? ((c1+2 'get)) 13)
  (check-equal? ((c2+2 'get)) 14)

  (define c0-2 (make-meter 0 - 2))
  (define c1-2 (make-meter 1 - 2))
  (define c2-2 (make-meter 2 - 2))
  (void ((c0-2 'runs) 1) ((c0-2 'runs) 2) ((c0-2 'runs) 3)
        ((c1-2 'runs) 1) ((c1-2 'runs) 2) ((c1-2 'runs) 3)
        ((c2-2 'runs) 1) ((c2-2 'runs) 2) ((c2-2 'runs) 3)
        )
  (check-equal? ((c0-2 'get)) -12)
  (check-equal? ((c1-2 'get)) -11)
  (check-equal? ((c2-2 'get)) -10)

  (define c0*2 (make-meter 0 * 2))
  (define c1*2 (make-meter 1 * 2))
  (define c2*2 (make-meter 2 * 2))
  (void ((c0*2 'runs) 1) ((c0*2 'runs) 2) ((c0*2 'runs) 3)
        ((c1*2 'runs) 1) ((c1*2 'runs) 2) ((c1*2 'runs) 3)
        ((c2*2 'runs) 1) ((c2*2 'runs) 2) ((c2*2 'runs) 3)
        )
  (check-equal? ((c0*2 'get)) 0)
  (check-equal? ((c1*2 'get)) 64)
  (check-equal? ((c2*2 'get)) 128)

  (define c0/2 (make-meter 0 / 2))
  (define c1/2 (make-meter 1 / 2))
  (define c2/2 (make-meter 2 / 2))
  (void ((c0/2 'runs) 1) ((c0/2 'runs) 2) ((c0/2 'runs) 3)
        ((c1/2 'runs) 1) ((c1/2 'runs) 2) ((c1/2 'runs) 3)
        ((c2/2 'runs) 1) ((c2/2 'runs) 2) ((c2/2 'runs) 3)
        )
  (check-equal? ((c0/2 'get)) 0)
  (check-equal? ((c1/2 'get)) (/ 1 64))
  (check-equal? ((c2/2 'get)) (/ 1 32))

  )
