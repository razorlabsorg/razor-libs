#[test_only]
module razor_libs::numbers_test {
  use razor_libs::numbers;

  #[test]
  fun test_is_even() {
    assert!(numbers::is_even(0), 0);
    assert!(numbers::is_even(2), 1);
    assert!(numbers::is_even(100), 2);
    assert!(!numbers::is_even(1), 3);
    assert!(!numbers::is_even(99), 4);
  }

  #[test]
  fun test_is_odd() {
    assert!(numbers::is_odd(1), 0);
    assert!(numbers::is_odd(3), 1);
    assert!(numbers::is_odd(99), 2);
    assert!(!numbers::is_odd(0), 3);
    assert!(!numbers::is_odd(100), 4);
  }

  #[test]
  fun test_is_prime() {
    assert!(!numbers::is_prime(0), 0);
    assert!(!numbers::is_prime(1), 1);
    assert!(numbers::is_prime(2), 2);
    assert!(numbers::is_prime(3), 3);
    assert!(!numbers::is_prime(4), 4);
    assert!(numbers::is_prime(5), 5);
    assert!(numbers::is_prime(17), 6);
    assert!(!numbers::is_prime(25), 7);
    assert!(numbers::is_prime(97), 8);
  }

  #[test]
  fun test_is_perfect_square() {
    assert!(numbers::is_perfect_square(0), 0);
    assert!(numbers::is_perfect_square(1), 1);
    assert!(numbers::is_perfect_square(4), 2);
    assert!(numbers::is_perfect_square(9), 3);
    assert!(numbers::is_perfect_square(16), 4);
    assert!(!numbers::is_perfect_square(2), 5);
    assert!(!numbers::is_perfect_square(3), 6);
    assert!(!numbers::is_perfect_square(15), 7);
  }

  #[test]
  fun test_is_fibonacci() {
    assert!(numbers::is_fibonacci(0), 0);
    assert!(numbers::is_fibonacci(1), 1);
    assert!(numbers::is_fibonacci(2), 2);
    assert!(numbers::is_fibonacci(3), 3);
    assert!(numbers::is_fibonacci(5), 4);
    assert!(numbers::is_fibonacci(8), 5);
    assert!(numbers::is_fibonacci(13), 6);
    assert!(!numbers::is_fibonacci(4), 7);
    assert!(!numbers::is_fibonacci(7), 8);
  }

  #[test]
  fun test_is_palindromic() {
    assert!(numbers::is_palindromic(0), 0);
    assert!(numbers::is_palindromic(1), 1);
    assert!(numbers::is_palindromic(11), 2);
    assert!(numbers::is_palindromic(121), 3);
    assert!(numbers::is_palindromic(12321), 4);
    assert!(!numbers::is_palindromic(10), 5);
    assert!(!numbers::is_palindromic(123), 6);
  }

  #[test]
  fun test_is_triangular() {
    assert!(numbers::is_triangular(0), 0);
    assert!(numbers::is_triangular(1), 1);
    assert!(numbers::is_triangular(3), 2);
    assert!(numbers::is_triangular(6), 3);
    assert!(numbers::is_triangular(10), 4);
    assert!(!numbers::is_triangular(2), 5);
    assert!(!numbers::is_triangular(7), 6);
  }

  #[test]
  fun test_is_happy() {
    assert!(numbers::is_happy(1), 0);
    assert!(numbers::is_happy(7), 1);
    assert!(numbers::is_happy(10), 2);
    assert!(numbers::is_happy(13), 3);
    assert!(!numbers::is_happy(4), 4);
    assert!(!numbers::is_happy(89), 5);
  }

  #[test]
  fun test_sum_of_squares_of_digits() {
    assert!(numbers::sum_of_squares_of_digits(0) == 0, 0);
    assert!(numbers::sum_of_squares_of_digits(1) == 1, 1);
    assert!(numbers::sum_of_squares_of_digits(16) == 37, 2); // 1^2 + 6^2 = 37
    assert!(numbers::sum_of_squares_of_digits(123) == 14, 3); // 1^2 + 2^2 + 3^2 = 14
  }
}