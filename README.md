# awkcol

awkcol provides some basic AWK functions I don't want to keep rewriting.

## Functions

### Maths

#### nroot

```
nroot(number x, number n) -> number
```

Returns the `n`th root of `x`.

#### arithmean

```
arithmean([number] xs) -> number
```

Returns the arithmetic mean of the values in `xs`.

#### geomean

```
geomean([number] xs) -> number
```

Returns the geometric mean of the values in `xs`.

### LLVM

#### llloc

```
llloc(path ll, regex langs, path srcdir)
```

For `.ll` file `ll`, counts the number of lines of code used to build it.
Requires debug information (uses `DIFile`).
Requires `scc` to be installed.
`langs` is regular expression matching all languages of interest.
It is matched against the first column of `scc`'s output.
`srcdir` is optional.
Files which do are not prefixed by `srcdir` are ignored.
