library(purrr)

n <- 10^5

rnd_couple <- function(x){
  list(x=runif(1, -1, 1),
       y=runif(1, -1, 1))
}



points <- map(seq_len(n), rnd_couple)


# function ----------------------------------------------------------------

in_circle <- function(point){
  point$x^2 + point$y^2 < 1
}

counter_to_pi <- function(count, total){
  count/total * 4
}

# fist for loop -----------------------------------------------------------



counter_to_pi(count, n)

