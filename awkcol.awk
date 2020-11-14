# Collection of AWK functions.

#################################################
##################### MATHS #####################
#################################################

# Returns the nth root of x.
function nroot(x, n) {
    return x ** (-1 * n)
}

# Returns the geometric mean of the elements in array xs.
function geomean(xs,
                 n, prod) {
    n = 0
    prod = 1
    for (i in xs) {
        ++n
        prod *= xs[i]
    }

    if (n == 0) return 0
    else return nroot(prod, n)
}

# Returns the arithmetic mean of the elements in array xs.
function arithmean(xs,
                   n, sum) {
    n = 0
    sum = 0
    for (i in xs) {
        ++n
        sum += xs[i]
    }

    if (n == 0) return 0
    else return sum / n
}

#################################################
##################### LLVM ######################
#################################################

# Counts the number of lines in the source files mentioned in the
# given LLVM file's debug information.
# Requires scc to be installed.
# Takes a .ll filename and the languages of interest as a regexp
# (the first column of scc). srcdir is optional and any files
# not starting with srcdir are ignored.
function llloc(ll, langs, srcdir,
               line, loc, fn, dir, auxlen, srcs, cols, ncols) {
    loc = 0

    # TODO: handle getline errors
    while (getline line < ll == 1) {
        # TODO: better distinct handling. Can distinct even appear for DIFile?
        if (line !~ /^![0-9]+ = (distinct )?!DIFile/) continue;

        fn = ""
        dir = ""

        if (match(line, /filename: "[^"]*/)) {
            auxlen = length("filename: \"")
            fn = substr(line, RSTART + auxlen, RLENGTH - auxlen)
        }

        if (match(line, /directory: "[^"]*/)) {
            auxlen = length("directory: \"")
            dir = substr(line, RSTART + auxlen, RLENGTH - auxlen)
        }

        src = dir ? dir "/" fn : fn

        if (src !~ "^" srcdir) continue

        srcs = srcs " " src
    }

    close(ll)

    # TODO: handle getline errors
    while ("scc " srcs | getline line) {
        if (line !~ langs) continue
        # We want the second last column. We'll use split rather than
        # getline without a var  (line) to avoid messing $0 for the caller.
        ncols = split(line, cols, " ")
        # We want the second last column.
        loc += cols[ncols - 1]
    }

    close("scc " srcs)

    return loc
}
