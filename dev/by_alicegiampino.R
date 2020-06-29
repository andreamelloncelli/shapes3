
library(dyplr)
library(purrr)
library(readr)
library(readxl)
library(ggplot2)
library(doSNOW)
library(tictoc)
library(foreach)

# Show the benchmark:
show_bm <- function(bm){
  print(bm)
  autoplot(bm)
}


# data --------------------------------------------------------------------

n <- 10^6

rnd_couple <- function(x){

  list( x = runif(1, min = -1, max = 1),
        y = runif(1, min = -1, max = 1))

}

# function ----------------------------------------------------------------

in_circle <- function(point){

  point$x^2 + point$y^2 < 1

}


counter_to_pi <- function(count, total){

  count/total * 4

}


# map reduce --------------------------------------------------------------

points <- map(seq_len(n), rnd_couple)


tic()
map(points, in_circle) %>%
    reduce(`+`) %>%
    counter_to_pi(n)
toc()

cluster <-  makeCluster(parallel::detectCores(), type = "SOCK")
registerDoSNOW(cluster)

getDoParWorkers()

mcOptions <- list(preschedule=T, set.seed=F)

parallel_function <- function(points) {
  r <- foreach( p = iter(points),
                .combine = sum,
                .multicombine = T,
                .inorder = F,
                .init = 0,
                .options.multicore = mcOptions,
                .verbose = F) %dopar% {
                  in_circle(p)
                }
  }

tic()
# parallel_function(points)
toc()

stopCluster(cluster)

m <- function(n){
  map(points, in_circle) %>%
    reduce(`+`) %>%
    counter_to_pi(n)
}

g <- function(n){
  lapply(points, in_circle) %>%
    unlist() %>%
    sum() %>%
    counter_to_pi(n)
}

f <- function(n){
  point_in <- list( x = runif(1, min = -1, max = 1),
        y = runif(1, min = -1, max = 1))

  sum(in_circle(point_in))/n*4

}

bench::mark(

  check = F,

  map = m(n),

  lapply = g(n),

  # multi = parallel_function(points)

  point_in = f(n)

) %>% show_bm()





