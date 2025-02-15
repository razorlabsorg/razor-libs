
<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath"></a>

# Module `0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::swapmath`

@title SwapMath
@notice A library for performing swap calculations


-  [Constants](#@Constants_0)
-  [Function `compute_swap_step`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_compute_swap_step)


<pre><code><b>use</b> <a href="fullmath.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fullmath">0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::fullmath</a>;
<b>use</b> <a href="i256.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_i256">0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::i256</a>;
<b>use</b> <a href="sqrt_price_math.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_sqrt_price_math">0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::sqrt_price_math</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_EQUAL"></a>



<pre><code><b>const</b> <a href="swapmath.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_EQUAL">EQUAL</a>: u8 = 0;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_GREATER_THAN"></a>



<pre><code><b>const</b> <a href="swapmath.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_GREATER_THAN">GREATER_THAN</a>: u8 = 2;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_LESS_THAN"></a>



<pre><code><b>const</b> <a href="swapmath.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_LESS_THAN">LESS_THAN</a>: u8 = 1;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_compute_swap_step"></a>

## Function `compute_swap_step`



<pre><code><b>public</b> <b>fun</b> <a href="swapmath.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_swapmath_compute_swap_step">compute_swap_step</a>(sqrt_ratio_current_x96: u256, sqrt_ratio_target_x96: u256, liquidity: u256, amount_remaining: <a href="i256.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_i256_I256">i256::I256</a>, fee_pips: u64): (u256, u256, u256, u256)
</code></pre>
