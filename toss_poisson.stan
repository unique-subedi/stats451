data {
	int N;
	int toss[N];
}
 

parameters {
	real<lower=0> lambda;
}


 model {
	lambda ~ gamma(1, 10);

	toss ~ poisson(lambda); // poisson() specifies the model
}

 
generated quantities {
	int toss_ppc[N];

	for (i in 1:N) {
	    toss_ppc[i] = poisson_rng(lambda); //poisson_generate samples from poisson
  }
 }
