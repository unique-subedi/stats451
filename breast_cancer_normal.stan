  data {
  
  int<lower=0> N;   #number of samples
  
  int<lower=0> p;   #number of predictors
 

  matrix[N, p] x;  #matrix of predictors
  
  vector<lower=0, upper=1> y;  #vector of response
}


parameters {

  vector[p] beta;  
  
  
}




model {
 
 beta ~ normal(1, 1/10);
 
 y ~ bernoulli_logit(beta * x);

}
