;;; Helpers

(define (loop_ times procedure)
  (when (> times 0)
    (procedure)
    (loop_ (- times 1) procedure)
    )
  )

;; Wrapper for loop_ - do not have to write (lambda () ...)
(define-syntax loop
  (syntax-rules ()
    ((_ times procedure)
     (loop_ times (lambda () procedure)))
    )
  )


;;; Exports

(define (make-meter start growth-procedure interval)
  (define val start)
  (lambda (runs)
    (loop runs
          (set! val (growth-procedure val interval))
          )
    val
    )
  )

(define (make-counter start)
  (make-meter start + 1)
  )
