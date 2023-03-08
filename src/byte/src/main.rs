use std::str::FromStr;

use revm::interpreter::instructions::bitwise::byte2;
use revm::interpreter::{Contract, Interpreter};
use revm::primitives::ruint::Uint;
use revm::primitives::U256;

macro_rules! as_u64_saturated {
    ( $v:expr ) => {{
        if $v.as_limbs()[1] != 0 || $v.as_limbs()[2] != 0 || $v.as_limbs()[3] != 0 {
            u64::MAX
        } else {
            $v.as_limbs()[0]
        }
    }};
}

macro_rules! as_usize_saturated {
    ( $v:expr ) => {{
        as_u64_saturated!($v) as usize
    }};
}

fn main() {
    let mut interp = Interpreter::new(Contract::default(), u64::MAX, false);
    // 0x0000...f080 (1000_0000)
    let op1 = U256::from(61440);
    let op2 = U256::from(30);

    println!("128's limbs: {:?}", op1.as_limbs());
    println!("0's limbs: {:?}", op2.as_limbs());

    interp.stack.push(op1).unwrap();
    interp.stack.push(op2).unwrap();

    byte2(&mut interp);
    println!(
        "signextend result: {:?}\ninterpreter: {:?}",
        interp.stack().peek(0),
        interp
    );

    let op1: U256 = Uint::from_str_radix("d1", 16).unwrap(); //
    let mut op2: U256 = Uint::from_str_radix("35b430b134b1", 16).unwrap();
    println!("op1: {:?}, op2: {:?}", op1, op2);
    op2 <<= as_usize_saturated!(op1);
    println!("op1: {:?}, op2: {:?}", op1, op2);
    let liquan = hex::encode("liquan");
    let khabib = hex::encode("khabib");
    println!("{:?}, {:?}", liquan, khabib);

    let mut op: U256 = Uint::from_str_radix(
        "6c697175616e0000000000000000000000000000000000000000000000000000",
        16,
    )
    .unwrap();
    op >>= as_usize_saturated!(op1);
    println!("{:?}", op);
}
