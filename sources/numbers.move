module razor_libs::numbers {
  use std::vector;

  const E_INVALID_INPUT: u64 = 1;

  public fun is_even(num: u64): bool {
    num % 2 == 0
  }

  public fun is_odd(num: u64): bool {
    num % 2 != 0
  }

  public fun is_prime(num: u64): bool {
    if (num <= 1) return false;
    if (num == 2) return true;
    if (num % 2 == 0) return false;

    let i = 3;
    while (i * i <= num) {
      if (num % i == 0) return false;
      i = i + 2;
    };
    
    true
  }

  public fun is_perfect_square(num: u64): bool {
    let i: u64 = 0;
    while (i * i <= num) {
        if (i * i == num) {
            return true
        };
        i = i + 1;
    };
    false
  }

  public fun is_fibonacci(num: u64): bool {
    is_perfect_square(5 * num * num + 4) || is_perfect_square(5 * num * num - 4)
  }

  public fun is_palindromic(num: u64): bool {
    let original = num;
    let reversed = 0;
    while (num != 0) {
      reversed = reversed * 10 + (num % 10);
      num = num / 10;
    };
    original == reversed
  }

  public fun is_triangular(num: u64): bool {
    // Using the quadratic formula: n^2 + n - 2*num = 0
    // A triangular number can be represented as n*(n+1)/2 = num
    // We need to find if there exists a positive integer n that satisfies this
    
    // 8*num + 1 needs to be a perfect square
    // And (-1 + sqrt(8*num + 1))/2 needs to be a whole number
    
    if (num == 0) return true;
    
    // Check if 8*num + 1 would overflow
    if (num > (18446744073709551615u64 - 1) / 8) return false;
    
    let discriminant = 8 * num + 1;
    if (!is_perfect_square(discriminant)) return false;
    
    // Calculate (-1 + sqrt(8*num + 1))/2
    let sqrt_disc = ((is_perfect_square_root(discriminant) as u64) - 1) / 2;
    
    // Check if this is the correct n by calculating n*(n+1)/2
    sqrt_disc * (sqrt_disc + 1) / 2 == num
  }

  // Helper function to get the square root if it's a perfect square
  fun is_perfect_square_root(num: u64): u64 {
    let i: u64 = 0;
    while (i * i <= num) {
        if (i * i == num) {
            return i
        };
        i = i + 1;
    };
    0
  }

  public fun is_happy(num: u64): bool {
    let seen = vector::empty<u64>();
    while (num != 1) {
      if (vector::contains(&seen, &num)) return false;
      vector::push_back(&mut seen, num);
      num = sum_of_squares_of_digits(num);
    };
    true
  }

  public fun sum_of_squares_of_digits(num: u64): u64 {
    let sum = 0;
    while (num != 0) {
      let digit = num % 10;
      sum = sum + digit * digit;
      num = num / 10;
    };
    sum
  }
}