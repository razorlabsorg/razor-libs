
<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128"></a>

# Module `0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129::fixedpoint128`

@title FixedPoint128
@notice A library for handling binary fixed point numbers, see https://en.wikipedia.org/wiki/Q_(number_format)


-  [Struct `UQ128x128`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128)
-  [Constants](#@Constants_0)
-  [Function `Q128`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_Q128)
-  [Function `encode`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_encode)
-  [Function `decode`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_decode)
-  [Function `to_u256`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_to_u256)
-  [Function `mul`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_mul)
-  [Function `div`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_div)
-  [Function `fraction`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_fraction)
-  [Function `compare`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_compare)
-  [Function `is_zero`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_is_zero)


<pre><code></code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128"></a>

## Struct `UQ128x128`

The resource to store <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code>.


<pre><code><b>struct</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_EQUAL"></a>

When a and b are equals.


<pre><code><b>const</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_EQUAL">EQUAL</a>: u8 = 0;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_ERR_DIVIDE_BY_ZERO"></a>

When divide by zero attempted.


<pre><code><b>const</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_ERR_DIVIDE_BY_ZERO">ERR_DIVIDE_BY_ZERO</a>: u64 = 100;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_GREATER_THAN"></a>

When a is greater than b.


<pre><code><b>const</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_GREATER_THAN">GREATER_THAN</a>: u8 = 2;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_LESS_THAN"></a>

When a is less than b equals.


<pre><code><b>const</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_LESS_THAN">LESS_THAN</a>: u8 = 1;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_MASK"></a>



<pre><code><b>const</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_MASK">MASK</a>: u256 = 340282366920938463463374607431768211456;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_Q128"></a>

## Function `Q128`



<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_Q128">Q128</a>(): u256
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_encode"></a>

## Function `encode`

Encode <code>u128</code> to <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code>


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_encode">encode</a>(x: u128): <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_decode"></a>

## Function `decode`

Decode a <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code> into a <code>u128</code> by truncating after the radix point.


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_decode">decode</a>(uq: <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>): u128
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_to_u256"></a>

## Function `to_u256`

Get <code>u128</code> from UQ128x128


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_to_u256">to_u256</a>(uq: <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>): u256
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_mul"></a>

## Function `mul`

Multiply a <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code> by a <code>u128</code>, returning a <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code>


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_mul">mul</a>(uq: <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>, y: u128): <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_div"></a>

## Function `div`

Divide a <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code> by a <code>u128</code>, returning a <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code>.


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_div">div</a>(uq: <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>, y: u128): <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_fraction"></a>

## Function `fraction`

Returns a <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code> which represents the ratio of the numerator to the denominator.


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_fraction">fraction</a>(numerator: u128, denominator: u128): <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_compare"></a>

## Function `compare`

Compare two <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code> numbers.


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_compare">compare</a>(left: &<a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>, right: &<a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>): u8
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_is_zero"></a>

## Function `is_zero`

Check if <code><a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">UQ128x128</a></code> is zero


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_is_zero">is_zero</a>(uq: &<a href="fixedpoint128.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_fixedpoint128_UQ128x128">fixedpoint128::UQ128x128</a>): bool
</code></pre>
