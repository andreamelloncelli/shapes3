library(purrr)

n <- 10^6

# Original function ----

rnd_couple <- function(x) {
  list(x = runif(1, min = -1, max = 1),
       y = runif(1, min = -1, max = 1))
}


points <- map(seq_len(n), rnd_couple)



in_circle <- function(point) {
  point$x^2 + point$y^2 < 1
}

counter_to_pi <- function(count, total) {
  count/total * 4
}

g <- function(n){
  map(points, in_circle) %>%
    reduce(`+`) %>%
    counter_to_pi( n)
}


# New function ----
f <- function(n){
  m <- cbind(x = runif(n, min = -1, max = 1),
             y = runif(n, min = -1, max = 1))

  is_in_circle <- m[,1]^2 + m[,2]^2 < 1
  sum(is_in_circle)/n*4
}

# alternative with apply
apply(m, 1, function(x) return(x[1]^2 + x[2]^2 < 1))

# not efficient!
bench::mark(
  m[,1]^2 + m[,2]^2 < 1,
  apply(m, 1, function(x) return(x[1]^2 + x[2]^2 < 1))
)


# Final test ----

bench::mark(
  f(n),
  g(n),
  check=FALSE
)
