library(purrr)

n=10^5

rnd_couple=function(x){
  list(x=runif(1,min=-1,max=1),
       y=runif(1,min=-1,max=1))
}

map(seq_len(10),rnd_couple)
points=map(seq_len(n),rnd_couple)


# function ----------------------------------------------------------------

#ciao ciao
in_circle=function(point){
  point$x^2+point$y^2<1
}

counter_to_pi=function(count,total){
  count/total*4
}

count=0

# L=length(points)
# for(i in 1:L){
#   if(in_circle(point[[i]])){
#     count=count+1
#   }
# }

counter=0
for(point_indx in seq_along(points)){
  point=points[[points_indx]]
  counter=counter+in_circle(point)

}


counter_to_pi(counter,n)




counter_to_pi(count,n)

