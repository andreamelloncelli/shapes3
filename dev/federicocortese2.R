
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


# Parallelizziamo:

# MAP
# Creiamo un ciclo con le iterazioni indipendenti
are_points_in_circle <- numeric(n)

for(point_idx in seq_along(points)){

  point <- points[[point_idx]]

  are_points_in_circle[[point_idx]] <- in_circle(point)

}

are_points_in_circle


# REDUCE
counter <- 0
# Non è banalmente parallelizzabile perché ogni iterazione
# dipende dalla iterazione precedente:
for(is_point_in_circle in are_points_in_circle){

  counter <- counter + is_point_in_circle

}

counter_to_pi(counter, n)

# lapply ------------------------------------------------------------------

# map:
are_points_in_circle <- lapply(points, in_circle)
# oppure
are_points_in_circle <- purrr::map(points, in_circle)

# reduce:
counter <- reduce(are_points_in_circle, sum)

map(points,in_circle)%>%
  reduce(sum)%>%
  counter_to_pi(n)



# mcapply -----------------------------------------------------------------

library(tidyverse)
library(tictoc)
library(parallel)
library(doParallel)
library()

n=10^6

tic()
lapply(points,in_circle) %>%
  unlist()%>%
  sum()%>%
  counter_to_pi(n)
toc()

tic()
mclapply(points,in_circle,mc.cores = 3)%>%
  unlist()%>%
  sum()%>%
  counter_to_pi(n)
toc()









