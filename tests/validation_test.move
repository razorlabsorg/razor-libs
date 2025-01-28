#[test_only]
module razor_libs::validation_test {
  use razor_libs::validation;
  use aptos_framework::timestamp;

  #[test(aptos_framework = @0x1)]
  public fun test_check_deadline_success(aptos_framework: &signer) {
    // Setup: Initialize timestamp
    timestamp::set_time_has_started_for_testing(aptos_framework);
    
    // Set current time to 100 seconds
    timestamp::update_global_time_for_test_secs(100);
    
    // Test: Should pass when deadline is in the future
    validation::check_deadline(200);
    
    // Test: Should pass when deadline equals current time
    validation::check_deadline(100);
  }
  
  #[test(aptos_framework = @0x1)]
  #[expected_failure(abort_code = validation::ERR_TRANSACTION_EXPIRED)]
  public fun test_check_deadline_expired(aptos_framework: &signer) {
    // Setup: Initialize timestamp
    timestamp::set_time_has_started_for_testing(aptos_framework);
    
    // Set current time to 100 seconds
    timestamp::update_global_time_for_test_secs(100);
    
    // Test: Should fail when deadline is in the past
    validation::check_deadline(50);
  }
}