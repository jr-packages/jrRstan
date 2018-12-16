transformed data {
  int<lower=1> N = 30;
  real<lower=0,upper=1> p = 0.8;
}
model {
}
generated quantities {
  int x[N];
  for(n in 1:N) {
    x[n] = bernoulli_rng(p);
  }
}
