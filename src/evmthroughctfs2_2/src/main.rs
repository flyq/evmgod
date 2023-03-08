use anyhow::{Ok, Result};
use ethers::{
    contract::abigen,
    core::types::Address,
    providers::{Http, Provider},
};
use std::sync::Arc;

// Generate the type-safe contract bindings by providing the ABI
// definition in human readable format
abigen!(
    CtfAbi,
    r#"[
        function owner() external view returns (address)
    ]"#,
);

#[tokio::main]
async fn main() -> Result<()> {
    // create ethers client and wrap it in Arc<M>
    let client =
        Provider::<Http>::try_from("https://goerli.infura.io/v3/7026d4b46dcc475087fb9fa5e3fd708c")?;
    let client = Arc::new(client);

    let unverified_contract1 = "0x58eb248ae9a3cd58731f7e2e0cfc20ac66444520".parse::<Address>()?;

    let ctf_contract1 = CtfAbi::new(unverified_contract1, Arc::clone(&client));

    // mysteryFunc -> mystery_func
    let result1 = ctf_contract1.owner().call().await?;

    println!("result1: {:#?}", result1);

    Ok(())
}
