
<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath"></a>

# Module `0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::treemath`



-  [Struct `Tree`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree)
-  [Constants](#@Constants_0)
-  [Function `new`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_new)
-  [Function `contains`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_contains)
-  [Function `add`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_add)
-  [Function `remove`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_remove)
-  [Function `find_first_right`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_find_first_right)
-  [Function `find_first_left`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_find_first_left)


<pre><code><b>use</b> <a href="bit.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bit">0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::bit</a>;
<b>use</b> <a href="bitmath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_bitmath">0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::bitmath</a>;
<b>use</b> <a href="">0x1::bcs</a>;
<b>use</b> <a href="">0x1::from_bcs</a>;
<b>use</b> <a href="">0x1::option</a>;
<b>use</b> <a href="">0x1::simple_map</a>;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree"></a>

## Struct `Tree`



<pre><code><b>struct</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree">Tree</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_MAX_U256"></a>



<pre><code><b>const</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_MAX_U256">MAX_U256</a>: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_new"></a>

## Function `new`



<pre><code><b>public</b> <b>fun</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_new">new</a>(): <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree">treemath::Tree</a>
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_contains"></a>

## Function `contains`



<pre><code><b>public</b> <b>fun</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_contains">contains</a>(tree: <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree">treemath::Tree</a>, id: u32): bool
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_add"></a>

## Function `add`



<pre><code><b>public</b> <b>fun</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_add">add</a>(tree: &<b>mut</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree">treemath::Tree</a>, id: u32): (bool, <a href="">vector</a>&lt;u8&gt;)
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_remove"></a>

## Function `remove`



<pre><code><b>public</b> <b>fun</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_remove">remove</a>(tree: &<b>mut</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree">treemath::Tree</a>, id: u32): (bool, <a href="">vector</a>&lt;u8&gt;)
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_find_first_right"></a>

## Function `find_first_right`



<pre><code><b>public</b> <b>fun</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_find_first_right">find_first_right</a>(tree: &<a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree">treemath::Tree</a>, id: u32): u32
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_find_first_left"></a>

## Function `find_first_left`



<pre><code><b>public</b> <b>fun</b> <a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_find_first_left">find_first_left</a>(tree: &<a href="treemath.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_treemath_Tree">treemath::Tree</a>, id: u32): u32
</code></pre>
