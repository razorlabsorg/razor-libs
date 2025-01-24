module razor_libs::treemath {
  use std::bcs;
  use std::vector;

  use aptos_std::from_bcs;
  use aptos_std::simple_map::{Self, SimpleMap};

  use razor_libs::bit;
  use razor_libs::bitmath;

  const MAX_U256: u256 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

  struct Tree has copy, drop, store {
    level0: vector<u8>,
    level1: SimpleMap<vector<u8>, vector<u8>>,
    level2: SimpleMap<vector<u8>, vector<u8>>,
  }

  public fun new(): Tree {
    Tree {
      level0: vector::empty<u8>(),
      level1: simple_map::new(),
      level2: simple_map::new()
    }
  }

  public fun contains(tree: Tree, id: u32): bool {
    let leaf = bcs::to_bytes(&((id as u256) >> 8));

    let exist = simple_map::contains_key(&tree.level2, &leaf);
    let other = 1 << ((id as u8) & 255);
    return exist && other != 0
  }

  public fun add(tree: &mut Tree, id: u32): (bool, vector<u8>) {
    let level0 = tree.level0;
    let level1 = tree.level1;
    let level2 = tree.level2;

    let key2 = bcs::to_bytes(&((id as u256) >> 8));
    let leaves = *simple_map::borrow(&level2, &key2);
    let new_leaves_int = from_bcs::to_u256(leaves) | (1 << ((id as u8) & 255));
    let new_leaves = bcs::to_bytes(&new_leaves_int);
    if (leaves != new_leaves) {
      simple_map::upsert(&mut level2, key2, new_leaves);

      if (from_bcs::to_u256(leaves) == 0) {
        let key1 = bcs::to_bytes(&(from_bcs::to_u256(key2) >> 8));
        leaves = *simple_map::borrow(&level1, &key1);

        let value1_int = from_bcs::to_u256(leaves) | (1 << ((from_bcs::to_u256(key2) as u8) & 255));
        let value1 = bcs::to_bytes(&value1_int);
        simple_map::upsert(&mut level1, key1, value1);

        if (from_bcs::to_u256(leaves) == 0) {
          let level0_int = from_bcs::to_u256(level0) | (1 << ((from_bcs::to_u256(key1) as u8) & 255));
          level0 = bcs::to_bytes(&level0_int);
        };
      };

      return (true, level0)
    };

    return (false, level0)
  }

  public fun remove(tree: &mut Tree, id: u32): (bool, vector<u8>){
    let level0 = tree.level0;
    let level1 = tree.level1;
    let level2 = tree.level2;

    let key2 = bcs::to_bytes(&((id as u256) >> 8));
    let leaves = *simple_map::borrow(&level2, &key2);
    let new_leaves_int = from_bcs::to_u256(leaves) & bit::bit_not(from_bcs::to_u256(leaves) | (1 << ((id as u8) & 255)));
    let new_leaves = bcs::to_bytes(&new_leaves_int);

    if (leaves != new_leaves) {
      simple_map::upsert(&mut level2, key2, new_leaves);

      if (from_bcs::to_u256(new_leaves) == 0) {
        let key1 = bcs::to_bytes(&(from_bcs::to_u256(key2) >> 8));
        let new_leaves_int = from_bcs::to_u256(*simple_map::borrow(&level1, &key1)) & bit::bit_not((1 << ((from_bcs::to_u256(key2) as u8) & 255)));
        new_leaves = bcs::to_bytes(&new_leaves_int);

        simple_map::upsert(&mut level1, key1, new_leaves);

        if (from_bcs::to_u256(new_leaves) == 0) {
          let level0_int = from_bcs::to_u256(level0) & bit::bit_not(1 << ((from_bcs::to_u256(key1) as u8) & 255));
          level0 = bcs::to_bytes(&level0_int);
        };
      };

      return (true, level0)
    };

    return (false, level0)
  }

  public fun find_first_right(
    tree: &Tree,
    id: u32,
  ): u32 {
    let leaves: vector<u8>;
    let level0 = tree.level0;
    let level1 = tree.level1;
    let level2 = tree.level2;

    let key2 = bcs::to_bytes(&((id as u256) >> 8));
    let bit = (id as u8) & 255;

    if (bit != 0) {
      leaves = *simple_map::borrow(&level2, &key2);
      let closest_bit = closest_bit_right(leaves, bit);

      if (closest_bit != MAX_U256) {
        return ((from_bcs::to_u32(key2) << 8) | (closest_bit as u32))
      };
    };

    let key1 = bcs::to_bytes(&(from_bcs::to_u256(key2) >> 8));
    bit = (from_bcs::to_u256(key2) as u8) & 255;

    if (bit != 0) {
      leaves = *simple_map::borrow(&level1, &key1);
      let closest_bit = closest_bit_right(leaves, bit);

      if (closest_bit != MAX_U256) {
        key2 = bcs::to_bytes(&((from_bcs::to_u256(key1) >> 8) | (closest_bit)));
        leaves = *simple_map::borrow(&level2, &key2);
        return ((from_bcs::to_u32(key2) << 8) | (bitmath::most_significant_bit(from_bcs::to_u256(leaves)) as u32))
      };
    };

    bit = (from_bcs::to_u256(key1) as u8) & 255;

    if (bit != 0) {
      leaves = level0;
      let closest_bit = closest_bit_right(leaves, bit);

      if (closest_bit != MAX_U256) {
        key1 = bcs::to_bytes(&closest_bit);
        leaves = *simple_map::borrow(&level1, &key1);

        key2 = bcs::to_bytes(&((from_bcs::to_u256(key1) << 8) | (bitmath::most_significant_bit(from_bcs::to_u256(leaves)) as u256)));
        leaves = *simple_map::borrow(&level2, &key2);
        return (from_bcs::to_u32(key2) << 8) | (bitmath::most_significant_bit(from_bcs::to_u256(leaves)) as u32)
      };
    };

    return 0xFFFFFFFF
  }

  public fun find_first_left(tree: &Tree, id: u32): u32 {
    let leaves: vector<u8>;
    let level0 = tree.level0;
    let level1 = tree.level1;
    let level2 = tree.level2;

    let key2 = bcs::to_bytes(&((id as u256) >> 8));
    let bit = (id as u8) & 255;

    if (bit != 255) {
      leaves = *simple_map::borrow(&level2, &key2);
      let closest_bit = closest_bit_left(leaves, bit);

      if (closest_bit != MAX_U256) {
        return ((from_bcs::to_u32(key2) << 8) | (closest_bit as u32))
      };
    };

    let key1 = bcs::to_bytes(&(from_bcs::to_u256(key2) >> 8));
    bit = (from_bcs::to_u256(key2) as u8) & 255;

    if (bit != 255) {
      leaves = *simple_map::borrow(&level1, &key1);
      let closest_bit = closest_bit_left(leaves, bit);

      if (closest_bit != MAX_U256) {
        key2 = bcs::to_bytes(&((from_bcs::to_u256(key1) >> 8) | (closest_bit)));
        leaves = *simple_map::borrow(&level2, &key2);
        return ((from_bcs::to_u32(key2) << 8) | (bitmath::most_significant_bit(from_bcs::to_u256(leaves)) as u32))
      };
    };

    bit = (from_bcs::to_u256(key1) as u8) & 255;

    if (bit != 255) {
      leaves = level0;
      let closest_bit = closest_bit_left(leaves, bit);

      if (closest_bit != MAX_U256) {
        key1 = bcs::to_bytes(&closest_bit);
        leaves = *simple_map::borrow(&level1, &key1);

        key2 = bcs::to_bytes(&((from_bcs::to_u256(key1) << 8) | (bitmath::most_significant_bit(from_bcs::to_u256(leaves)) as u256)));
        leaves = *simple_map::borrow(&level2, &key2);
        return (from_bcs::to_u32(key2) << 8) | (bitmath::most_significant_bit(from_bcs::to_u256(leaves)) as u32)
      };
    };

    return 0xFFFFFFFF
  }

  fun closest_bit_right(leaves: vector<u8>, bit: u8): u256 {
    return bitmath::closest_bit_right(from_bcs::to_u256(leaves), bit - 1)
  }

  fun closest_bit_left(leaves: vector<u8>, bit: u8): u256 {
    return bitmath::closest_bit_left(from_bcs::to_u256(leaves), bit + 1)
  }
}