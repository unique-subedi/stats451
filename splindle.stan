functions {
  real ell_theor(real d, real phi, real gamma_) {
    real denom_ratio = (gamma_ * d / phi)^3;
    return gamma_ * d / (1 + denom_ratio)^(1.0 / 3.0); 
  }
}


data {
  int N;
  real d[N];
  real ell[N];
}


parameters {
  real log10_phi;
  real gamma_;
  real<lower=0> sigma;
}


transformed parameters {
  real phi = 10^log10_phi;
}


model {
  log10_phi ~ normal(1.5, 0.75);
  gamma_ ~ beta(1.1, 1.1);
  sigma ~ normal(0.0, 10.0);

  for (i in 1:N) {
    ell[i] ~ normal(ell_theor(d[i], phi, gamma_), sigma);
  }
}
