
<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap"></a>

# Module `0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::tick_bitmap`



-  [Struct `State`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_State)
-  [Constants](#@Constants_0)
-  [Function `position`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_position)
-  [Function `get_state_bits`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_get_state_bits)
-  [Function `flip_tick`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_flip_tick)
-  [Function `next_initialized_tick_within_one_word`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_next_initialized_tick_within_one_word)


<pre><code><b>use</b> <a href="">0x1::simple_map</a>;
<b>use</b> <a href="bitmath.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_bitmath">0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::bitmath</a>;
<b>use</b> <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256">0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::i256</a>;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_State"></a>

## Struct `State`



<pre><code><b>struct</b> <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_State">State</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_MAX_U256"></a>



<pre><code><b>const</b> <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_MAX_U256">MAX_U256</a>: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_ERROR_FLIPPING"></a>



<pre><code><b>const</b> <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_ERROR_FLIPPING">ERROR_FLIPPING</a>: u64 = 0;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_position"></a>

## Function `position`



<pre><code><b>public</b> <b>fun</b> <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_position">position</a>(tick: <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>): (<a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>, u8)
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_get_state_bits"></a>

## Function `get_state_bits`



<pre><code><b>public</b> <b>fun</b> <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_get_state_bits">get_state_bits</a>(state: &<a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_State">tick_bitmap::State</a>): u256
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_flip_tick"></a>

## Function `flip_tick`



<pre><code><b>public</b> <b>fun</b> <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_flip_tick">flip_tick</a>(bit_map: <a href="_SimpleMap">simple_map::SimpleMap</a>&lt;<a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>, <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_State">tick_bitmap::State</a>&gt;, tick: <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>, tick_spacing: <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>)
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_next_initialized_tick_within_one_word"></a>

## Function `next_initialized_tick_within_one_word`



<pre><code><b>public</b> <b>fun</b> <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_next_initialized_tick_within_one_word">next_initialized_tick_within_one_word</a>(bit_map: <a href="_SimpleMap">simple_map::SimpleMap</a>&lt;<a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>, <a href="tick_bitmap.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_tick_bitmap_State">tick_bitmap::State</a>&gt;, tick: <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>, tick_spacing: <a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>, lte: bool): (<a href="i256.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_i256_I256">i256::I256</a>, bool)
</code></pre>
