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
  real<lower=0> a_sigsq_beta1;  // Prior shape for sigsq_beta1
  real<lower=0> b_sigsq_beta1;  // Prior rate for sigsq_beta1
}
parameters {
  real alpha0;
  vector[N_subj] alpha1;
  real beta0;
  vector[N_subj] beta1;
  real<lower=0> sigsq;
  real<lower=0> sigsq_alpha1;
  real<lower=0> sigsq_beta1;
}
model {
  // Likelihood:
  vector[N] alpha = alpha0 + alpha1[subj_label]; // Random intercept
  vector[N] beta = beta0 + beta1[subj_label];    // Random slope
  y ~ normal(alpha + beta .* x, sqrt(sigsq));
  // Prior:
  alpha0 ~ normal(m_alpha0, s_alpha0);
  beta0 ~ normal(m_beta0, s_beta0);
  sigsq ~ gamma(a_sigsq, b_sigsq);
  alpha1 ~ normal(0, sqrt(sigsq_alpha1));
  beta1 ~ normal(0, sqrt(sigsq_beta1));
  // "Hyper-prior":
  sigsq_alpha1 ~ gamma(a_sigsq_alpha1, b_sigsq_alpha1);
  sigsq_beta1 ~ gamma(a_sigsq_beta1, b_sigsq_beta1);
}

