data {
  int<lower=0> N_obs;
  int<lower=0> N_cens;
  int<lower=1> J; // Number columns in design matrix
  vector<lower=0>[N_obs] t_obs;
  vector<lower=0>[N_cens] t_cens; // Lower bounds
  matrix[N_obs, J] X_obs;
  matrix[N_cens, J] X_cens;
  real beta_mean[J];
  real<lower=0> beta_sd[J];
}
parameters {
  vector[J] beta;
}
model {
  t_obs ~ exponential(exp(X_obs * beta));
  target += exponential_lccdf(t_cens | exp(X_cens * beta));
  beta ~ normal(beta_mean, beta_sd);
}
