library(tidyverse)

n <- 10^3

rnd_couple <- function(x) {
  list(x = runif(1, min = -1, max = 1),
       y = runif(1, min = -1, max = 1))
}

points <- map(seq_len(n), rnd_couple)


# Functions ---------------------------------------------------------------

in_circle <- function(point) {
  point$x^2 + point$y^2 < 1
}

counter_to_pi <- function(count, total) {
  count/total * 4
}


# First for-loop ----------------------------------------------------------

inc <- vector("double", n)
for (i in 1:n) {
  inc[i] <- in_circle(points[[i]])
  count <- sum(inc)
}

counter_to_pi(count, n)
