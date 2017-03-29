functions {
  real deviance(vector y, vector x, int[] subj_label, 
                real alpha0, vector alpha1, real beta0, 
                real sigsq) {
    real dev;
    vector[num_elements(y)] alpha;
    vector[num_elements(y)] eta;
    alpha = alpha0 + alpha1[subj_label]; // Random intercept
    eta = alpha + beta0 * x; // Single matrix-vector calculation
    dev = (-2) * normal_lpdf(y | eta, sqrt(sigsq)); /* 
                                  Vectorized form of the normal 
                                  probability function */
    return dev;
  }
}
data {
  int<lower=1> N_subj;          // Number of subjects
  int<lower=1> N;               // Sample size
  int<lower=1> subj_label[N];   // Subject label
  vector[N] x;                  // Covariate (age)
  vector[N] y;                  // Response variable (height)
  real m_alpha0;                // Prior mean for alpha0
  real<lower=0> s_alpha0;       // Prior std. dev. for alpha0
  real m_beta0;                 // Prior mean for beta0
  real<lower=0> s_beta0;        // Prior std. dev. for beta0
  real<lower=0> a_sigsq;        // Prior shape for sigsq
  real<lower=0> b_sigsq;        // Prior rate for sigsq
  real<lower=0> a_sigsq_alpha1; // Prior shape for sigsq_alpha1
  real<lower=0> b_sigsq_alpha1; // Prior rate for sigsq_alpha1
}
parameters {
  real alpha0;
  vector[N_subj] alpha1;
  real beta0;
  real<lower=0> sigsq;
  real<lower=0> sigsq_alpha1;
}
model {
  // Likelihood:
  real alpha;
  for(n in 1:N) {
    alpha = alpha0 + alpha1[subj_label[n]]; // Random intercept
    y[n] ~ normal(alpha + beta0 * x[n], sqrt(sigsq));
  }
  // Prior:
  alpha0 ~ normal(m_alpha0, s_alpha0);
  beta0 ~ normal(m_beta0, s_beta0);
  sigsq ~ gamma(a_sigsq, b_sigsq);
  for(i in 1:N_subj) alpha1[i] ~ normal(0, sqrt(sigsq_alpha1));
  // "Hyper-prior":
  sigsq_alpha1 ~ gamma(a_sigsq_alpha1, b_sigsq_alpha1);
}
generated quantities {
  real dev; // Deviance
  dev = deviance(y, x, subj_label, alpha0, alpha1, 
                    beta0, sigsq);
}

