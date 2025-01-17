#[test_only]
module razor_libs::tickmath_math {
  use razor_libs::tickmath;
  use razor_libs::i256;

  #[test]
  #[expected_failure(abort_code = 1, location = razor_libs::tickmath)]
  public fun get_sqrt_ratio_at_tick_throws_for_too_low() {
    let min_tick = tickmath::MIN_TICK();
    tickmath::get_sqrt_ratio_at_tick(i256::sub(min_tick, i256::one()));
  }

  #[test]
  #[expected_failure(abort_code = 1, location = razor_libs::tickmath)]
  public fun get_sqrt_ratio_at_tick_throws_for_too_high() {
    let max_tick = tickmath::MAX_TICK();
    tickmath::get_sqrt_ratio_at_tick(i256::add(max_tick, i256::one()));
  }

  #[test]
  public fun get_sqrt_ratio_at_tick_min_tick() {
    let min_tick = tickmath::MIN_TICK();
    assert!(tickmath::get_sqrt_ratio_at_tick(min_tick) == 4295128739, 0);
  }

  #[test]
  public fun get_sqrt_ratio_at_tick_max_tick() {
    let max_tick = tickmath::MAX_TICK();
    assert!(tickmath::get_sqrt_ratio_at_tick(max_tick) == 1461446703485210103287273052203988822378723970342, 1);
  }

  #[test]
  public fun get_sqrt_ratio_at_tick_min_tick_plus_1() {
    let min_tick = tickmath::MIN_TICK();
    assert!(tickmath::get_sqrt_ratio_at_tick(i256::add(min_tick, i256::one())) == 4295343490, 2);
  }

  #[test]
  public fun get_sqrt_ratio_at_tick_max_tick_minus_1() {
    let max_tick = tickmath::MAX_TICK();
    assert!(tickmath::get_sqrt_ratio_at_tick(i256::sub(max_tick, i256::one())) == 1461373636630004318706518188784493106690254656249, 3);
  }

  #[test]
  public fun test_min_sqrt_ratio() {
    let min_tick = tickmath::MIN_TICK();
    let min = tickmath::get_sqrt_ratio_at_tick(min_tick);
    let min_sqrt_ratio = tickmath::min_sqrt_ratio();

    assert!(min == min_sqrt_ratio, 4);
  }

  #[test]
  public fun test_max_sqrt_ratio() {
    let max_tick = tickmath::MAX_TICK();
    let max = tickmath::get_sqrt_ratio_at_tick(max_tick);
    let max_sqrt_ratio = tickmath::max_sqrt_ratio();

    assert!(max == max_sqrt_ratio, 5);
  }

  #[test]
  #[expected_failure(abort_code = 0, location = razor_libs::tickmath)]
  public fun get_tick_at_sqrt_ratio_throws_for_too_low() {
    let min_sqrt_ratio = tickmath::min_sqrt_ratio();
    tickmath::get_tick_at_sqrt_ratio(min_sqrt_ratio - 1);
  }

  #[test]
  #[expected_failure(abort_code = 0, location = razor_libs::tickmath)]
  public fun get_tick_at_sqrt_ratio_throws_for_too_high() {
    let max_sqrt_ratio = tickmath::max_sqrt_ratio();
    tickmath::get_tick_at_sqrt_ratio(max_sqrt_ratio + 1);
  }

  #[test]
  public fun test_ratio_of_min_tick() {
    let min_sqrt_ratio = tickmath::min_sqrt_ratio();
    let tick = tickmath::get_tick_at_sqrt_ratio(min_sqrt_ratio);
    assert!(tick == tickmath::MIN_TICK(), 6);
  }

  #[test]
  public fun test_ratio_of_min_tick_plus_1() {
    let tick = tickmath::get_tick_at_sqrt_ratio(4295343490);
    assert!(tick == i256::add(tickmath::MIN_TICK(), i256::one()), 7);
  }

  #[test]
  public fun test_ratio_of_max_tick_minus_1() {
    let tick = tickmath::get_tick_at_sqrt_ratio(1461373636630004318706518188784493106690254656249);
    assert!(tick == i256::sub(tickmath::MAX_TICK(), i256::one()), 8);
  }

  #[test]
  public fun test_ratio_closest_to_max_tick() {
    let max_sqrt_ratio = tickmath::max_sqrt_ratio();
    let tick = tickmath::get_tick_at_sqrt_ratio(max_sqrt_ratio - 1);
    assert!(tick == i256::sub(tickmath::MAX_TICK(), i256::one()), 9);
  }
}