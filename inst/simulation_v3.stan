transformed data {
  int<lower=1> N = 30;
  real<lower=0,upper=1> p = 0.8;
  real a = -3;
  real b = 3;
}
model {
}
generated quantities {
  int x[N];
  vector[N] z;
  for(n in 1:N) {
    x[n] = bernoulli_rng(p);
    z[n] = uniform_rng(a, b);
  }
}
