
<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded"></a>

# Module `0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129::encoded`



-  [Function `MASK_UINT64`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT64)
-  [Function `MASK_UINT24`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT24)
-  [Function `MASK_UINT16`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT16)
-  [Function `MASK_UINT1`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT1)
-  [Function `set`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_set)
-  [Function `set_bool`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_set_bool)
-  [Function `decode`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode)
-  [Function `decode_bool`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_bool)
-  [Function `decode_u16`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u16)
-  [Function `decode_u24`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u24)
-  [Function `decode_u64`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u64)


<pre><code><b>use</b> <a href="">0x1::bcs</a>;
<b>use</b> <a href="">0x1::from_bcs</a>;
<b>use</b> <a href="bit.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_bit">0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129::bit</a>;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT64"></a>

## Function `MASK_UINT64`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT64">MASK_UINT64</a>(): u256
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT24"></a>

## Function `MASK_UINT24`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT24">MASK_UINT24</a>(): u256
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT16"></a>

## Function `MASK_UINT16`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT16">MASK_UINT16</a>(): u256
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT1"></a>

## Function `MASK_UINT1`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_MASK_UINT1">MASK_UINT1</a>(): u256
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_set"></a>

## Function `set`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_set">set</a>(<a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded">encoded</a>: <a href="">vector</a>&lt;u8&gt;, value: u256, mask: u256, offset: u8): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_set_bool"></a>

## Function `set_bool`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_set_bool">set_bool</a>(<a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded">encoded</a>: <a href="">vector</a>&lt;u8&gt;, boolean: bool, offset: u8): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode"></a>

## Function `decode`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode">decode</a>(<a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded">encoded</a>: <a href="">vector</a>&lt;u8&gt;, mask: u256, offset: u8): u256
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_bool"></a>

## Function `decode_bool`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_bool">decode_bool</a>(<a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded">encoded</a>: <a href="">vector</a>&lt;u8&gt;, offset: u8): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u16"></a>

## Function `decode_u16`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u16">decode_u16</a>(<a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded">encoded</a>: <a href="">vector</a>&lt;u8&gt;, offset: u8): u16
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u24"></a>

## Function `decode_u24`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u24">decode_u24</a>(<a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded">encoded</a>: <a href="">vector</a>&lt;u8&gt;, offset: u8): u32
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u64"></a>

## Function `decode_u64`



<pre><code><b>public</b> <b>fun</b> <a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded_decode_u64">decode_u64</a>(<a href="encoded.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_encoded">encoded</a>: <a href="">vector</a>&lt;u8&gt;, offset: u8): u64
</code></pre>
