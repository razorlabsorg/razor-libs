module razor_libs::sort {
  use std::vector;

  use aptos_framework::object::{Self, Object};
  use aptos_framework::fungible_asset::Metadata;

  use aptos_std::comparator;

  /// Identical Addresses
  const ERROR_IDENTICAL_ADDRESSES: u64 = 1;

  /// Determines if two token metadata objects are in canonical order based on their addresses
  /// @param token0: First token metadata object
  /// @param token1: Second token metadata object
  /// @return bool: true if tokens are in correct order (token0 < token1)
  public fun is_sorted(token0: Object<Metadata>, token1: Object<Metadata>): bool {
    let token0_addr = object::object_address(&token0);
    let token1_addr = object::object_address(&token1);
    comparator::is_smaller_than(&comparator::compare(&token0_addr, &token1_addr))
  }

  // returns sorted token Metadata objects, used to handle return values from 
  // pairs sorted in this order
  public fun sort_tokens(
    token_a: Object<Metadata>,
    token_b: Object<Metadata>,
  ): (Object<Metadata>, Object<Metadata>) {
    let token_a_addr = object::object_address(&token_a);
    let token_b_addr = object::object_address(&token_b);
    assert!(token_a_addr != token_b_addr, ERROR_IDENTICAL_ADDRESSES);
    let (token0, token1);
    if (is_sorted(token_a, token_b)) {
      (token0, token1) = (token_a, token_b)
    } else {
      (token0, token1) = (token_b, token_a)
    };

    (token0, token1)
  }

  public fun sort_tokens_two(
    tokenA: Object<Metadata>,
    tokenB: Object<Metadata>,
  ): vector<Object<Metadata>> {
    let tokenVector = vector::empty<Object<Metadata>>();
    vector::push_back(&mut tokenVector, tokenA);
    vector::push_back(&mut tokenVector, tokenB);

    let tokenA_addr = object::object_address(&tokenA);
    let tokenB_addr = object::object_address(&tokenB);
    assert!(tokenA_addr != tokenB_addr, ERROR_IDENTICAL_ADDRESSES);

    if (!is_sorted(tokenA, tokenB)) {
      vector::reverse(&mut tokenVector);
    } ;
    tokenVector
  }

  public fun sort_tokens_three(
    token0: Object<Metadata>,
    token1: Object<Metadata>,
    token2: Object<Metadata>,
  ): vector<Object<Metadata>> {
      let sorted = vector::empty<Object<Metadata>>();
      let addr0 = object::object_address(&token0);
      let addr1 = object::object_address(&token1);
      let addr2 = object::object_address(&token2);

      if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr1))) {
          if (comparator::is_smaller_than(&comparator::compare(&addr1, &addr2))) {
              vector::push_back(&mut sorted, token0);
              vector::push_back(&mut sorted, token1);
              vector::push_back(&mut sorted, token2);
          } else if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr2))) {
              vector::push_back(&mut sorted, token0);
              vector::push_back(&mut sorted, token2);
              vector::push_back(&mut sorted, token1);
          } else {
              vector::push_back(&mut sorted, token2);
              vector::push_back(&mut sorted, token0);
              vector::push_back(&mut sorted, token1);
          }
      } else {
          if (comparator::is_smaller_than(&comparator::compare(&addr1, &addr2))) {
              if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr2))) {
                  vector::push_back(&mut sorted, token1);
                  vector::push_back(&mut sorted, token0);
                  vector::push_back(&mut sorted, token2);
              } else {
                  vector::push_back(&mut sorted, token1);
                  vector::push_back(&mut sorted, token2);
                  vector::push_back(&mut sorted, token0);
              }
          } else {
              vector::push_back(&mut sorted, token2);
              vector::push_back(&mut sorted, token1);
              vector::push_back(&mut sorted, token0);
          }
      };

      sorted
  }

  public fun sort_tokens_position(
      token0: Object<Metadata>,
      token1: Object<Metadata>,
      token2: Object<Metadata>
  ): vector<u64> {
      let sorted = vector::empty<u64>();
      let addr0 = object::object_address(&token0);
      let addr1 = object::object_address(&token1);
      let addr2 = object::object_address(&token2);

      if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr1))) {
          if (comparator::is_smaller_than(&comparator::compare(&addr1, &addr2))) {
              vector::push_back(&mut sorted, 0);
              vector::push_back(&mut sorted, 1);
              vector::push_back(&mut sorted, 2);
          } else if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr2))) {
              vector::push_back(&mut sorted, 0);
              vector::push_back(&mut sorted, 2);
              vector::push_back(&mut sorted, 1);
          } else {
              vector::push_back(&mut sorted, 2);
              vector::push_back(&mut sorted, 0);
              vector::push_back(&mut sorted, 1);
          }
      } else {
          if (comparator::is_smaller_than(&comparator::compare(&addr1, &addr2))) {
              if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr2))) {
                  vector::push_back(&mut sorted, 1);
                  vector::push_back(&mut sorted, 0);
                  vector::push_back(&mut sorted, 2);
              } else {
                  vector::push_back(&mut sorted, 1);
                  vector::push_back(&mut sorted, 2);
                  vector::push_back(&mut sorted, 0);
              }
          } else {
              vector::push_back(&mut sorted, 2);
              vector::push_back(&mut sorted, 1);
              vector::push_back(&mut sorted, 0);
          }
      };

      sorted
  }

  
}