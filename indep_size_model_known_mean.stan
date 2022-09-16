data {
  int N;
  real ell[N];
}


parameters {
  real<lower=0> sigma;
}


model {
  sigma ~ inv_gamma(10, 5);

  ell ~ normal(32.84, sigma);
}


generated quantities {
  real ell_ppc[N];

  for (i in 1:N) {
    ell_ppc[i] = normal_rng(32.84, sigma);
  }
}
