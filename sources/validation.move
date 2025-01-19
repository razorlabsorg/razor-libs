/// @title Validation
/// @notice A library for validating transactions
module razor_libs::validation {
  use aptos_framework::timestamp;

  const ERR_TRANSACTION_EXPIRED: u64 = 1;

  public fun check_deadline(deadline: u64) {
    assert!(timestamp::now_seconds() <= deadline, ERR_TRANSACTION_EXPIRED);
  }
}