
<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings"></a>

# Module `0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::hexstrings`

@title HexStrings
@notice A library for encoding and decoding hex strings


-  [Constants](#@Constants_0)
-  [Function `to_hex_string`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_to_hex_string)
-  [Function `to_hex_string_no_prefix`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_to_hex_string_no_prefix)


<pre><code><b>use</b> <a href="">0x1::string</a>;
<b>use</b> <a href="">0x1::vector</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_ALPHABET"></a>



<pre><code><b>const</b> <a href="hexstrings.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_ALPHABET">ALPHABET</a>: <a href="">vector</a>&lt;u8&gt; = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102];
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_ERR_INSUFFICIENT_LENGTH"></a>



<pre><code><b>const</b> <a href="hexstrings.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_ERR_INSUFFICIENT_LENGTH">ERR_INSUFFICIENT_LENGTH</a>: u64 = 1000;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_to_hex_string"></a>

## Function `to_hex_string`



<pre><code><b>public</b> <b>fun</b> <a href="hexstrings.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_to_hex_string">to_hex_string</a>(value: u256, length: u256): <a href="_String">string::String</a>
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_to_hex_string_no_prefix"></a>

## Function `to_hex_string_no_prefix`



<pre><code><b>public</b> <b>fun</b> <a href="hexstrings.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_hexstrings_to_hex_string_no_prefix">to_hex_string_no_prefix</a>(value: u256, length: u256): <a href="_String">string::String</a>
</code></pre>
