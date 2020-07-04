library(tidyverse)
library(ggplot2)

size = 10^6

show_bm <- function(bm) {
  print(bm)
  autoplot(bm)
}


#First

approx_pi1 <- function(size) {
  rnd <- tibble(
    x = runif(size, -1, 1),
    y = runif(size, -1, 1)
  )
  in_circle_vec <- rnd$x^2 + rnd$y^2 < 1
  sum(in_circle_vec)/(size)*4
}

#Second
in_circle <- function(point) {
  point$x^2 + point$y^2 < 1
}

counter_to_pi <- function(count, total) {
  count/total*4
}


approx_pi2 <- function(size) {
  rnd_couple <- function(x) {
    list(x = runif(1, min = -1, max = 1),
         y = runif(1, min = -1, max = 1))
  }


  points <- map(seq_len(size), rnd_couple)

  counter <- 0
  for (point_idx in seq_along(points)) {
    point <- points[[point_idx]]
    counter <- counter + in_circle(point)
  }
  counter_to_pi(counter, size)
}

# Benchmark

bench::mark(
  check = F,
  first = approx_pi1(10^6),
  second = approx_pi2(10^6)
) %>% show_bm()
