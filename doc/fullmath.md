
<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath"></a>

# Module `0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::fullmath`

@title FullMath
@notice A library for performing multiplication and division operations with arbitrary precision


-  [Constants](#@Constants_0)
-  [Function `mul_div_v2`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div_v2)
-  [Function `mul_div`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div)
-  [Function `full_mul`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_full_mul)
-  [Function `mul_mod`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_mod)
-  [Function `mul_div_rounding_up`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div_rounding_up)
-  [Function `div_rounding_up`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_div_rounding_up)


<pre><code><b>use</b> <a href="i256.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_i256">0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::i256</a>;
<b>use</b> <a href="">0x1::math128</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_MAX_U256"></a>



<pre><code><b>const</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_MAX_U256">MAX_U256</a>: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_ERR_INVALID_DENOMINATOR"></a>



<pre><code><b>const</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_ERR_INVALID_DENOMINATOR">ERR_INVALID_DENOMINATOR</a>: u64 = 100;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_ERR_OVERFLOW"></a>



<pre><code><b>const</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_ERR_OVERFLOW">ERR_OVERFLOW</a>: u64 = 101;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div_v2"></a>

## Function `mul_div_v2`



<pre><code><b>public</b> <b>fun</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div_v2">mul_div_v2</a>(a: u256, b: u256, denominator: u256): u256
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div"></a>

## Function `mul_div`



<pre><code><b>public</b> <b>fun</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div">mul_div</a>(a: u256, b: u256, denominator: u256): u256
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_full_mul"></a>

## Function `full_mul`



<pre><code><b>public</b> <b>fun</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_full_mul">full_mul</a>(num1: u256, num2: u256): u256
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_mod"></a>

## Function `mul_mod`



<pre><code><b>public</b> <b>fun</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_mod">mul_mod</a>(a: u256, b: u256, denom: u256): u256
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div_rounding_up"></a>

## Function `mul_div_rounding_up`



<pre><code><b>public</b> <b>fun</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_mul_div_rounding_up">mul_div_rounding_up</a>(a: u256, b: u256, denominator: u256): u256
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_div_rounding_up"></a>

## Function `div_rounding_up`



<pre><code><b>public</b> <b>fun</b> <a href="fullmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_fullmath_div_rounding_up">div_rounding_up</a>(x: u256, y: u256): u256
</code></pre>
