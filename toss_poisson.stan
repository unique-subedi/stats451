data {
	int N;
	int toss[N];
}
 

parameters {
	real<lower=0> lambda;
}


 model {
	lambda ~ gamma(25, 0.5);

	toss ~ poisson(lambda); // poisson() specifies the model
}

 
generated quantities {
	real toss_ppc[N];

	for (i in 1:N) {
	    toss_ppc[i] = poisson_rng(lambda); //poisson_generate samples from poisson
  }
 }
