
<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers"></a>

# Module `0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129::numbers`



-  [Constants](#@Constants_0)
-  [Function `is_even`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_even)
-  [Function `is_odd`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_odd)
-  [Function `is_prime`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_prime)
-  [Function `is_perfect_square`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_perfect_square)
-  [Function `is_fibonacci`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_fibonacci)
-  [Function `is_palindromic`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_palindromic)
-  [Function `is_triangular`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_triangular)
-  [Function `is_happy`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_happy)
-  [Function `sum_of_squares_of_digits`](#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_sum_of_squares_of_digits)


<pre><code><b>use</b> <a href="">0x1::vector</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_E_INVALID_INPUT"></a>



<pre><code><b>const</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_E_INVALID_INPUT">E_INVALID_INPUT</a>: u64 = 1;
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_even"></a>

## Function `is_even`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_even">is_even</a>(num: u64): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_odd"></a>

## Function `is_odd`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_odd">is_odd</a>(num: u64): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_prime"></a>

## Function `is_prime`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_prime">is_prime</a>(num: u64): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_perfect_square"></a>

## Function `is_perfect_square`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_perfect_square">is_perfect_square</a>(num: u64): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_fibonacci"></a>

## Function `is_fibonacci`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_fibonacci">is_fibonacci</a>(num: u64): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_palindromic"></a>

## Function `is_palindromic`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_palindromic">is_palindromic</a>(num: u64): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_triangular"></a>

## Function `is_triangular`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_triangular">is_triangular</a>(num: u64): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_happy"></a>

## Function `is_happy`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_is_happy">is_happy</a>(num: u64): bool
</code></pre>



<a id="0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_sum_of_squares_of_digits"></a>

## Function `sum_of_squares_of_digits`



<pre><code><b>public</b> <b>fun</b> <a href="numbers.md#0x7aa8f5f1438203d93ea77d6ab39a2247034eacf8b543215db12775278bba6129_numbers_sum_of_squares_of_digits">sum_of_squares_of_digits</a>(num: u64): u64
</code></pre>
