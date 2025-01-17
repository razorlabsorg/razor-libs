/// @title FixedPoint96
/// @notice A library for handling binary fixed point numbers, see https://en.wikipedia.org/wiki/Q_(number_format)
/// @dev Used in sqrtpricemath.move
module razor_libs::fixedpoint96 {
  const RESOLUTION: u8 = 96;
  const Q96: u256 = 0x1000000000000000000000000;

  public fun resolution(): u8 {
    return RESOLUTION
  }

  public fun q96(): u256 {
    return Q96
  }
}