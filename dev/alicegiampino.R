
library(purrr)

n <- 10^6

rnd_couple <- function(x){

  list( x = runif(1, min = -1, max = 1),
        y = runif(1, min = -1, max = 1))

}

map(seq_len(10), rnd_couple)

points <- map(seq_len(n), rnd_couple)


# function ----------------------------------------------------------------

in_circle <- function(point){

  point$x^2 + point$y^2 < 1

}


counter_to_pi <- function(count, total){

  count/total * 4

}


# first for loop ----------------------------------------------------------

counter <- 0

for(point_idx in seq_along(points)){

  point <- points[[point_idx]]

  counter <- counter + in_circle(point)

}

counter_to_pi(counter, n)










