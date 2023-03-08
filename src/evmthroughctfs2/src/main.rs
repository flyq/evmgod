// https://www.evmthroughctfs.com/bytecode

use std::ops::{Shl, Shr};

use anyhow::{Ok, Result};
use ethers::{
    abi::{parse_abi, Uint},
    prelude::BaseContract,
};

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
    let base_contract = BaseContract::from(abi.clone());

    println!(
        "name: {:?}\nowner: {:?}\nfire: {:?}\nabi: {:?}",
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
        ),
        abi
    );

    let val = Uint::from_str_radix("35b430b134b1", 16)?;
    println!("{:?}", val.shl(209));

    println!("{:?}", hex::encode("khabib"));
    Ok(())
}
