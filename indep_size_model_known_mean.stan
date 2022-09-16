data {
  int N;
  real ell[N];
}


parameters {
  real<lower=0> phi;
  real<lower=0> sigma;
}


model {
  phi ~ 32.84;
  sigma ~ inv_gamma(2.0, 10.0);

  ell ~ normal(phi, sigma);
}


generated quantities {
  real ell_ppc[N];

  for (i in 1:N) {
    ell_ppc[i] = normal_rng(phi, sigma);
  }
}
