/* General K component mixture of normals, saved in
   oldfaithful_gen.stan */
data {
  int<lower=0> N;        // Sample size
  int<lower=1> K;        // Number of components
  vector[N] y;           // Data
  real<lower=0> a_pi;    /* Repeated prior 
                            hyperparameter for pi_vec */
  real m_mu;             // Prior mean for mu[k]
  real<lower=0> s_mu;    // Prior std. dev. for mu[k]
  real<lower=0> a_siqsq; // Prior shape for sigsq[k]
  real<lower=0> b_sigsq; // Prior rate for sigsq[k]
}
transformed data {
  vector<lower=0>[K] a_pi_vec;
  for(k in 1:K) a_pi_vec[k] = a_pi;
}
parameters {
  simplex[K] pi_vec;
  ordered[K] mu;
  vector<lower=0>[K] sigsq;
}
model {
  vector[K] tmp;
  // Likelihood:
  for(n in 1:N) {
    for(k in 1:K) {
      tmp[k] = log(pi_vec[k]) + normal_lpdf(y[n] | mu[k], sqrt(sigsq[k]));  
    }
    target += log_sum_exp(tmp);
  }
  // Prior:
  pi_vec ~ dirichlet(a_pi_vec);
  mu ~ normal(m_mu, s_mu);
  sigsq ~ inv_gamma(a_siqsq, b_sigsq);
}

