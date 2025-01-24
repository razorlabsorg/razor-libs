module razor_libs::encoded {
  use std::bcs;

  use aptos_std::from_bcs;

  use razor_libs::bit;

  public fun MASK_UINT64(): u256 {
    0xffffffffffffffff
  }

  public fun MASK_UINT24(): u256 {
    0xffffff
  }

  public fun MASK_UINT16(): u256 {
    0xffff
  }

  public fun MASK_UINT1(): u256 {
    0x1
  }

  public fun set(
    encoded: vector<u8>, 
    value: u256, 
    mask: u256,
    offset: u8
  ): vector<u8> {
    let shifted_mask = bit::shl(mask, offset);
    let cleared_encoded = bit::bit_and(from_bcs::to_u256(encoded), bit::bit_not(shifted_mask));
    let shifted_value = bit::shl(bit::bit_and(value, mask), offset);
    let new_encoded = bit::bit_or(cleared_encoded, shifted_value);
    bcs::to_bytes(&new_encoded)
  }

  public fun set_bool(encoded: vector<u8>, boolean: bool, offset: u8): vector<u8> {
    let value = if (boolean) { 1 } else { 0 };
    set(encoded, value, MASK_UINT1(), offset)
  }

  public fun decode(encoded: vector<u8>, mask: u256, offset: u8): u256 {
    let shifted_encoded = bit::shr(from_bcs::to_u256(encoded), offset);
    let value = bit::bit_and(shifted_encoded, mask);
    value
  }

  public fun decode_bool(encoded: vector<u8>, offset: u8): bool {
    let value = decode(encoded, MASK_UINT1(), offset);
    value == 1
  }

  public fun decode_u16(encoded: vector<u8>, offset: u8): u16 {
    let value = decode(encoded, MASK_UINT16(), offset);
    value as u16
  }

  public fun decode_u24(encoded: vector<u8>, offset: u8): u32 {
    let value = decode(encoded, MASK_UINT24(), offset);
    value as u32
  }

  public fun decode_u64(encoded: vector<u8>, offset: u8): u64 {
    let value = decode(encoded, MASK_UINT64(), offset);
    value as u64
  }
}