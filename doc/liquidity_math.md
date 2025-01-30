
<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_liquidity_math"></a>

# Module `0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129::liquidity_math`

@title LiquidityMath
@notice A library for performing arithmetic operations on liquidity amounts


-  [Constants](#@Constants_0)
-  [Function `add_delta`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_liquidity_math_add_delta)


<pre><code><b>use</b> <a href="i256.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_i256">0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129::i256</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_liquidity_math_ERR_LA"></a>



<pre><code><b>const</b> <a href="liquidity_math.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_liquidity_math_ERR_LA">ERR_LA</a>: u64 = 101;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_liquidity_math_ERR_LS"></a>



<pre><code><b>const</b> <a href="liquidity_math.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_liquidity_math_ERR_LS">ERR_LS</a>: u64 = 100;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_liquidity_math_add_delta"></a>

## Function `add_delta`



<pre><code><b>public</b> <b>fun</b> <a href="liquidity_math.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_liquidity_math_add_delta">add_delta</a>(a: u256, b: <a href="i256.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_i256_I256">i256::I256</a>): u256
</code></pre>
