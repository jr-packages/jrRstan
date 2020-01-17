data {
  int<lower=0> N;        // No. studies (sample size)
  int<lower=0> y[N];     // No. of rats with tumours
  int<lower=0> n[N];     // Total number of rats
  real m_mu;             // Prior mean for mu
  real<lower=0> s_mu;    // Prior std. dev. for mu
  real<lower=0> a_sigsq; // Prior shape for sigsq
  real<lower=0> b_sigsq; // Prior rate for sigsq
}
parameters {
  vector[N] phi; // New parameters
  real mu;
  real<lower=0> sigsq;
}
model {
  // Likelihood:
  y ~ binomial_logit(n, mu + sqrt(sigsq) * phi);
  // Prior:
  phi ~ normal(0, 1);
  // "Hyperprior":
  mu ~ normal(m_mu, s_mu);
  sigsq ~ gamma(a_sigsq, b_sigsq);
}
generated quantities {
  vector[N] theta = mu + sqrt(sigsq) * phi; /* 
                        Original parameters */
  vector<lower=0, upper=1>[N] p = inv_logit(theta); /* 
                     Study-specific prob. of tumour */ 
  real<lower=0, upper=1> p_pop = inv_logit(mu); /* 
                   "Population" prob. of tumour */
}
