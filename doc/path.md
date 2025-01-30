
<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path"></a>

# Module `0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129::path`

@title Path
@notice A library for decoding and encoding paths


-  [Constants](#@Constants_0)
-  [Function `has_multiple_pools`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_has_multiple_pools)
-  [Function `num_pools`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_num_pools)
-  [Function `to_address`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_to_address)
-  [Function `to_uint64`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_to_uint64)
-  [Function `decode_first_pool`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_decode_first_pool)
-  [Function `encode_single_pool`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_encode_single_pool)
-  [Function `get_first_pool`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_get_first_pool)
-  [Function `skip_token`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_skip_token)


<pre><code><b>use</b> <a href="">0x1::bcs</a>;
<b>use</b> <a href="">0x1::from_bcs</a>;
<b>use</b> <a href="">0x1::vector</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_MAX_U64"></a>



<pre><code><b>const</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_MAX_U64">MAX_U64</a>: u64 = 18446744073709551615;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_ERR_OVERFLOW"></a>



<pre><code><b>const</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_ERR_OVERFLOW">ERR_OVERFLOW</a>: u64 = 0;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_ADDR_SIZE"></a>



<pre><code><b>const</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_ADDR_SIZE">ADDR_SIZE</a>: u64 = 32;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_ERR_OUT_OF_BOUNDS"></a>



<pre><code><b>const</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_ERR_OUT_OF_BOUNDS">ERR_OUT_OF_BOUNDS</a>: u64 = 1;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_FEE_SIZE"></a>



<pre><code><b>const</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_FEE_SIZE">FEE_SIZE</a>: u64 = 3;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_MULTIPLE_POOLS_MIN_LENGTH"></a>



<pre><code><b>const</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_MULTIPLE_POOLS_MIN_LENGTH">MULTIPLE_POOLS_MIN_LENGTH</a>: u64 = 102;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_NEXT_OFFSET"></a>



<pre><code><b>const</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_NEXT_OFFSET">NEXT_OFFSET</a>: u64 = 35;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_POP_OFFSET"></a>



<pre><code><b>const</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_POP_OFFSET">POP_OFFSET</a>: u64 = 67;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_has_multiple_pools"></a>

## Function `has_multiple_pools`



<pre><code><b>public</b> <b>fun</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_has_multiple_pools">has_multiple_pools</a>(<a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path">path</a>: <a href="">vector</a>&lt;u8&gt;): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_num_pools"></a>

## Function `num_pools`



<pre><code><b>public</b> <b>fun</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_num_pools">num_pools</a>(<a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path">path</a>: <a href="">vector</a>&lt;u8&gt;): u64
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_to_address"></a>

## Function `to_address`



<pre><code><b>public</b> <b>fun</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_to_address">to_address</a>(bytes: <a href="">vector</a>&lt;u8&gt;, start: u64): <b>address</b>
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_to_uint64"></a>

## Function `to_uint64`



<pre><code><b>public</b> <b>fun</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_to_uint64">to_uint64</a>(bytes: <a href="">vector</a>&lt;u8&gt;, start: u64): u64
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_decode_first_pool"></a>

## Function `decode_first_pool`



<pre><code><b>public</b> <b>fun</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_decode_first_pool">decode_first_pool</a>(<a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path">path</a>: <a href="">vector</a>&lt;u8&gt;): (<b>address</b>, <b>address</b>, u64)
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_encode_single_pool"></a>

## Function `encode_single_pool`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_encode_single_pool">encode_single_pool</a>(token_in: <b>address</b>, fee: u64, token_out: <b>address</b>): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_get_first_pool"></a>

## Function `get_first_pool`



<pre><code><b>public</b> <b>fun</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_get_first_pool">get_first_pool</a>(<a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path">path</a>: <a href="">vector</a>&lt;u8&gt;): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_skip_token"></a>

## Function `skip_token`



<pre><code><b>public</b> <b>fun</b> <a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path_skip_token">skip_token</a>(<a href="path.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_path">path</a>: <a href="">vector</a>&lt;u8&gt;): <a href="">vector</a>&lt;u8&gt;
</code></pre>
