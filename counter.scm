(define (make-meter init-val init-growth-procedure init-interval)
  (define val              init-val)
  (define growth-procedure init-growth-procedure)
  (define interval         init-interval)

  (define (loop times procedure)
    ;; execute PROCEDURE a specified amount of TIMES
    (cond ((> times 0) (procedure)
           (loop (- times 1) procedure))))

  (define (second lst)
    (car (cdr lst)))

  (define (third lst)
    (car (cdr (cdr lst))))

  (define (internal-get var)
    ;; return the value of VAR
    (case var
      ((val)              val)
      ((growth-procedure) growth-procedure)
      ((interval)         interval)
      (else               #f)))

  (define (internal-set var new)
    ;; set value of VAR to NEW value
    (case var
      ((val)              (set! val              new))
      ((growth-procedure) (set! growth-procedure new))
      ((interval)         (set! interval         new))
      (else               #f)))

  (define (internal-turn)
    ;; set VAL to result of `growth-procedure' taking VAL and INTERVAL
    (internal-set 'val (growth-procedure val interval)))

  (define (internal-grow runs)
    ;; execute `internal-turn' RUNS times
    (loop runs (lambda () (internal-turn))))

  (define (internal-runs runs)
    ;; execute `internal-grow' RUNS times and return VAL
    (internal-grow runs)
    val)

  (define (internal-run)
    ;; execute `internal-turn' once and return VAL
    (internal-turn)
    val)

  (lambda args
    (if (null? args)
        ;; given: (mycounter)
        (internal-run)
        ;; given: (mycounter 'something) or (mycounter 'something somevalue)
        (case (car args)
          ((get)  (internal-get (second args)))
          ((set)  (internal-set (second args) (third args)))
          ((show) (internal-get 'val))
          ((turn) (internal-turn))
          ((grow) (internal-grow (second args)))
          ((runs) (internal-runs (second args)))
          (else   (internal-run))))))

(define (make-counter start)
  (make-meter start + 1))
