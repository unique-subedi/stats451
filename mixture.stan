data {
  int<lower=0> N; //sample size
  int<lower=0> y[N]; //data
  int<lower=0> K; //number of mixture components
}


parameters {
  vector<lower=0>[K] alpha;
  vector<lower=0>[K] b;
  simplex[K] w;   // weights; its in simplex since it should sum upto 1
}


transformed parameters {
  vector[K] beta_ = 1.0 ./ b;
}


model {
  vector[K] log_w = log(w);
  
  // Priors
  alpha ~ lognormal(0.0, 2.3);
  b ~ lognormal(4.6, 2.3);

  
  for (n in 1:N) {
    vector[K] lps = log_w;
    for (k in 1:K) {
      lps[k] += neg_binomial_lpmf(y[n] | alpha[k], beta_[k]);
    }
    target += log_sum_exp(lps);
  }
}
