
<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math"></a>

# Module `0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::sqrt_price_math`

@title SqrtPriceMath
@notice A library for performing arithmetic operations on sqrt prices


-  [Constants](#@Constants_0)
-  [Function `get_next_sqrt_price_from_amount0_rounding_up`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_amount0_rounding_up)
-  [Function `get_next_sqrt_price_from_amount1_rounding_down`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_amount1_rounding_down)
-  [Function `get_next_sqrt_price_from_input`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_input)
-  [Function `get_next_sqrt_price_from_output`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_output)
-  [Function `get_amount0_delta`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount0_delta)
-  [Function `get_amount1_delta`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount1_delta)
-  [Function `get_amount0_delta_signed`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount0_delta_signed)
-  [Function `get_amount1_delta_signed`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount1_delta_signed)


<pre><code><b>use</b> <a href="fixedpoint96.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_fixedpoint96">0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::fixedpoint96</a>;
<b>use</b> <a href="fullmath.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_fullmath">0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::fullmath</a>;
<b>use</b> <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256">0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::i256</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_EQUAL"></a>



<pre><code><b>const</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_EQUAL">EQUAL</a>: u8 = 0;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_GREATER_THAN"></a>



<pre><code><b>const</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_GREATER_THAN">GREATER_THAN</a>: u8 = 2;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_LESS_THAN"></a>



<pre><code><b>const</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_LESS_THAN">LESS_THAN</a>: u8 = 1;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_ERR_INVALID_QUOTIENT"></a>



<pre><code><b>const</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_ERR_INVALID_QUOTIENT">ERR_INVALID_QUOTIENT</a>: u64 = 1001;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_ERR_INVALID_VALUE"></a>



<pre><code><b>const</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_ERR_INVALID_VALUE">ERR_INVALID_VALUE</a>: u64 = 1002;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_ERR_MUL_DIV_OVERFLOW"></a>



<pre><code><b>const</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_ERR_MUL_DIV_OVERFLOW">ERR_MUL_DIV_OVERFLOW</a>: u64 = 1000;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_amount0_rounding_up"></a>

## Function `get_next_sqrt_price_from_amount0_rounding_up`



<pre><code><b>public</b> <b>fun</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_amount0_rounding_up">get_next_sqrt_price_from_amount0_rounding_up</a>(sqrt_price_x96: u256, liquidity: u256, amount: u256, add: bool): u256
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_amount1_rounding_down"></a>

## Function `get_next_sqrt_price_from_amount1_rounding_down`



<pre><code><b>public</b> <b>fun</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_amount1_rounding_down">get_next_sqrt_price_from_amount1_rounding_down</a>(sqrt_price_x96: u256, liquidity: u256, amount: u256, add: bool): u256
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_input"></a>

## Function `get_next_sqrt_price_from_input`



<pre><code><b>public</b> <b>fun</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_input">get_next_sqrt_price_from_input</a>(sqrt_price_x96: u256, liquidity: u256, amount_in: u256, zero_for_one: bool): u256
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_output"></a>

## Function `get_next_sqrt_price_from_output`



<pre><code><b>public</b> <b>fun</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_next_sqrt_price_from_output">get_next_sqrt_price_from_output</a>(sqrt_price_x96: u256, liquidity: u256, amount_out: u256, zero_for_one: bool): u256
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount0_delta"></a>

## Function `get_amount0_delta`



<pre><code><b>public</b> <b>fun</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount0_delta">get_amount0_delta</a>(sqrt_ratio_ax96: u256, sqrt_ratio_bx96: u256, liquidity: u256, round_up: bool): u256
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount1_delta"></a>

## Function `get_amount1_delta`



<pre><code><b>public</b> <b>fun</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount1_delta">get_amount1_delta</a>(sqrt_ratio_ax96: u256, sqrt_ratio_bx96: u256, liquidity: u256, round_up: bool): u256
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount0_delta_signed"></a>

## Function `get_amount0_delta_signed`



<pre><code><b>public</b> <b>fun</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount0_delta_signed">get_amount0_delta_signed</a>(sqrt_ratio_ax96: u256, sqrt_ratio_bx96: u256, liquidity: <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>): <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount1_delta_signed"></a>

## Function `get_amount1_delta_signed`



<pre><code><b>public</b> <b>fun</b> <a href="sqrt_price_math.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_sqrt_price_math_get_amount1_delta_signed">get_amount1_delta_signed</a>(sqrt_ratio_ax96: u256, sqrt_ratio_bx96: u256, liquidity: <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>): <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>
</code></pre>
