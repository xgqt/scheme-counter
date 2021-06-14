# Scheme Counter

<p align="center">
    <a href="http://pkgs.racket-lang.org/package/counter">
        <img src="https://img.shields.io/badge/raco_pkg_install-counter-aa00ff.svg">
    </a>
    <a href="https://archive.softwareheritage.org/browse/origin/?origin_url=https://gitlab.com/xgqt/scheme-counter">
        <img src="https://archive.softwareheritage.org/badge/origin/https://gitlab.com/xgqt/scheme-counter/">
    </a>
    <a href="https://gitlab.com/xgqt/scheme-counter/pipelines">
        <img src="https://gitlab.com/xgqt/scheme-counter/badges/master/pipeline.svg">
    </a>
</p>

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


# Documentation

Counter's documentation is written in Scribble,
to compile the docs you will need
[Racket](https://racket-lang.org/) installed.

After you have installed Racket,
install this package using `raco` (as described [below](#racket))
and then run:

```sh
mkdir -p doc/html
raco scribble ++main-xref-in --html --dest ./doc/html counter.scrbl
```

HTML docs can then be found in [doc/html](./doc/html) directory.


# Installation

## Racket

```sh
raco pkg install --name counter
```


# License

Public Domain or CC0-1.0, whichever your country accepts.
