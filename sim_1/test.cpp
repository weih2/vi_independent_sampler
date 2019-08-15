#include "include.h"

using namespace std;
#define DELTA 5.

int main(){
  simulation_data sim1;
  sim1.g_vars.n_samples = 1000;
  sim1.g_vars.K = 3;
  sim1.g_vars.sigma_2 = 30;

  sim1.b_vars.confidence = 0.95;

  generate_latent_pars(sim1);
  sim1.l_vars.mu[0] = -DELTA;
  sim1.l_vars.mu[1] = 0;
  sim1.l_vars.mu[2] = DELTA;

  generate_data(sim1);
  generate_weights(sim1);

  cavi_implementation sim0(sim1, 500);
  // cavi_implementation sim2(sim1, 500);

  int n_steps = 1000;
  sim0.cavi_update(n_steps);
  // sim2.cavi_update(n_steps);

  /*
  cout << "true latent means: " << sim1.l_vars.mu[0] << " and " << sim1.l_vars.mu[1] << endl;
  cout << "vb posterior means: " << sim0.est.m[0] << " and " << sim0.est.m[1] << endl;
  cout << "n obs: " << sim1.g_vars.n_samples << endl;
  cout << "estimated variance: ";
  */
  for(int k = 0; k < sim1.g_vars.K; k++) cout << sim0.est.s2[k] << " ";
  cout << endl;

  // for(int k = 0; k < sim1.g_vars.K; k++) cout << sim0.est.m[k] << " ";
  // cout << endl;
  // cout << "another vb posterior means: " << sim2.est.m[0] << " and " << sim2.est.m[1] << endl;

  // sim0.cs_construct();

  /*

  int n_covered = 0;
  int n_experiments = 200;

  for(int n_e = 0; n_e < n_experiments; n_e ++){
    // regenerate data
    generate_data(sim0.data);

    sim0.cavi_bootstrap_update(n_steps);
    sim0.ci_construct();

    if((sim0.bootstrap_ci[0][0] <= sim0.data.l_vars.mu[0]) && (sim0.data.l_vars.mu[0] <= sim0.bootstrap_ci[0][1]))
      n_covered++;
  }

  cout << "coverage: " << n_covered << endl;
  */
  return 0;
}
