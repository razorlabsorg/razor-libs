
<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_validation"></a>

# Module `0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6::validation`

@title Validation
@notice A library for validating transactions


-  [Constants](#@Constants_0)
-  [Function `check_deadline`](#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_validation_check_deadline)


<pre><code><b>use</b> <a href="">0x1::timestamp</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_validation_ERR_TRANSACTION_EXPIRED"></a>



<pre><code><b>const</b> <a href="validation.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_validation_ERR_TRANSACTION_EXPIRED">ERR_TRANSACTION_EXPIRED</a>: u64 = 1;
</code></pre>



<a id="0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_validation_check_deadline"></a>

## Function `check_deadline`



<pre><code><b>public</b> <b>fun</b> <a href="validation.md#0xccc5c4272c290d2315a6b34a06715f0b3d563cffae88f6a779140e774e3c35d6_validation_check_deadline">check_deadline</a>(deadline: u64)
</code></pre>
