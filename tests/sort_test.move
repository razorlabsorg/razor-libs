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
        assert!(!sort::is_sorted_two(token1, token2), 2);
    }

    #[test]
    fun test_is_sorted_three() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        assert!(!sort::is_sorted_three(token0, token1, token2), 0);
        assert!(!sort::is_sorted_three(token0, token2, token1), 1);
        assert!(sort::is_sorted_three(token2, token1, token0), 2);
    }

    #[test]
    fun test_sort_two_tokens() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();

        let (sorted0, sorted1) = sort::sort_two_tokens(token1, token0);
        assert!(object::object_address(&sorted0) == @0xbefe0e9a2eae1ddac6f2235a4a4ab8a3be78e2e16620e8d48b3adcbe3fa492e4, 0);
        assert!(object::object_address(&sorted1) == @0xe91afa6e11f244e1c317add4ca5b757546f444fcff8d35193d0a05eac3f4e59d, 1);
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
        assert!(object::object_address(&sorted0) == @0x16cc8f1a0b9e4a170079fbef8f55cbca42993f44c4dd851fd2a17285e780c2c, 0);
        assert!(object::object_address(&sorted1) == @0xbefe0e9a2eae1ddac6f2235a4a4ab8a3be78e2e16620e8d48b3adcbe3fa492e4, 1);
        assert!(object::object_address(&sorted2) == @0xe91afa6e11f244e1c317add4ca5b757546f444fcff8d35193d0a05eac3f4e59d, 2);
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
        assert!(*vector::borrow(&sorted, 0) == token2, 0);
        assert!(*vector::borrow(&sorted, 1) == token1, 1);
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
        assert!(*vector::borrow(&positions, 0) == 2, 0);
        assert!(*vector::borrow(&positions, 1) == 1, 1);
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
        assert!(object::object_address(&sorted0) == @0x16cc8f1a0b9e4a170079fbef8f55cbca42993f44c4dd851fd2a17285e780c2c, 0);
        assert!(object::object_address(&sorted1) == @0xbefe0e9a2eae1ddac6f2235a4a4ab8a3be78e2e16620e8d48b3adcbe3fa492e4, 1);
        assert!(object::object_address(&sorted2) == @0xe91afa6e11f244e1c317add4ca5b757546f444fcff8d35193d0a05eac3f4e59d, 2);

        let (sorted0, sorted1, sorted2) = sort::sort_three_tokens(token1, token0, token2);
        assert!(object::object_address(&sorted0) == @0x16cc8f1a0b9e4a170079fbef8f55cbca42993f44c4dd851fd2a17285e780c2c, 3);
        assert!(object::object_address(&sorted1) == @0xbefe0e9a2eae1ddac6f2235a4a4ab8a3be78e2e16620e8d48b3adcbe3fa492e4, 4);
        assert!(object::object_address(&sorted2) == @0xe91afa6e11f244e1c317add4ca5b757546f444fcff8d35193d0a05eac3f4e59d, 5);

        let (sorted0, sorted1, sorted2) = sort::sort_three_tokens(token2, token0, token1);
        assert!(object::object_address(&sorted0) == @0x16cc8f1a0b9e4a170079fbef8f55cbca42993f44c4dd851fd2a17285e780c2c, 6);
        assert!(object::object_address(&sorted1) == @0xbefe0e9a2eae1ddac6f2235a4a4ab8a3be78e2e16620e8d48b3adcbe3fa492e4, 7);
        assert!(object::object_address(&sorted2) == @0xe91afa6e11f244e1c317add4ca5b757546f444fcff8d35193d0a05eac3f4e59d, 8);
    }

    #[test]
    fun test_sort_three_tokens_vector_all_permutations() {
        init_coins();
        let token0 = usdc_token::metadata();
        let token1 = usdt_token::metadata();
        let token2 = wbtc_token::metadata();

        // Test different permutations
        let sorted = sort::sort_three_tokens_vector(token1, token0, token2);
        assert!(*vector::borrow(&sorted, 0) == token2, 0);
        assert!(*vector::borrow(&sorted, 1) == token1, 1);
        assert!(*vector::borrow(&sorted, 2) == token0, 2);

        let sorted = sort::sort_three_tokens_vector(token2, token1, token0);
        assert!(*vector::borrow(&sorted, 0) == token2, 3);
        assert!(*vector::borrow(&sorted, 1) == token1, 4);
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
        assert!(*vector::borrow(&positions, 0) == 2, 0);
        assert!(*vector::borrow(&positions, 1) == 0, 1);
        assert!(*vector::borrow(&positions, 2) == 1, 2);

        let positions = sort::sort_tokens_position(token2, token1, token0);
        assert!(*vector::borrow(&positions, 0) == 0, 3);
        assert!(*vector::borrow(&positions, 1) == 1, 4);
        assert!(*vector::borrow(&positions, 2) == 2, 5);
    }
}