#!/usr/bin/env racket


#lang info


(define pkg-authors '(xgqt))
(define pkg-desc
  "Small counter library to use for console output, logging, etc.")
(define version "1.0.0")

(define collection "counter")
(define scheme-source   '("counter.scm" "main.scm"))
(define scribble-source "scribblings/counter.scrbl")
(define compile-omit-paths
  scheme-source)
(define test-omit-paths
  (append scheme-source `(,scribble-source)))
(define scribblings
  `((,scribble-source
     () (library) "counter")))

(define deps
  '("base"))
(define build-deps
  '("racket-doc"
    "rackunit-lib"
    "scribble-lib"))
