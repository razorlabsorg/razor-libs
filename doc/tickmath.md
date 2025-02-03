
<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath"></a>

# Module `0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d::tickmath`

@title TickMath
@notice A library for performing arithmetic operations on tick values


-  [Constants](#@Constants_0)
-  [Function `MIN_TICK`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MIN_TICK)
-  [Function `MAX_TICK`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_TICK)
-  [Function `min_sqrt_ratio`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_min_sqrt_ratio)
-  [Function `max_sqrt_ratio`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_max_sqrt_ratio)
-  [Function `get_sqrt_ratio_at_tick`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_get_sqrt_ratio_at_tick)
-  [Function `get_tick_at_sqrt_ratio`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_get_tick_at_sqrt_ratio)


<pre><code><b>use</b> <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256">0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d::i256</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_U256"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_U256">MAX_U256</a>: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_EQUAL"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_EQUAL">EQUAL</a>: u8 = 0;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_GREATER_THAN"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_GREATER_THAN">GREATER_THAN</a>: u8 = 2;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_LESS_THAN"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_LESS_THAN">LESS_THAN</a>: u8 = 1;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_ERROR_INVALID_SQRT_PRICE_Q96"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_ERROR_INVALID_SQRT_PRICE_Q96">ERROR_INVALID_SQRT_PRICE_Q96</a>: u64 = 0;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_ERROR_INVALID_TICK"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_ERROR_INVALID_TICK">ERROR_INVALID_TICK</a>: u64 = 1;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_ERROR_TICK_OUT_OF_BOUNDS"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_ERROR_TICK_OUT_OF_BOUNDS">ERROR_TICK_OUT_OF_BOUNDS</a>: u64 = 2;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAXIMUM_TICK"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAXIMUM_TICK">MAXIMUM_TICK</a>: u256 = 887272;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_I24"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_I24">MAX_I24</a>: u256 = 8388607;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_SQRT_RATIO"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_SQRT_RATIO">MAX_SQRT_RATIO</a>: u256 = 1461446703485210103287273052203988822378723970342;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MIN_I24"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MIN_I24">MIN_I24</a>: u256 = 8388608;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MIN_SQRT_RATIO"></a>



<pre><code><b>const</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MIN_SQRT_RATIO">MIN_SQRT_RATIO</a>: u256 = 4295128739;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MIN_TICK"></a>

## Function `MIN_TICK`



<pre><code><b>public</b> <b>fun</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MIN_TICK">MIN_TICK</a>(): <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256_I256">i256::I256</a>
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_TICK"></a>

## Function `MAX_TICK`



<pre><code><b>public</b> <b>fun</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_MAX_TICK">MAX_TICK</a>(): <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256_I256">i256::I256</a>
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_min_sqrt_ratio"></a>

## Function `min_sqrt_ratio`



<pre><code><b>public</b> <b>fun</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_min_sqrt_ratio">min_sqrt_ratio</a>(): u256
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_max_sqrt_ratio"></a>

## Function `max_sqrt_ratio`



<pre><code><b>public</b> <b>fun</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_max_sqrt_ratio">max_sqrt_ratio</a>(): u256
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_get_sqrt_ratio_at_tick"></a>

## Function `get_sqrt_ratio_at_tick`



<pre><code><b>public</b> <b>fun</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_get_sqrt_ratio_at_tick">get_sqrt_ratio_at_tick</a>(tick: <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256_I256">i256::I256</a>): u256
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_get_tick_at_sqrt_ratio"></a>

## Function `get_tick_at_sqrt_ratio`



<pre><code><b>public</b> <b>fun</b> <a href="tickmath.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_tickmath_get_tick_at_sqrt_ratio">get_tick_at_sqrt_ratio</a>(sqrt_price_q96: u256): <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256_I256">i256::I256</a>
</code></pre>
