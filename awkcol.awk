# Collection of AWK functions.

#################################################
##################### MATHS #####################
#################################################

# Returns the nth root of x.
function nroot(x, n) {
    return x ** (1.0 / n)
}

# Returns the geometric mean of the elements in array xs.
function geomean(xs) {
    n = 0
    prod = 1
    for (i in xs) {
        ++n
        prod *= xs[i]
    }

    if (n == 0) return 0
    else return nroot(prod, n)
}

function arithmean(xs) {
    n = 0
    sum = 0
    for (i in xs) {
        ++n
        sum += xs[i]
    }

    if (n == 0) return 0
    else return sum / n
}