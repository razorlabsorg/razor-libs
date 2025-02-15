
<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts"></a>

# Module `0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::liquidity_amounts`

@title LiquidityAmounts
@notice A library for calculating liquidity amounts


-  [Function `get_liquidity_for_amount0`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amount0)
-  [Function `get_liquidity_for_amount1`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amount1)
-  [Function `get_liquidity_for_amounts`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amounts)
-  [Function `get_amount0_for_liquidity`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amount0_for_liquidity)
-  [Function `get_amount1_for_liquidity`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amount1_for_liquidity)
-  [Function `get_amounts_for_liquidity`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amounts_for_liquidity)


<pre><code><b>use</b> <a href="fixedpoint96.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint96">0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::fixedpoint96</a>;
<b>use</b> <a href="fullmath.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fullmath">0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::fullmath</a>;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amount0"></a>

## Function `get_liquidity_for_amount0`



<pre><code><b>public</b> <b>fun</b> <a href="liquidity_amounts.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amount0">get_liquidity_for_amount0</a>(sqrt_ratio_a: u256, sqrt_ratio_b: u256, amount0: u256): u256
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amount1"></a>

## Function `get_liquidity_for_amount1`



<pre><code><b>public</b> <b>fun</b> <a href="liquidity_amounts.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amount1">get_liquidity_for_amount1</a>(sqrt_ratio_a: u256, sqrt_ratio_b: u256, amount1: u256): u256
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amounts"></a>

## Function `get_liquidity_for_amounts`



<pre><code><b>public</b> <b>fun</b> <a href="liquidity_amounts.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_liquidity_for_amounts">get_liquidity_for_amounts</a>(sqrt_ratio: u256, sqrt_ratio_a: u256, sqrt_ratio_b: u256, amount0: u256, amount1: u256): u256
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amount0_for_liquidity"></a>

## Function `get_amount0_for_liquidity`



<pre><code><b>public</b> <b>fun</b> <a href="liquidity_amounts.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amount0_for_liquidity">get_amount0_for_liquidity</a>(sqrt_ratio_a: u256, sqrt_ratio_b: u256, liquidity: u256): u256
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amount1_for_liquidity"></a>

## Function `get_amount1_for_liquidity`



<pre><code><b>public</b> <b>fun</b> <a href="liquidity_amounts.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amount1_for_liquidity">get_amount1_for_liquidity</a>(sqrt_ratio_a: u256, sqrt_ratio_b: u256, liquidity: u256): u256
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amounts_for_liquidity"></a>

## Function `get_amounts_for_liquidity`



<pre><code><b>public</b> <b>fun</b> <a href="liquidity_amounts.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_liquidity_amounts_get_amounts_for_liquidity">get_amounts_for_liquidity</a>(sqrt_ratio: u256, sqrt_ratio_a: u256, sqrt_ratio_b: u256, liquidity: u256): (u256, u256)
</code></pre>
