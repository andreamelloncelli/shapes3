library(purrr)

my_f <- function(){
  n <- 10^6

  in_circle <- function(point) {
    point[1]^2 + point[2]^2 < 1
  }

  points <- matrix(runif(2*n, -1,1), ncol=2)

  sum(apply(points,1, function(x) in_circle(x)))/n*4
}

my_f()

bench::mark(
  check=F,
  my = my_f()
)
