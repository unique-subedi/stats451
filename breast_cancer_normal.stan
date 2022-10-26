  data {
  
  int<lower=0> N;   #number of samples
  
  int<lower=0> p;   #number of predictors
 

  vector[p] x[N];  #matrix of predictors
  
  int<lower=0, upper=1> y[N];  #vector of response
}


parameters {

  vector[p] beta;  
  real alpha;
  
  
}




model {
 
 beta ~ normal(1, 1/10);
 
 y ~ bernoulli_logit(alpha + x * beta);

}
