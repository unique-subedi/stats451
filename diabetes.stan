data {
    int<lower=1> N; //the number of observations
    int<lower=1> J; //the number of groups
    int<lower=1> K; //number of columns in the model matrix
    int<lower=1,upper=J> id[N]; //vector of group indices
    matrix[N,K] X; //the model matrix
    vector[N] y; //the response variable
  }
parameters {
  real<lower=0> tau; //the standard deviation of the regression coefficients
  vector[K] beta_[J];
  real<lower=0> sigma; //standard deviation of the individual observations
}
transformed parameters {

 
  vector[N] mu;
 
  for(n in 1:N){
    mu[n] = X[n] * beta_[id[n]]; //compute the linear predictor using relevant group-level regression coefficients
  }


}
model {
 
  tau ~ normal(0,5); 
  sigma ~ gamma(6,3); 
  for(j in 1:J){
   beta_[j] ~ normal(0,tau); 
   
  }
 
  //likelihood

  y ~ normal(mu,sigma);
}

generated quantities {
  real y_ppc[N];

for (i in 1:N) {
    y_ppc[i] = normal_rng(mu[i], sigma);
  }
}
