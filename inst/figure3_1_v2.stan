functions {
  real deviance(vector y, matrix X, vector beta, real sigma_sq) {
    vector[num_elements(y)] eta = X * beta; /* Single matrix-vector 
                                               calculation */
    real dev = (-2) * normal_lpdf(y | eta, sqrt(sigma_sq)); /* 
                                  Vectorized form of the normal 
                                  probability function */
    return dev;
  }
}
data {
  int<lower=1> K;           // No. columns in design matrix
  int<lower=1> N;           // Sample size
  matrix[N, K] X;           // Design matrix
  vector[N] y;              // Response variables
  row_vector[K] x_pred;     // Design matrix for prediction
  real m_beta[K];           // Prior means for beta[k]
  real m_sigma_sq;          // Prior mean for log(sigma_sq)
  real<lower=0> s_beta[K];  // Prior std. devs for beta[k]
  real<lower=0> s_sigma_sq; // Prior std. dev for log(sigma_sq)
}
parameters {
  real<lower=0> sigma_sq;
  vector[K] beta;
}
model {
  // Likelihood:
  vector[N] eta = X * beta; // Single matrix-vector calculation
  y ~ normal(eta, sqrt(sigma_sq)); /* Vectorized form of the normal 
                                      probability function */
  // Prior:
  beta ~ normal(m_beta, s_beta);  /* Vectorized form of the normal 
                                      probability function */
  sigma_sq ~ lognormal(m_sigma_sq, s_sigma_sq);
}
generated quantities {
  real y_pred;  // Predicted response
  real dev; // Deviance
  // Sample from predictive distribution:
  {
    // Predicted mean, defined in local block so not stored:
    real eta_pred = x_pred * beta; /* Single matrix-vector 
                                      calculation */
    y_pred = normal_rng(eta_pred, sqrt(sigma_sq));
  }
  dev = deviance(y, X, beta, sigma_sq);
}

