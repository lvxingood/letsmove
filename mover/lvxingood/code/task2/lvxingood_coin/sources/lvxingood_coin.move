/// Module: lvxingood_coin
module lvxingood_coin::lvxingood_coin {

    use sui::coin::{Self,Coin,TreasuryCap};
    use sui::url::{Self,Url};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option;

    public struct LVXINGOOD_COIN has drop {}

    fun init(witness: LVXINGOOD_COIN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<LVXINGOOD_COIN>(
            witness,
            9,
            b"LVXINGOOD_COIN",
            b"LVXINGOOD",
            b"lvxingood coin, my first sui coin",
            option::some<Url>(url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/19473242")),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<LVXINGOOD_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }

    public fun burn(
        treasury_cap: &mut TreasuryCap<LVXINGOOD_COIN>,
        coin: Coin<LVXINGOOD_COIN>
    ) {
        coin::burn(treasury_cap, coin);
    }
}

