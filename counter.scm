(define (make-meter init-val init-growth-procedure init-interval)
  (define val              init-val)
  (define growth-procedure init-growth-procedure)
  (define interval         init-interval)
  (define (loop times procedure)
    ;; execute PROCEDURE a specified amount of TIMES
    (cond ((> times 0)
           (procedure)
           (loop (- times 1) procedure)
           ))
    )
  (lambda method
    (define (internal-get var)
      ;; return the value of VAR
      (case var
        ((val)              val)
        ((growth-procedure) growth-procedure)
        ((interval)         interval)
        (else               #f)
        )
      )
    (define (internal-set var new)
      ;; set value of VAR to NEW value
      (case var
        ((val)              (set! val              new))
        ((growth-procedure) (set! growth-procedure new))
        ((interval)         (set! interval         new))
        (else               #f)
        )
      )
    (define (internal-turn)
      ;; set VAL to result of `growth-procedure' taking VAL and INTERVAL
      (internal-set 'val (growth-procedure val interval))
      )
    (define (internal-grow runs)
      ;; execute `internal-turn' RUNS times
      (loop runs (lambda () (internal-turn)))
      )
    (define (internal-runs runs)
      ;; execute `internal-grow' RUNS times and return VAL
      (internal-grow runs)
      val
      )
    (define (internal-run)
      ;; execute `internal-turn' once and return VAL
      (internal-turn)
      val
      )
    (if (null? method)
        ;; ((mycounter))
        internal-run
        ;; ((mycounter 'something))
        (case (car method)
          ((get)  internal-get)
          ((set)  internal-set)
          ((turn) internal-turn)
          ((grow) internal-grow)
          ((runs) internal-runs)
          (else   internal-run)
          )
        )
    )
  )

(define (make-counter start)
  (make-meter start + 1)
  )
