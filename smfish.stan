data {
  int<lower=0> N;
  int<lower=0> n[N];
}


parameters {
  real log10_alpha;
  real log10_b;
}


transformed parameters {
  real alpha = 10^log10_alpha;
  real b = 10^log10_b;
  real beta_ = 1.0 / b;
}


model {
  // Priors
  log10_alpha ~ normal(0, 1);
  log10_b ~ normal(2, 1);

  // Likelihood
  n ~ neg_binomial(alpha, beta_);
}
