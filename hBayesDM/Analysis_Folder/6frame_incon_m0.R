# load packages
install.packages("hBayesDM",dependencies = TRUE)
library(rstan)
library(hBayesDM)
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)
library(loo)
library(bayesplot)
# run the model
M0 <- choiceRT_ddm("D:/8001DATA/modified_data2.txt", niter=4000, nwarmup=1000, nchain=4)
# posterior distributions of hyper-parameters(distributions should be unimodal)
# group-level
plot(M0)  
# subject-level
posterior <- as.array(M0$fit)
# subject-level(alpha)
params_to_plot <- paste0("alpha[", 1:10, "]")
mcmc_areas(posterior, pars = params_to_plot) +
  ggtitle("Posterior distributions of alpha for first 10 subjects")
# subject-level(beta)
params_to_plot <- paste0("beta[", 1:10, "]")
mcmc_areas(posterior, pars = params_to_plot) +
  ggtitle("Posterior distributions of beta for first 10 subjects")
# subject-level(delta)
params_to_plot <- paste0("delta[", 1:10, "]")
mcmc_areas(posterior, pars = params_to_plot) +
  ggtitle("Posterior distributions of delta for first 10 subjects")
# subject-level(tau)
params_to_plot <- paste0("tau[", 1:10, "]")
mcmc_areas(posterior, pars = params_to_plot) +
  ggtitle("Posterior distributions of tau for first 10 subjects")
# Check convergence of the sampling chains(should look like 'hairy caterpillars')
plot(M0, type="trace", fontSize=11)
# Posterior distributions of the group-level (hyper)parameters
plot(M0, type="trace", inc_warmup=T) 
# R_hat
rhat(M0$fit,pars="mu_alpha")
rhat(M0$fit,pars="mu_beta")
rhat(M0$fit,pars="mu_delta")
rhat(M0$fit,pars="mu_tau")
# n_eff
summary(M0$fit, pars = "mu_alpha")$summary[, "n_eff"]
summary(M0$fit, pars = "mu_beta")$summary[, "n_eff"]
summary(M0$fit, pars = "mu_delta")$summary[, "n_eff"]
summary(M0$fit, pars = "mu_tau")$summary[, "n_eff"]
# parameter histograms
samples <- rstan::extract(M0$fit)
delta_samples <- samples$delta
alpha_samples <- samples$alpha
beta_samples <- samples$beta
tau_samples <- samples$tau
hist(delta_samples, breaks = 30, main = "delta")
hist(alpha_samples, breaks = 30, main = "alpha")
hist(beta_samples, breaks = 30, main = "beta")
hist(tau_samples, breaks = 30, main = "tau")
# Plotting the posterior density
parameter_samples <- as.matrix(M0$fit, pars = c("mu_alpha", "mu_beta", "mu_delta", "mu_tau"))
mcmc_dens(parameter_samples)
# DIC
posterior_samples <- rstan::extract(M0$fit)
log_lik <- rstan::extract(M0$fit, pars = "log_lik")$log_lik
D_theta <- -2 * rowSums(log_lik) 
D_theta_mean <- mean(D_theta)
theta_hat <- mean(posterior_samples$theta) 
log_lik_theta_hat <- -2 * sum(log_lik[which.min(D_theta), ]) 
D_theta_hat <- log_lik_theta_hat
p_D <- D_theta_mean - D_theta_hat
DIC <- D_theta_mean + p_D
cat("DIC =", DIC, "\n")
# Rope Plot
delta_vec <- as.vector(delta_samples)
plotHDI(
  sample = delta_vec,
  credMass = 0.95,
  Title = "Rope Plot for delta",
  xLab = "Parameter value",
  yLab = "Density",
  fontSize = 14,
  binSize = 40)
delta_vec <- as.vector(alpha_samples)
plotHDI(
  sample = delta_vec,
  credMass = 0.95,
  Title = "Rope Plot for alpha",
  xLab = "Parameter value",
  yLab = "Density",
  fontSize = 14,
  binSize = 40)
delta_vec <- as.vector(beta_samples)
plotHDI(
  sample = delta_vec,
  credMass = 0.95,
  Title = "Rope Plot for beta",
  xLab = "Parameter value",
  yLab = "Density",
  fontSize = 14,
  binSize = 40)
delta_vec <- as.vector(tau_samples)
plotHDI(
  sample = delta_vec,
  credMass = 0.95,
  Title = "Rope Plot for tau",
  xLab = "Parameter value",
  yLab = "Density",
  fontSize = 14,
  binSize = 40)