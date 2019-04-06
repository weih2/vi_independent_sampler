using namespace std;

void bridge::save_result(ostream& result_stream){
    // saving true value
    result_stream << "true mu's are:" << endl;
    for(int k = 0; k < K; k++){
      result_stream << host_dev_settings.l_vars.mu[k] << " ";
    }
    result_stream << endl;

    for(int k = 0; k < K; k++){
      result_stream << "variational wlb confidence set coverage for parameter " << k + 1 << " :" << vwlb_cs_covered_counts[k] << endl;
    }

    for(int k = 0; k < K; k++){
      result_stream << "variational confidence set coverage for parameter " << k + 1 << " :" << vp_cs_covered_counts[k] << endl;
    }

    for(int k = 0; k < K; k++){
      result_stream << "empirical confidence set coverage for parameter " << k + 1 << " :" << empirical_ci_covered_counts[k] << endl;
    }

    auto timenow = chrono::system_clock::to_time_t(chrono::system_clock::now());

    result_stream << "simulation ends at: " << ctime(&timenow) << endl;
    result_stream << endl;
}
