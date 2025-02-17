#[test_only]
module razor_libs::sort_test {
    use razor_libs::sort;
    use razor_libs::usdc_token;
    use razor_libs::usdt_token;
    use razor_libs::wbtc_token;
    use razor_libs::weth_token;

    use std::vector;
    use aptos_framework::account;
    use aptos_framework::object;

    public entry fun init_coins() {
      let account = &account::create_account_for_test(@razor_libs);
      usdc_token::init_for_test(account);
      usdt_token::init_for_test(account);
      wbtc_token::init_for_test(account);
      weth_token::init_for_test(account);
    }

    #[test]
    fun test_is_sorted_two() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        assert!(!sort::is_sorted_two(token0, token1), 0);
        assert!(sort::is_sorted_two(token1, token0), 1);
        assert!(!sort::is_sorted_two(token2, token1), 2);
    }

    #[test]
    fun test_is_sorted_three() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        assert!(!sort::is_sorted_three(token0, token1, token2), 0);
        assert!(!sort::is_sorted_three(token0, token2, token1), 1);
        assert!(sort::is_sorted_three(token1, token2, token0), 2);
    }

    #[test]
    fun test_sort_two_tokens() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();

        let (sorted0, sorted1) = sort::sort_two_tokens(token1, token0);
        assert!(object::object_address(&sorted0) == @0x843086ef7eb08921e26e32fe12e266a18636bb2c47f4afa49b90ee8ee9079a6b, 0);
        assert!(object::object_address(&sorted1) == @0xfc6f8c2d02c58d2d1913f965aa164fd7e3a31925921187730a6dc3d9a4f97399, 1);
    }

    #[test]
    #[expected_failure(abort_code = 1, location = razor_libs::sort)]
    fun test_sort_two_tokens_identical_addresses() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdc_token::metadata();
        sort::sort_two_tokens(token0, token1);
    }

    #[test]
    fun test_sort_three_tokens() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        // Test different orderings
        let (sorted0, sorted1, sorted2) = sort::sort_three_tokens(token0, token1, token2);
        assert!(object::object_address(&sorted0) == @0x843086ef7eb08921e26e32fe12e266a18636bb2c47f4afa49b90ee8ee9079a6b, 0);
        assert!(object::object_address(&sorted1) == @0xf0a547d8d9d8a778ed9acfa242a98c07b23f16679129c7decf702a16d5e32545, 1);
        assert!(object::object_address(&sorted2) == @0xfc6f8c2d02c58d2d1913f965aa164fd7e3a31925921187730a6dc3d9a4f97399, 2);
    }

    #[test]
    #[expected_failure(abort_code = 1, location = razor_libs::sort)]
    fun test_sort_three_tokens_identical_addresses() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdc_token::metadata();
        let token2 = usdt_token::metadata();
        sort::sort_three_tokens(token0, token1, token2);
    }

    #[test]
    fun test_sort_two_tokens_vector() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();

        let sorted = sort::sort_two_tokens_vector(token1, token0);
        assert!(*vector::borrow(&sorted, 0) == token1, 0);
        assert!(*vector::borrow(&sorted, 1) == token0, 1);
    }

    #[test]
    fun test_sort_three_tokens_vector() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        // Test all possible permutations
        let sorted = sort::sort_three_tokens_vector(token0, token1, token2);
        assert!(*vector::borrow(&sorted, 0) == token1, 0);
        assert!(*vector::borrow(&sorted, 1) == token2, 1);
        assert!(*vector::borrow(&sorted, 2) == token0, 2);
    }

    #[test]
    fun test_sort_tokens_position() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        // Test different orderings
        let positions = sort::sort_tokens_position(token0, token1, token2);
        assert!(*vector::borrow(&positions, 0) == 1, 0);
        assert!(*vector::borrow(&positions, 1) == 2, 1);
        assert!(*vector::borrow(&positions, 2) == 0, 2);
    }

    #[test]
    fun test_sort_three_tokens_all_permutations() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        // Test all possible permutations
        let (sorted0, sorted1, sorted2) = sort::sort_three_tokens(token0, token2, token1);
        assert!(object::object_address(&sorted0) == @0x843086ef7eb08921e26e32fe12e266a18636bb2c47f4afa49b90ee8ee9079a6b, 0);
        assert!(object::object_address(&sorted1) == @0xf0a547d8d9d8a778ed9acfa242a98c07b23f16679129c7decf702a16d5e32545, 1);
        assert!(object::object_address(&sorted2) == @0xfc6f8c2d02c58d2d1913f965aa164fd7e3a31925921187730a6dc3d9a4f97399, 2);

        let (sorted0, sorted1, sorted2) = sort::sort_three_tokens(token1, token0, token2);
        assert!(object::object_address(&sorted0) == @0x843086ef7eb08921e26e32fe12e266a18636bb2c47f4afa49b90ee8ee9079a6b, 3);
        assert!(object::object_address(&sorted1) == @0xf0a547d8d9d8a778ed9acfa242a98c07b23f16679129c7decf702a16d5e32545, 4);
        assert!(object::object_address(&sorted2) == @0xfc6f8c2d02c58d2d1913f965aa164fd7e3a31925921187730a6dc3d9a4f97399, 5);

        let (sorted0, sorted1, sorted2) = sort::sort_three_tokens(token2, token0, token1);
        assert!(object::object_address(&sorted0) == @0x843086ef7eb08921e26e32fe12e266a18636bb2c47f4afa49b90ee8ee9079a6b, 6);
        assert!(object::object_address(&sorted1) == @0xf0a547d8d9d8a778ed9acfa242a98c07b23f16679129c7decf702a16d5e32545, 7);
        assert!(object::object_address(&sorted2) == @0xfc6f8c2d02c58d2d1913f965aa164fd7e3a31925921187730a6dc3d9a4f97399, 8);
    }

    #[test]
    fun test_sort_three_tokens_vector_all_permutations() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        // Test different permutations
        let sorted = sort::sort_three_tokens_vector(token1, token0, token2);
        assert!(*vector::borrow(&sorted, 0) == token1, 0);
        assert!(*vector::borrow(&sorted, 1) == token2, 1);
        assert!(*vector::borrow(&sorted, 2) == token0, 2);

        let sorted = sort::sort_three_tokens_vector(token2, token1, token0);
        assert!(*vector::borrow(&sorted, 0) == token1, 3);
        assert!(*vector::borrow(&sorted, 1) == token2, 4);
        assert!(*vector::borrow(&sorted, 2) == token0, 5);
    }

    #[test]
    fun test_sort_tokens_position_all_permutations() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        // Test different permutations
        let positions = sort::sort_tokens_position(token1, token0, token2);
        assert!(*vector::borrow(&positions, 0) == 0, 0);
        assert!(*vector::borrow(&positions, 1) == 2, 1);
        assert!(*vector::borrow(&positions, 2) == 1, 2);

        let positions = sort::sort_tokens_position(token2, token1, token0);
        assert!(*vector::borrow(&positions, 0) == 1, 3);
        assert!(*vector::borrow(&positions, 1) == 0, 4);
        assert!(*vector::borrow(&positions, 2) == 2, 5);
    }
}