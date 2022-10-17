
//the following function computed the regression function mu

functions {
  real mu(real d, real phi, real gamma_) {
    real denom = (1+ (gamma_ * d / phi)^3)^(1.0 / 3.0);
    return gamma_ * d / denom; 
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


// since we specify prior on log10_phi, we need to define this chunk to transform log10_phi to phi and still use phi as parameter of the model

transformed parameters {
  real phi = 10^log10_phi;
}



//our generative model

model {
  log10_phi ~ normal(1.5, 0.75);
  gamma_ ~ beta(1.1, 1.1);
  sigma ~ normal(0.0, 10.0);

  for (i in 1:N) {
    ell[i] ~ normal(mu(d[i], phi, gamma_), sigma);
  }
}


generated quantities {
  real ell_ppc[N];

for (i in 1:N) {
    ell_ppc[i] = normal_rng(mu(d[i], phi, gamma_), sigma);
  }
}
