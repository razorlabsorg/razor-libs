
<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath"></a>

# Module `0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::bitmath`

@title BitMath
@dev This library provides functionality for computing bit properties of an unsigned integer


-  [Constants](#@Constants_0)
-  [Function `most_significant_bit`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_most_significant_bit)
-  [Function `least_significant_bit`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_least_significant_bit)


<pre><code></code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U8"></a>



<pre><code><b>const</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U8">MAX_U8</a>: u256 = 255;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U16"></a>



<pre><code><b>const</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U16">MAX_U16</a>: u256 = 65535;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U32"></a>



<pre><code><b>const</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U32">MAX_U32</a>: u256 = 4294967295;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U64"></a>



<pre><code><b>const</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U64">MAX_U64</a>: u256 = 18446744073709551615;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U128"></a>



<pre><code><b>const</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_MAX_U128">MAX_U128</a>: u256 = 340282366920938463463374607431768211455;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_ERROR_INVALID_VALUE"></a>



<pre><code><b>const</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_ERROR_INVALID_VALUE">ERROR_INVALID_VALUE</a>: u64 = 0;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_most_significant_bit"></a>

## Function `most_significant_bit`

@notice Returns the index of the most significant bit of the number,
where the least significant bit is at index 0 and the most significant bit is at index 255
@dev The function satisfies the property:
x >= 2**mostSignificantBit(x) and x < 2**(mostSignificantBit(x)+1)
@param x the value for which to compute the most significant bit, must be greater than 0
@return r the index of the most significant bit


<pre><code><b>public</b> <b>fun</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_most_significant_bit">most_significant_bit</a>(x: u256): u8
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_least_significant_bit"></a>

## Function `least_significant_bit`

@notice Returns the index of the least significant bit of the number,
where the least significant bit is at index 0 and the most significant bit is at index 255
@dev The function satisfies the property:
(x & 2**leastSignificantBit(x)) != 0 and (x & (2**(leastSignificantBit(x)) - 1)) == 0)
@param x the value for which to compute the least significant bit, must be greater than 0
@return r the index of the least significant bit


<pre><code><b>public</b> <b>fun</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath_least_significant_bit">least_significant_bit</a>(x: u256): u8
</code></pre>
