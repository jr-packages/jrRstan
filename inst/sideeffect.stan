data {
  int<lower=1> N;           // Number cases
  int<lower=1> K;           /* Number columns in design matrix, 
                               i.e. number covariates + 1 */
  matrix[N, K] Xtilde;      // Design matrix
  int<lower=0> y[N];        // Binomial response
  int<lower=0> n[N];        // Number patients (trials)
  real beta_mean[K];        // Means in beta prior
  real<lower=0> beta_sd[K]; // Standard deviations in beta prior
}
transformed data {
  matrix[N, K] X; /* Centered design matrix: we could have avoided 
                     this block by performing the transformation in
                     R. */
  X[,1] = Xtilde[,1];
  X[,2] = Xtilde[,2] - mean(Xtilde[,2]);
}
parameters {
  vector[K] beta;
}
model {
  vector[N] eta = X * beta; // Fast matrix-vector calculation
  // Likelihood:
  y ~ binomial_logit(n, eta); /* Arithmetically stable form of fast,
                                 vectorized sampling statement */
  // Prior:
  beta ~ normal(beta_mean, beta_sd); /* Fast, vectorized sampling
                                        statement */
}
