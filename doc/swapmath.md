
<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath"></a>

# Module `0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::swapmath`

@title SwapMath
@notice A library for performing swap calculations


-  [Constants](#@Constants_0)
-  [Function `compute_swap_step`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_compute_swap_step)


<pre><code><b>use</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath">0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::fullmath</a>;
<b>use</b> <a href="i256.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_i256">0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::i256</a>;
<b>use</b> <a href="sqrt_price_math.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_sqrt_price_math">0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::sqrt_price_math</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_EQUAL"></a>



<pre><code><b>const</b> <a href="swapmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_EQUAL">EQUAL</a>: u8 = 0;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_GREATER_THAN"></a>



<pre><code><b>const</b> <a href="swapmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_GREATER_THAN">GREATER_THAN</a>: u8 = 2;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_LESS_THAN"></a>



<pre><code><b>const</b> <a href="swapmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_LESS_THAN">LESS_THAN</a>: u8 = 1;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_compute_swap_step"></a>

## Function `compute_swap_step`



<pre><code><b>public</b> <b>fun</b> <a href="swapmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_swapmath_compute_swap_step">compute_swap_step</a>(sqrt_ratio_current_x96: u256, sqrt_ratio_target_x96: u256, liquidity: u256, amount_remaining: <a href="i256.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_i256_I256">i256::I256</a>, fee_pips: u64): (u256, u256, u256, u256)
</code></pre>
