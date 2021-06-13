#!/usr/bin/env racket


#lang info


(define collection "counter")

(define compile-omit-paths '("counter.scm" ))
(define test-omit-paths
  '(
    "counter.scm" "counter.scrbl"
    )
  )

(define scribblings
  '((
     "counter.scrbl"
     ()
     ))
  )
