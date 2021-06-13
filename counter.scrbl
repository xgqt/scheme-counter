#!/usr/bin/env racket


#lang scribble/manual

@require[
         @for-label[
                    racket/base
                    "main.rkt"
                    ]
         scribble/example
         ]


@title[#:tag "counter"]{Counter}

@author[@author+email["Maciej Barć" "xgqt@riseup.net"]]


@section{About}


@subsection{The library}

@defmodule[counter]

@racketmodname[counter] is a very simple library providing two functions
for creating closures: @racket[make-meter] & @racket[make-counter].

Those functions can be utilized for logging,
for debugging output of console applications
or just counting iteration times of some other functions.

The core library is written in pure scheme and can be utilized by
probably most scheme implamentations.

Know limitations are that the counter can only count up.
To have a more freeform way use structs, objects, @racket[make-parameter]
or just utilize @racket[set!].


@subsection{Upstream}

The upstream repository can be found on
@link["https://gitlab.com/xgqt/scheme-counter" "GitLab"].


@subsection{License}

Counter is available in Public Domain or under the CC0 License.


@section{Alternative}

As described previously a simple @racket[set!] can be used
to manage "counters" in a similar fashion.

@racketblock[
          (define c 0)
          (set! c (+ c 1))
          c
          1
          (set! c (+ c 1))
          c
          2
          ]

With @racketmodname[counter] similar code would look like:

@racketblock[
          (define c (make-counter 0))
          ((c 'run))
          1
          ((c 'get))
          1
          ((c 'runs) 1)
          2
          ((c 'runs) 0)
          2
          ]

Benefits of using @racket[make-counter] over @racket[set!] are less code
(which is also more DRY).
Also the number of times the growth-procedure is ran can be specified.
If the number of runs is zero or less only the value of the counter
is returned.


@section{Exported functions}


@subsection{make-meter}

@defproc[(make-meter [init-val number?]
                     [growth-procedure procedure?]
                     [interval number?])
         procedure?
         ]{
           Returns a new closure function which when called with 'run
           will execute growth-procedure on val (initially val = init-val)
           and interval replacing val with new value and,
           then return that new value.
           }

Example: starting value is 1 and then it is
multipled by 2 on each call.

@racketblock[
             (define m (make-meter 1 * 2))
             ]


@subsection{make-counter}

@defproc[(make-counter [start number?])
         procedure?
         ]{
           Uses @racket[make-meter] to create a function
           which uses @racket[+] as growth-procedure
           and has interval equal to 1.
           }

Example: starting value is 0 and then it is
increased by 1 on each call.

@racketblock[
             (define c (make-counter 0))
             ]


@section{Examples}

Make an new counter c
@racketblock[(define c (make-counter 0))]

Check type of c
@racketblock[(procedure? c)]
> #t

Check type of (c 'run)
@racketblock[(procedure? (c 'run))]
> #t

Execute (c 'run) function
@racketblock[((c 'run))]
> 1

Execute (c 'runs) function two times
@racketblock[((c 'runs) 2)]
> 3

To execute (c 'run) any argument may be passed to c
@racketblock[((c #t))]
> 4

Some more OOP - set the value inside c closure to 99
@racketblock[((c 'set) 99)]

And check the value
@racketblock[((c 'get))]
> 99

Also check out "test.rkt" included in this project.
