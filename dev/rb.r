library(purrr)
n=100000

rmd_couple=function(x){
  list(x=runif(1,min=-1, max=1),
       y=runif(1,min=-1, max=1))
}

points=map(seq_len(n), rmd_couple)

# function
in.circle=function(point){
  point$x^2+point$y^2<1
}

counter_to_pi=function(count,total){
  count/total*4
}


# first for loop ----------------------------------------------------------
count=0
for (i in 1:n)
  count=count+in.circle(points[[i]])

counter_to_pi(count,n)


seq_len(10)
points=ma
