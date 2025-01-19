/// @title TokenUtils
/// @notice A library for creating and managing token stores
module razor_libs::token_utils {
  use aptos_framework::object::{Self, Object};
  use aptos_framework::fungible_asset::{Self, FungibleStore, Metadata};
  use aptos_framework::primary_fungible_store;
  
  public fun create_token_store(pool_signer: &signer, token: Object<Metadata>): Object<FungibleStore> {
    let constructor_ref = &object::create_object_from_object(pool_signer);
    fungible_asset::create_store(constructor_ref, token)
  }

  public fun ensure_account_token_store<T: key>(
    account: address, 
    pair: Object<T>
  ): Object<FungibleStore> {
    primary_fungible_store::ensure_primary_store_exists(account, pair);
    let store = primary_fungible_store::primary_store(account, pair);
    store
  }
}