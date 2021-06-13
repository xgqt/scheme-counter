#!/usr/bin/env racket


#lang scribble/manual

@require[
         @for-label[
                    racket/base
                    "main.rkt"
                    ]
         scribble/example
         ]


@title{Counter}

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
          (c 1)
          1
          (c 0)
          1
          (c 1)
          2
          (c 0)
          2
          ]

Benefits of using @racket[make-counter] over @racket[set!] are less code
(which is more DRY).
Also the number of times the growth-procedure is ran can be specified.
If the number of runs is zero or less only the value of the counter
is returned.


@section{Exported functions}


@subsection{make-meter}

@defproc[(make-meter [start number?]
                     [growth-procedure procedure?]
                     [interval number?])
         procedure?]

Returns a new function which when called will execute growth-procedure
on the start value and interval repacing the start value with new value
and return the new value.

Example: starting value is 1 and then it is
multipled by 2 on each call.

@racketblock[
             (define m (make-meter 1 * 2))
             ]


@subsection{make-counter}

@defproc[(make-counter [start number?])
         procedure?]

Uses @racket[make-meter] to create a function which uses @racket[+]
as growth-procedure and has interval equal to 1.

Example: starting value is 0 and then it is
increased by 1 on each call.

@racketblock[
             (define c (make-counter 0))
             ]


@subsection{produced closure}

@defproc[(counter [runs number?])
         number?]

The closure produced by @racket[make-meter] or @racket[make-counter]
takes exactly one number argument - runs.

If runs is greater than 0, then value of closure is increased
(using growth-procedure given when defining a given counter)
that many times.
If runs is equal or less than 0 value of closure is not increased.

Also on each call to the closure value of it is returned.
