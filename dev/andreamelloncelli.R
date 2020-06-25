
library(purrr)

n <- 10^3

rnd_couple <- function(x) {
  list(x = runif(1, min = -1, max = 1),
       y = runif(1, min = -1, max = 1))
}


points <- map(seq_len(n), rnd_couple)
points


# functino ----------------------------------------------------------------

in_circle <- function(point) {
  point$x^2 + point$y^2 < 1
}

counter_to_pi <- function(count, total) {
  count/total * 4
}

# first for-loop ----------------------------------------------------------

...

counter_to_pi(count, n)



