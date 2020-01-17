transformed data {
  int<lower=1> N = 30;
  real<lower=0,upper=1> p = 0.8;
  real a = -3;
  real b = 3;
}
model {
}
generated quantities {
  vector[N] y;
  for(n in 1:N) {
    /* Define xz in a block so that it becomes a
       local variable that will not be printed */
    real xz[2];
    xz[1] = bernoulli_rng(p);
    xz[2] = uniform_rng(a, b);
    y[n] = normal_rng(2.5 * xz[1] + 1.5 * xz[2], 0.1);
  }
}
