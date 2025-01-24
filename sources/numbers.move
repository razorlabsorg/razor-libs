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
    let sum = 0;
    let n = 1;
    while (sum < num) {
      sum = sum + n;
      if (sum == num) return true;
      n = n + 1;
    };
    false
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