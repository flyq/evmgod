// https://www.evmthroughctfs.com/escape

use anyhow::{Ok, Result};
use ethers::{
    abi::{parse_abi, Uint},
    contract::abigen,
    core::types::Address,
    prelude::BaseContract,
    providers::{Http, Provider},
};
use std::sync::Arc;

// Generate the type-safe contract bindings by providing the ABI
// definition in human readable format
abigen!(
    CtfAbi1,
    r#"[
        function mysteryFunc(uint256 a, uint256 b) external pure returns (uint256)
    ]"#,
);

abigen!(
    CtfAbi2,
    r#"[
        function mysteryFunc(uint256[] memory a, uint256[] memory b) external pure returns (uint256)
    ]"#,
);

abigen!(
    CtfAbi3,
    r#"[
        function solved(address a) external view returns (bool)
    ]"#,
);

#[tokio::main]
async fn main() -> Result<()> {
    // create ethers client and wrap it in Arc<M>
    let client = Provider::<Http>::try_from(
        "https://mainnet.infura.io/v3/c60b0bb42f8a4c6481ecd229eddaca27",
    )?;
    let client = Arc::new(client);

    // evmthroughctfs 01 contract
    let unverified_contract1 = "0x36cE5aa25B99CF6Eb019AAfd149B97B32cDD4a5b".parse::<Address>()?;
    let unverified_contract2 = "0x47D2A4c4e3b3cd645484a3AE217cC8c7EAbE60Ae".parse::<Address>()?;
    let unverified_contract3 = "0x53A071E3D09B009A284FA17be3194FBE3bfC5a74".parse::<Address>()?;

    let ctf_contract1 = CtfAbi1::new(unverified_contract1, Arc::clone(&client));
    let ctf_contract2 = CtfAbi2::new(unverified_contract2, Arc::clone(&client));
    let ctf_contract3 = CtfAbi3::new(unverified_contract3, Arc::clone(&client));

    // mysteryFunc -> mystery_func
    let result1 = ctf_contract1
        .mystery_func(3.into(), 4.into())
        .call()
        .await?;

    // mysteryFunc -> mystery_func
    let result2 = ctf_contract2
        .mystery_func(vec![1.into(), 2.into()], vec![3.into(), 4.into()])
        .call()
        .await?;

    let result3 = ctf_contract3
        .solved("0xbd70d89667A3E1bD341AC235259c5f2dDE8172A9".parse::<Address>()?)
        .call()
        .await?;

    println!("result1: {:#?}", result1);

    println!("result2: {:#?}", result2);

    println!("result3: {:#?}", result3);

    let abi =
        parse_abi(&["function mysteryFunc(uint256 a, uint256 b) external pure returns (uint256)"])?;
    let base_contract = BaseContract::from(abi);

    println!(
        "abi: {:?}",
        base_contract.encode::<(Uint, Uint)>("mysteryFunc", (1.into(), 5.into()))?
    );

    let abi = parse_abi(&["function solved() external view returns (bool)"])?;
    let base_contract = BaseContract::from(abi);

    println!("abi: {:?}", base_contract.encode("solved", ())?);

    Ok(())
}
