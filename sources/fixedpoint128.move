/// @title FixedPoint128
/// @notice A library for handling binary fixed point numbers, see https://en.wikipedia.org/wiki/Q_(number_format)
module razor_libs::fixedpoint128 {
    // Error codes.

    /// When divide by zero attempted.
    const ERR_DIVIDE_BY_ZERO: u64 = 100;

    // Constants.

    const MASK: u256 = 0x100000000000000000000000000000000;

    /// When a and b are equals.
    const EQUAL: u8 = 0;

    /// When a is less than b equals.
    const LESS_THAN: u8 = 1;

    /// When a is greater than b.
    const GREATER_THAN: u8 = 2;

    /// The resource to store `UQ128x128`.
    struct UQ128x128 has copy, store, drop {
        v: u256
    }

    public fun Q128(): u256 {
      MASK
    }

    /// Encode `u128` to `UQ128x128`
    public fun encode(x: u128): UQ128x128 {
        let v = (x as u256) * MASK;
        UQ128x128{ v }
    }

    /// Decode a `UQ128x128` into a `u128` by truncating after the radix point.
    public fun decode(uq: UQ128x128): u128 {
        ((uq.v / MASK) as u128)
    }

    /// Get `u128` from UQ128x128
    public fun to_u256(uq: UQ128x128): u256 {
        uq.v
    }

    /// Multiply a `UQ128x128` by a `u128`, returning a `UQ128x128`
    public fun mul(uq: UQ128x128, y: u128): UQ128x128 {
        // vm would direct abort when overflow occured
        let v = uq.v * (y as u256);

        UQ128x128{ v }
    }

    /// Divide a `UQ128x128` by a `u128`, returning a `UQ128x128`.
    public fun div(uq: UQ128x128, y: u128): UQ128x128 {
        assert!(y != 0, ERR_DIVIDE_BY_ZERO);

        let v = uq.v / (y as u256);
        UQ128x128{ v }
    }

    /// Returns a `UQ128x128` which represents the ratio of the numerator to the denominator.
    public fun fraction(numerator: u128, denominator: u128): UQ128x128 {
        assert!(denominator != 0, ERR_DIVIDE_BY_ZERO);

        let r = (numerator as u256) * MASK;
        let v = r / (denominator as u256);

        UQ128x128{ v }
    }

    /// Compare two `UQ128x128` numbers.
    public fun compare(left: &UQ128x128, right: &UQ128x128): u8 {
        if (left.v == right.v) {
            return EQUAL
        } else if (left.v < right.v) {
            return LESS_THAN
        } else {
            return GREATER_THAN
        }
    }
    
    /// Check if `UQ128x128` is zero
    public fun is_zero(uq: &UQ128x128): bool {
        uq.v == 0
    }
}