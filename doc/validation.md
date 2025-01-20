
<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_validation"></a>

# Module `0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a::validation`

@title Validation
@notice A library for validating transactions


-  [Constants](#@Constants_0)
-  [Function `check_deadline`](#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_validation_check_deadline)


<pre><code><b>use</b> <a href="">0x1::timestamp</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_validation_ERR_TRANSACTION_EXPIRED"></a>



<pre><code><b>const</b> <a href="validation.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_validation_ERR_TRANSACTION_EXPIRED">ERR_TRANSACTION_EXPIRED</a>: u64 = 1;
</code></pre>



<a id="0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_validation_check_deadline"></a>

## Function `check_deadline`



<pre><code><b>public</b> <b>fun</b> <a href="validation.md#0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a_validation_check_deadline">check_deadline</a>(deadline: u64)
</code></pre>
