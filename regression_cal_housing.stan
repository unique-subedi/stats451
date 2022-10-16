data {
  int<lower=0> N;   #number of samples
  int<lower=0> p;   #dimension of predictors
  array[N] vector[p] x;  #each predictors
  array[N] real y;   #each response
}


parameters {
  real beta_0; #intercept
  vector[p] beta;  #coefficient of predictors
  real<lower=0> sigma;  #standard deviation of error
}



model {
   
  
  beta ~ multi_normal(rep_array(0, p), 25*identity_matrix(p))

  for (n in 1:N) {
     y[n] ~ normal(beta_0 + x[n] * beta, sigma);
  }

}

generated quantities {
  real y_ppc[N];

  for (i in 1:N) {
    y_ppc[i] = normal_rng(beta_0 + x[n]*beta, sigma);
  }
}
