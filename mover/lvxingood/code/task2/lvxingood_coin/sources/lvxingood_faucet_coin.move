/// Module: lvxingood_coin
module lvxingood_coin::lvxingood_faucet_coin {

    use sui::coin::{Self,Coin,TreasuryCap};
    use sui::url::{Self,Url};
    use sui::transfer;
    use sui::tx_context::{TxContext};
    use std::option;

    public struct LVXINGOOD_FAUCET_COIN has drop {}

    #[allow(lint(share_owned))]
    fun init(witness: LVXINGOOD_FAUCET_COIN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<LVXINGOOD_FAUCET_COIN>(
            witness,
            9,
            b"LVXINGOOD_FAUCET",
            b"LVXINGOOD_FAUCET",
            b"LVXINGOOD faucet coin, welcome.",
            option::some<Url>(url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/19473242")),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_share_object(treasury_cap)
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<LVXINGOOD_FAUCET_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }

    public fun burn(
        treasury_cap: &mut TreasuryCap<LVXINGOOD_FAUCET_COIN>,
        coin: Coin<LVXINGOOD_FAUCET_COIN>
    ) {
        coin::burn(treasury_cap, coin);
    }
}

