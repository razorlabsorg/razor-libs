
<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64"></a>

# Module `0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d::base64`

@title Base64
@notice A library for encoding and decoding base64 strings


-  [Constants](#@Constants_0)
-  [Function `encode`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_encode)
-  [Function `decode`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_decode)
-  [Function `encode_64`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_encode_64)
-  [Function `decode_64`](#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_decode_64)


<pre><code></code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_BASE16_CHARS"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_BASE16_CHARS">BASE16_CHARS</a>: <a href="">vector</a>&lt;u8&gt; = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 97, 98, 99, 100, 101, 102];
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_BASE64_CHARS"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_BASE64_CHARS">BASE64_CHARS</a>: <a href="">vector</a>&lt;u8&gt; = [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 43, 47];
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_DECODE_LUT"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_DECODE_LUT">DECODE_LUT</a>: <a href="">vector</a>&lt;u8&gt; = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 0, 0, 0, 0, 10, 11, 12, 13, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 11, 12, 13, 14, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_DECODE_LUT_64"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_DECODE_LUT_64">DECODE_LUT_64</a>: <a href="">vector</a>&lt;u8&gt; = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62, 0, 0, 0, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 0, 0, 0, 0, 0, 0, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 0, 0, 0, 0, 0];
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_ECODE_LUT"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_ECODE_LUT">ECODE_LUT</a>: <a href="">vector</a>&lt;u8&gt; = [255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 255, 255, 255, 255, 255, 255, 255, 10, 11, 12, 13, 14, 15, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 10, 11, 12, 13, 14, 15, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255];
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_ECODE_LUT_64"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_ECODE_LUT_64">ECODE_LUT_64</a>: <a href="">vector</a>&lt;u8&gt; = [255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 62, 255, 255, 255, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 255, 255, 255, 255, 255, 255, 255, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 255, 255, 255, 255, 255, 255, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255];
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_ERR_INVALID_CHARACTER"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_ERR_INVALID_CHARACTER">ERR_INVALID_CHARACTER</a>: u64 = 1;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_ERR_INVALID_LENGTH"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_ERR_INVALID_LENGTH">ERR_INVALID_LENGTH</a>: u64 = 0;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_PADDING"></a>



<pre><code><b>const</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_PADDING">PADDING</a>: u8 = 61;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_encode"></a>

## Function `encode`



<pre><code><b>public</b> <b>fun</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_encode">encode</a>(bytes: <a href="">vector</a>&lt;u8&gt;): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_decode"></a>

## Function `decode`



<pre><code><b>public</b> <b>fun</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_decode">decode</a>(bytes: <a href="">vector</a>&lt;u8&gt;): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_encode_64"></a>

## Function `encode_64`



<pre><code><b>public</b> <b>fun</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_encode_64">encode_64</a>(bytes: <a href="">vector</a>&lt;u8&gt;): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_decode_64"></a>

## Function `decode_64`



<pre><code><b>public</b> <b>fun</b> <a href="base64.md#0x13253effc048095b933b0d2ffe307913b074fb3b9f56780cc2495e18f0e6e14d_base64_decode_64">decode_64</a>(bytes: <a href="">vector</a>&lt;u8&gt;): <a href="">vector</a>&lt;u8&gt;
</code></pre>
