transformed data {
  int<lower=1> N;
  real<lower=0,upper=1> p;
  real a;
  real b;
  N = 30;
  p = 0.8;
  a = -3;
  b = 3;
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
