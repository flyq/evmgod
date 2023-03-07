// https://www.evmthroughctfs.com/bytecode

use anyhow::{Ok, Result};
use ethers::{
    abi::{parse_abi, Uint},
    contract::abigen,
    core::types::Address,
    prelude::BaseContract,
    providers::{Http, Provider},
};
use std::sync::Arc;

#[tokio::main]
async fn main() -> Result<()> {
    let abi = parse_abi(&[
        "function name() external view returns (string memory)",
        "function owner() external view returns (address)",
        "function fire(
        uint256 myBoard,
        uint256 myAttacks,
        uint256 opponentsAttacks,
        uint256 myLastMove,
        uint256 opponentsLastMove,
        uint256 opponentsDiscoveredFleet
    ) external returns (uint256)",
    ])?;
    let base_contract = BaseContract::from(abi);

    println!(
        "name: {:?}\nowner: {:?}\nfire: {:?}",
        base_contract.encode("name", ()),
        base_contract.encode("owner", ()),
        base_contract.encode(
            "fire",
            (
                Uint::zero(),
                Uint::zero(),
                Uint::zero(),
                Uint::zero(),
                Uint::zero(),
                Uint::zero()
            )
        )
    );

    Ok(())
}
