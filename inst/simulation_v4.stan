transformed data {
  int<lower=1> N = 30;
  real<lower=0,upper=1> p = 0.8;
  real a = -3;
  real b = 3;
}
model {
}
generated quantities {
  vector[N] xz[2];
  for(n in 1:N) {
    xz[1][n] = bernoulli_rng(p);
    xz[2][n] = uniform_rng(a, b);
  }
}
