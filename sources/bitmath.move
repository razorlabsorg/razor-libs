/// @title BitMath
/// @dev This library provides functionality for computing bit properties of an unsigned integer
module razor_libs::bitmath {
  const MAX_U256: u256 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  const MAX_U128: u256 = 340282366920938463463374607431768211455;
  const MAX_U64: u256 =  18446744073709551615;
  const MAX_U32: u256 = 4294967295;
  const MAX_U16: u256 =  65535;
  const MAX_U8: u256 = 255;

  const ERROR_INVALID_VALUE: u64 = 0;

  public fun closest_bit_right(x: u256, bit: u8): u256 {
    let shift = 255 - bit;
    x = x << shift;
    if (x == 0) {
      return MAX_U256
    } else {
      ((most_significant_bit(x) - shift) as u256)
    }
  }

  public fun closest_bit_left(x: u256, bit: u8): u256 {
    x = x >> bit;
    if (x == 0) {
      return MAX_U256
    } else {
      ((least_significant_bit(x) + bit) as u256)
    }
  }

  /// @notice Returns the index of the most significant bit of the number,
  ///     where the least significant bit is at index 0 and the most significant bit is at index 255
  /// @dev The function satisfies the property:
  ///     x >= 2**mostSignificantBit(x) and x < 2**(mostSignificantBit(x)+1)
  /// @param x the value for which to compute the most significant bit, must be greater than 0
  /// @return r the index of the most significant bit
  public fun most_significant_bit(x: u256): u8 {
    assert!(x > 0, ERROR_INVALID_VALUE);

    let r = 0;

    if (x >= 0x100000000000000000000000000000000) {
        x = x >> 128;
        r = r + 128;
    };

    if (x >= 0x10000000000000000) {
        x = x >> 64;
        r = r + 64;
    };

    if (x >= 0x100000000) {
        x = x >> 32;
        r = r + 32;
    };

    if (x >= 0x10000) {
        x = x >> 16;
        r = r + 16;
    };
      
    if (x >= 0x100) {
        x = x >> 8;
        r = r + 8;
    };

    if (x >= 0x10) {
        x = x >> 4;
        r = r + 4;
    };

    if (x >= 0x4) {
        x = x >> 2;
        r = r + 2;
    };

    if (x >= 0x2) r = r + 1;
    r
  }

  /// @notice Returns the index of the least significant bit of the number,
  ///     where the least significant bit is at index 0 and the most significant bit is at index 255
  /// @dev The function satisfies the property:
  ///     (x & 2**leastSignificantBit(x)) != 0 and (x & (2**(leastSignificantBit(x)) - 1)) == 0)
  /// @param x the value for which to compute the least significant bit, must be greater than 0
  /// @return r the index of the least significant bit
  public fun least_significant_bit(x: u256): u8 {
    assert!(x > 0, ERROR_INVALID_VALUE);
    let r = 255;
        
    if (x & MAX_U128 > 0) {
            r = r - 128;
        } else {
            x = x >> 128;
        };
    
    if (x & MAX_U64 > 0) {
            r = r - 64;
        } else {
            x = x >> 64;
        };
    
    if (x & MAX_U32 > 0) {
            r = r - 32;
        } else {
            x = x >> 32;
        };

    if (x & MAX_U16 > 0) {
            r = r - 16;
        } else {
            x = x >> 16;
        };
        
    if (x & MAX_U8 > 0) {
            r = r - 8;
        } else {
            x = x >> 8;
        };
        
    if (x & 0xf > 0) {
            r = r - 4;
        } else {
            x= x >> 4;
        };
    
    if (x & 0x3 > 0) {
            r = r - 2;
        } else {
            x = x >> 2;
        };

    if (x & 0x1 > 0) r = r - 1;
    
    r
  }
}