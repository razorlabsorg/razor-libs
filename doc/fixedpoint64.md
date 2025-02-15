
<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64"></a>

# Module `0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::fixedpoint64`

@title FixedPoint64
@author 0xSnarks
@notice A library for performing arithmetic operations on fixed point numbers


-  [Struct `UQ64x64`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64)
-  [Constants](#@Constants_0)
-  [Function `encode`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_encode)
-  [Function `decode`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_decode)
-  [Function `to_u128`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_to_u128)
-  [Function `mul`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_mul)
-  [Function `div`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_div)
-  [Function `fraction`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_fraction)
-  [Function `compare`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_compare)
-  [Function `is_zero`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_is_zero)
-  [Function `lt`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_lt)
-  [Function `lte`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_lte)
-  [Function `gt`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_gt)
-  [Function `gte`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_gte)


<pre><code></code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64"></a>

## Struct `UQ64x64`

The resource to store <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code>.


<pre><code><b>struct</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_EQUAL"></a>

When a and b are equals.


<pre><code><b>const</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_EQUAL">EQUAL</a>: u8 = 0;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_GREATER_THAN"></a>

When a is greater than b.


<pre><code><b>const</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_GREATER_THAN">GREATER_THAN</a>: u8 = 2;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_LESS_THAN"></a>

When a is less than b equals.


<pre><code><b>const</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_LESS_THAN">LESS_THAN</a>: u8 = 1;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_ERROR_DIVIDE_BY_ZERO"></a>

When divide by zero attempted.


<pre><code><b>const</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_ERROR_DIVIDE_BY_ZERO">ERROR_DIVIDE_BY_ZERO</a>: u64 = 1;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_Q64"></a>



<pre><code><b>const</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_Q64">Q64</a>: u128 = 18446744073709551615;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_encode"></a>

## Function `encode`

Encode <code>u64</code> to <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code>


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_encode">encode</a>(x: u64): <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_decode"></a>

## Function `decode`

Decode a <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code> into a <code>u64</code> by truncating after the radix point.


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_decode">decode</a>(uq: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>): u64
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_to_u128"></a>

## Function `to_u128`

Get <code>u128</code> from UQ64x64


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_to_u128">to_u128</a>(uq: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>): u128
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_mul"></a>

## Function `mul`

Multiply a <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code> by a <code>u64</code>, returning a <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code>


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_mul">mul</a>(uq: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>, y: u64): <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_div"></a>

## Function `div`

Divide a <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code> by a <code>u128</code>, returning a <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code>.


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_div">div</a>(uq: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>, y: u64): <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_fraction"></a>

## Function `fraction`

Returns a <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code> which represents the ratio of the numerator to the denominator.


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_fraction">fraction</a>(numerator: u64, denominator: u64): <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_compare"></a>

## Function `compare`

Compare two <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code> numbers.


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_compare">compare</a>(left: &<a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>, right: &<a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>): u8
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_is_zero"></a>

## Function `is_zero`

Check if <code><a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">UQ64x64</a></code> is zero


<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_is_zero">is_zero</a>(uq: &<a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>): bool
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_lt"></a>

## Function `lt`



<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_lt">lt</a>(left: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>, right: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>): bool
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_lte"></a>

## Function `lte`



<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_lte">lte</a>(left: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>, right: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>): bool
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_gt"></a>

## Function `gt`



<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_gt">gt</a>(left: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>, right: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>): bool
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_gte"></a>

## Function `gte`



<pre><code><b>public</b> <b>fun</b> <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_gte">gte</a>(left: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>, right: <a href="fixedpoint64.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_fixedpoint64_UQ64x64">fixedpoint64::UQ64x64</a>): bool
</code></pre>
