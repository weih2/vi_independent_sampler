__global__ void cavi_execute(bridge bg, int bootstrap_execution){
  int t_id = threadIdx.x + blockIdx.x * blockDim.x;
  if(t_id >= n_experiments) return;
  device_cavi_implementation thread_implementation(bg.device_dev_settings, t_id);
  // obtain point estimates
  thread_implementation.device_cavi_point_estimate();

  if(bootstrap_execution){
    thread_implementation.device_weighted_cavi_point_estimate();
    thread_implementation.device_vwlb_cs_construct();
    thread_implementation.device_vp_cs_construct();

    for(int k = 0; k < K; k++){
      if((thread_implementation.vp_cs[k][0] < thread_implementation.mu[k])
        &&(thread_implementation.vp_cs[k][1] > thread_implementation.mu[k]))
        device_vp_cs_covered[k * n_experiments + t_id]++;
      if((thread_implementation.vwlb_cs[k][0] < thread_implementation.mu[k])
        &&(thread_implementation.vwlb_cs[k][1] > thread_implementation.mu[k]))
        device_vwlb_cs_covered[k * n_experiments + t_id]++;
    }
  }

  // in a non-bootstrap implementation this is all we need
  for(int k = 0; k < K; k++){
    (bg.device_empirical_mu)[t_id + k * n_experiments] = thread_implementation.m[k];
  }
}
