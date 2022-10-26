  data {
  
  int<lower=0> N;   #number of samples
  
  int<lower=0> p;   #number of predictors
 

  matrix[N,p] x;  #matrix of predictors
  
  int<lower=0, upper=1> y[N];  #vector of response
}


parameters {

  vector[p] beta;  
  real alpha;
  
  
}

transformed parameters {
  vector[N] mu;
  mu = alpha + x * beta;
}





model {

  beta ~ normal(0, 1/10.0);

  for(i in 1:N){
    y[i] ~ bernoulli_logit(mu[i]);
  }
 
 

}
