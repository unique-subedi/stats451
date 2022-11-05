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

  real<lower=0> sigma[J]; //standard deviation of the individual observations
}

transformed parameters {

 
 vector[N] variances;
 
 for(i in 1:n){
  var[i] = variances[id[n]]; 
 
 }


}
model {
 
  beta ~ normal(0, 5);  
  tau ~ normal(0,5); 
  for(j in 1:J){
   sigma[j] ~ normal(0, tau); 
   
  }
 
  //likelihood

  y ~ normal(X* beta ,variances);
}

generated quantities {
  real y_ppc[N];

for (i in 1:N) {
    y_ppc[i] = normal_rng(mu[i], variances[i]);
  }
}
