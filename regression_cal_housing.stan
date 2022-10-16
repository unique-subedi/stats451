data {
  int<lower=0> N;   #number of samples
  
  int<lower=0> p;   #number of predictors
 

  matrix[N, p] x;  #matrix of predictors
  
  vector[N] y;  #matrix of response
}


parameters {

  real beta_0; #intercept
  
  vector[p] beta;  #coefficient of predictors
  
  real<lower=0> sigma;  #standard deviation of error
}



model {
   
  for (i in 1:p){
  
    beta[i] ~ normal(0, 5);    #normal prior on the coefficients; for now, we will not put prior on intercept
    
  }
  

  for (n in 1:N) {
  
    y[n] ~ normal(beta_0 + x[n] * beta, sigma);  #likelihood
  }

}

generated quantities {
  vector[N] y_hat;

  for (n in 1:N) {
    y_hat[n] = normal_rng(beta_0 + x[n] * beta, sigma);   #prediction of y using fitted values. we will later use this block to make prediction for new x as well
  }
}
