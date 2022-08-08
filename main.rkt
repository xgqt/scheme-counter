#!/usr/bin/env racket


#lang racket/base

(require racket/contract racket/include)

(include "counter.scm")

(provide (contract-out
          [make-meter (-> number? procedure? number? procedure?)]
          [make-counter (-> number? procedure?)]))
