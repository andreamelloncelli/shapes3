library(purrr)

n <- 10^3

rnd_couple <- function(x){
  list(x=runif(1,-1, 1),
       y=runif(1,-1,1))
}


map(seq_len(10), rnd_couple)


points <- map(seq_len(n), rnd_couple)
points

#########################################################################
in_circle <- function(point){
  point$x^2 + point$y^2 < 1
}

counter_to_pi <- function(count, total){
  count/total*4
}
#########################################################################


# first for loop:
n <- 10^5

points <- map(seq_len(n), rnd_couple)
points

count <- logical(n)
for(i in 1:n){
  count[i] <- in_circle(points[[i]])
}

counter_to_pi(sum(count), n)
