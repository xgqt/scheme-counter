#!/usr/bin/env racket


#lang scribble/manual

@require[scribble/example @for-label[racket/base counter]]


@(define doc-eval
   (make-base-eval '(require counter)))

@declare-exporting[counter]


@title[#:tag "counter"]{Counter}

@author[@author+email["Maciej Barć" "xgqt@riseup.net"]]


@table-of-contents[]


@section{About}


@subsection{The library}

@defmodule[counter]

@racketmodname[counter] is a very simple OOP-like library
providing two functions for creating simple "counter" closures:
@racket[make-meter] & @racket[make-counter].

Those functions can be utilized for logging,
for debugging output of console applications
or just counting iteration times of some other functions.

The core library is written in pure scheme and can be utilized by
probably most scheme implamentations.

Know limitations are that the counter can only count up.
To have a more freeform way use
@racket[struct]s, objects, @racket[make-parameter]
or just utilize @racket[set!].


@subsection{Upstream}

The upstream repository can be found on
@link["https://gitlab.com/xgqt/scheme-counter" "GitLab"].


@subsection{License}

Counter is available in Public Domain or under the CC0 License.


@section{Alternative}

As described previously a simple @racket[set!] can be used
to manage "counters" in a similar fashion.

@examples[
#:eval doc-eval
(define c 0)
(set! c (+ c 1))
c
(set! c (+ c 1))
c
]

@examples[
#:eval doc-eval
(define count!
  (let ([c 0])
    (lambda () (set! c (+ c 1))
      c)))
(count!)
(count!)
]

With @racketmodname[counter] similar code would look like:

@examples[
#:eval doc-eval
(define c (make-counter 0))
(c 'run)
(c 'get 'val)
(c 'runs 1)
(c 'runs 0)
]

Benefits of using @racket[make-counter] over @racket[set!] are less code
(which is also more DRY).
Also the number of times the growth-procedure is ran can be specified.
If the number of runs is zero or less only the value of the counter
is returned.


@section{Exported functions}

@defproc[
 (make-meter
  [init-val number?] [init-growth-procedure procedure?] [init-interval number?])
 procedure?
 ]{
   Returns a new closure function which when called with 'run
   will execute growth-procedure on val (initially val = init-val)
   and interval replacing val with new value and,
   then return that new value.
   }

Example: starting value is 1 and then it is
multipled by 2 on each call.

@racketblock[(define m (make-meter 1 * 2))]

@defproc[
 (make-counter [start number?])
 procedure?
 ]{
   Uses @racket[make-meter] to create a function
   which uses @racket[+] as growth-procedure
   and has interval equal to 1.
   }

Example: starting value is 0 and then it is
increased by 1 on each call.

@racketblock[(define c (make-counter 0))]


@section{Examples}

Make an new counter c
@racketblock[(define c (make-counter 0))]

Check type of c
@examples[
#:eval doc-eval
(define c (make-counter 0))
(procedure? c)
]

Check type of @racket[(c 'run)]
@examples[
#:eval doc-eval
(define c (make-counter 0))
(procedure? (c 'run))
]

Execute @racket[(c 'run)] function
@examples[
#:eval doc-eval
(define c (make-counter 0))
(c 'run)
]

Execute @racket[(c 'runs)] function two times
@examples[
#:eval doc-eval
(define c (make-counter 0))
(c 'runs 2)
]

To execute @racket[(c 'run)] any argument may be passed to c
@examples[
#:eval doc-eval
(define c (make-counter 0))
(c #t)
]

Some more OOP - set the value inside c closure to 99
@racketblock[(c 'set 'val 99)]

And check the value
@examples[
#:eval doc-eval
(define c (make-counter 0))
(c 'set 'val 99)
(c 'get 'val)
]

Also check out
@link["https://gitlab.com/xgqt/scheme-counter/-/blob/master/tests.rkt"
      "tests.rkt"]
included in this project.
