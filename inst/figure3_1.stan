functions {
  real deviance(vector y, matrix X, vector beta, real sigma_sq) {
    real dev = 0;
    for(n in 1:num_elements(y)) {
      real eta = 0;
      for (k in 1:cols(X)) {
        eta = eta + X[n, k] * beta[k];
      }
      dev = dev + (-2) * normal_lpdf(y[n] | eta, sqrt(sigma_sq));
    } 
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
transformed data {
  /* Not used here, but uncomment line
     below to check the sample size has
     been correctly passed from R. */
  //print("N = ", N);
}
parameters {
  real<lower=0> sigma_sq;
  vector[K] beta;
}
transformed parameters {
  // Not used here!
}
model {
  // Likelihood:
  for (n in 1:N) {
    real eta = 0;
    for (k in 1:K) {
      eta = eta + X[n, k] * beta[k];
    }
    y[n] ~ normal(eta, sqrt(sigma_sq));
  }
  // Prior:
  for(k in 1:K) {
    beta[k] ~ normal(m_beta[k], s_beta[k]);
  }
  sigma_sq ~ lognormal(m_sigma_sq, s_sigma_sq);
}
generated quantities {
  real y_pred;  // Predicted response
  real dev; // Deviance
  // Sample from predictive distribution:
  {
    real eta_pred = 0; /* Predicted mean; defined in local
                          block so not stored */
    for (k in 1:K) {
      eta_pred = eta_pred + x_pred[k] * beta[k];
    }
    y_pred = normal_rng(eta_pred, sqrt(sigma_sq));
  }
  dev = deviance(y, X, beta, sigma_sq);
}

