;;; Helpers

(define (loop_ times procedure)
  (when (> times 0)
    (procedure)
    (loop_ (- times 1) procedure)
    )
  )


;;; Exports

(define (make-meter init-val growth-procedure interval)
  (define val init-val)
  (lambda (method)
    (define (internal-get-val)
      val
      )
    (define (internal-set-val new)
      (set! val new)
      )
    (define (internal-grow runs)
      (loop_ runs
             (lambda ()
               (internal-set-val (growth-procedure val interval)))
             )
      )
    (define (internal-run)
      (internal-grow 1)
      val
      )
    (define (internal-runs runs)
      (internal-grow runs)
      val
      )
    (cond
     ((eq? method 'get)  internal-get-val)
     ((eq? method 'set)  internal-set-val)
     ((eq? method 'grow) internal-grow)
     ((eq? method 'runs) internal-runs)
     (else               internal-run)
     )
    )
  )

(define (make-counter start)
  (make-meter start + 1)
  )
