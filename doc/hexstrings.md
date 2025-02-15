
<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings"></a>

# Module `0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::hexstrings`

@title HexStrings
@notice A library for encoding and decoding hex strings


-  [Constants](#@Constants_0)
-  [Function `to_hex_string`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_to_hex_string)
-  [Function `to_hex_string_no_prefix`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_to_hex_string_no_prefix)


<pre><code><b>use</b> <a href="">0x1::string</a>;
<b>use</b> <a href="">0x1::vector</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_ALPHABET"></a>



<pre><code><b>const</b> <a href="hexstrings.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_ALPHABET">ALPHABET</a>: <a href="">vector</a>&lt;u8&gt; = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102];
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_ERR_INSUFFICIENT_LENGTH"></a>



<pre><code><b>const</b> <a href="hexstrings.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_ERR_INSUFFICIENT_LENGTH">ERR_INSUFFICIENT_LENGTH</a>: u64 = 1000;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_to_hex_string"></a>

## Function `to_hex_string`



<pre><code><b>public</b> <b>fun</b> <a href="hexstrings.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_to_hex_string">to_hex_string</a>(value: u256, length: u256): <a href="_String">string::String</a>
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_to_hex_string_no_prefix"></a>

## Function `to_hex_string_no_prefix`



<pre><code><b>public</b> <b>fun</b> <a href="hexstrings.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_hexstrings_to_hex_string_no_prefix">to_hex_string_no_prefix</a>(value: u256, length: u256): <a href="_String">string::String</a>
</code></pre>
