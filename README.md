# Scheme Counter

Small counter library to use for console output, logging, etc.


# About

I had a dilemma, because I wanted to include a bit more generic closure
where the start value, the growth procedure and the interval
could be defined by the user.

So I thought I'd as Wikipedia what to use...

meter - (noun) A device that measures things.

...so I thought the more generic function will be named `make-meter`

And the one that would count by increasing by one
will be named `make-counter`.


# Installation

## Racket

```sh
raco pkg install --name counter
```


# License

Public Domain or CC0-1.0, whichever your country accepts.
