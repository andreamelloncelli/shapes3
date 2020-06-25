
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
counter_to_pi(counter, n)


map(points, in_circle) %>%
  reduce(sum) %>%
  counter_to_pi(n)

# mclapply ----------------------------------------------------------------

library(tidyverse)
library(tictoc)
library(parallel)

# tic inizia conteggio tempo, toc lo ferma

tic()
lapply(points, in_circle) %>%
  unlist() %>%
  sum() %>%
  counter_to_pi(n)
toc()
# reduce non è ottimizzato perché all'interno ha ciclo for

# funzione della libreria parallel, usa più core per farlo
tic()
mclapply(points, in_circle, mc.cores=3, mc.preschedule = T) %>%
  unlist() %>%
  sum() %>%
  counter_to_pi(n)
toc()


# preschedule = T, array viene diviso nel numero di core


# foreach -----------------------------------------------------------------

library(foreach)
library(iterators)
library(doParallel)

tic()
mcOptions <- list(preschedule=T, set.seed=F)

foreach( p = iter(points),
         .combine = sum,
         .multicombine = T,
         .inorder = F,
         .init = 0,
         .options.multicore = mcOptions,
         .verbose = F) %do% {
  in_circle(p)
}
toc()

# .combine che operazione usare per il reduce
# .multicombine fa tutto alla volta divisa
# .inorder se deve fare in ordine o no

# foreach lavora in modo sequenziale col do, e in parallelo con dopar

registerDoParallel(cores=3)
getDoParWorkers() # crea un ambiente dove lavorare in parallelo

tic()
mcOptions <- list(preschedule=T, set.seed=F)

foreach( p = iter(points),
         .combine = sum,
         .multicombine = T,
         .inorder = F,
         .init = 0,
         .options.multicore = mcOptions,
         .verbose = F) %dopar% {
           in_circle(p)
         }
toc()


# future ------------------------------------------------------------------

library(future)

plan(multisession)

tic()
map(points, in_circle) %>%
  reduce(sum) %>%
  counter_to_pi(n)
toc()

# permetto di fare a ma nel mentre posso eseguire altre operazioni
# definendo a come feature, non aspetto che a sia pronto
# il calcolo va in background

a %<-% {

  map(points, in_circle) %>%
  reduce(sum) %>%
  counter_to_pi(n)

}

# forma esplicita:
a <- future({

  lapply(p, in_circle) %>%
    reduce(sum) %>%
    counter_to_pi(n)

}, globals = list( p = points))

# con globals posso ridefinire degli oggetti
