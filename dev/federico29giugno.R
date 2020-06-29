library(purrr)

n <- 10^5

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

fun=function(points){
  counter <- 0
  for (point_idx in seq_along(points)) {
    point <- points[[point_idx]]
    counter <- counter + in_circle(point)
  }
  counter_to_pi(counter, n)
}

fun2=function(points){
  are_points_in_circle <- map(points, in_circle)
  counter <- reduce(are_points_in_circle, `+`)
  counter_to_pi(counter, n)


  map(points, in_circle) %>%
    reduce(`+`) %>%
    counter_to_pi( n)
}




bench::mark(
  check=F,
  fun=fun(points),
  fun2=fun2(points)
)

#prova prova


