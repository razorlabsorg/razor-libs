
<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils"></a>

# Module `0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d::utils`

@title Utils
@notice A library for performing various utility operations


-  [Constants](#@Constants_0)
-  [Function `quote`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_quote)
-  [Function `get_amount_out`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_get_amount_out)
-  [Function `get_amount_in`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_get_amount_in)
-  [Function `sum_vector`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_sum_vector)
-  [Function `encode_3`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_encode_3)
-  [Function `position_key`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_position_key)


<pre><code><b>use</b> <a href="hex.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_hex">0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d::hex</a>;
<b>use</b> <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256">0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d::i256</a>;
<b>use</b> <a href="">0x1::aptos_hash</a>;
<b>use</b> <a href="">0x1::bcs</a>;
<b>use</b> <a href="">0x1::vector</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_MAX_U64"></a>



<pre><code><b>const</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_MAX_U64">MAX_U64</a>: u64 = 18446744073709551615;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_INSUFFICIENT_AMOUNT"></a>

Insufficient Amount


<pre><code><b>const</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_INSUFFICIENT_AMOUNT">ERROR_INSUFFICIENT_AMOUNT</a>: u64 = 3;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_INSUFFICIENT_INPUT_AMOUNT"></a>

Insufficient Input Amount


<pre><code><b>const</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_INSUFFICIENT_INPUT_AMOUNT">ERROR_INSUFFICIENT_INPUT_AMOUNT</a>: u64 = 5;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_INSUFFICIENT_LIQUIDITY"></a>

Insufficient Liquidity


<pre><code><b>const</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_INSUFFICIENT_LIQUIDITY">ERROR_INSUFFICIENT_LIQUIDITY</a>: u64 = 2;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_INSUFFICIENT_OUTPUT_AMOUNT"></a>

Insufficient Output Amount


<pre><code><b>const</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_INSUFFICIENT_OUTPUT_AMOUNT">ERROR_INSUFFICIENT_OUTPUT_AMOUNT</a>: u64 = 6;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_OVERFLOW"></a>

Overflow


<pre><code><b>const</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_ERROR_OVERFLOW">ERROR_OVERFLOW</a>: u64 = 4;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_quote"></a>

## Function `quote`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_quote">quote</a>(amount_a: u64, reserve_a: u64, reserve_b: u64): u64
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_get_amount_out"></a>

## Function `get_amount_out`



<pre><code><b>public</b> <b>fun</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_get_amount_out">get_amount_out</a>(amount_in: u64, reserve_in: u64, reserve_out: u64): u64
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_get_amount_in"></a>

## Function `get_amount_in`



<pre><code><b>public</b> <b>fun</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_get_amount_in">get_amount_in</a>(amount_out: u64, reserve_in: u64, reserve_out: u64): u64
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_sum_vector"></a>

## Function `sum_vector`



<pre><code><b>public</b> <b>fun</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_sum_vector">sum_vector</a>(v: &<a href="">vector</a>&lt;u256&gt;): u256
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_encode_3"></a>

## Function `encode_3`



<pre><code><b>public</b> <b>fun</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_encode_3">encode_3</a>(a: <b>address</b>, b: <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256_I256">i256::I256</a>, c: <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256_I256">i256::I256</a>): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_position_key"></a>

## Function `position_key`



<pre><code><b>public</b> <b>fun</b> <a href="utils.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_utils_position_key">position_key</a>(owner: <b>address</b>, tick_lower: <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256_I256">i256::I256</a>, tick_upper: <a href="i256.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_i256_I256">i256::I256</a>): <a href="">vector</a>&lt;u8&gt;
</code></pre>
