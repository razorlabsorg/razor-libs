
<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_token_utils"></a>

# Module `0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d::token_utils`

@title TokenUtils
@notice A library for creating and managing token stores


-  [Function `create_token_store`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_token_utils_create_token_store)
-  [Function `ensure_account_token_store`](#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_token_utils_ensure_account_token_store)


<pre><code><b>use</b> <a href="">0x1::fungible_asset</a>;
<b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="">0x1::primary_fungible_store</a>;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_token_utils_create_token_store"></a>

## Function `create_token_store`



<pre><code><b>public</b> <b>fun</b> <a href="token_utils.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_token_utils_create_token_store">create_token_store</a>(pool_signer: &<a href="">signer</a>, token: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): <a href="_Object">object::Object</a>&lt;<a href="_FungibleStore">fungible_asset::FungibleStore</a>&gt;
</code></pre>



<a id="0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_token_utils_ensure_account_token_store"></a>

## Function `ensure_account_token_store`



<pre><code><b>public</b> <b>fun</b> <a href="token_utils.md#0x16f014d37f7d8455c49d587bfc93a26eba6e3f02f1eb391e6afa620b8ffdd91d_token_utils_ensure_account_token_store">ensure_account_token_store</a>&lt;T: key&gt;(<a href="">account</a>: <b>address</b>, pair: <a href="_Object">object::Object</a>&lt;T&gt;): <a href="_Object">object::Object</a>&lt;<a href="_FungibleStore">fungible_asset::FungibleStore</a>&gt;
</code></pre>
