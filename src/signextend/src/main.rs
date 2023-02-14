use revm::interpreter::instructions::arithmetic::signextend2;
use revm::interpreter::{Contract, Interpreter};
use revm::primitives::U256;

fn main() {
    let mut interp = Interpreter::new(Contract::default(), u64::MAX, false);
    // 0x0000...0080 (1000_0000)
    let op1 = U256::from(128);
    // 0 means result signextend last 8bit(1000_0000)
    let op2 = U256::from(0);
    println!("128's limbs: {:?}", op1.as_limbs());
    println!("0's limbs: {:?}", op2.as_limbs());

    interp.stack.push(op1).unwrap();
    interp.stack.push(op2).unwrap();

    signextend2(&mut interp);
    println!(
        "signextend result: {:?}\ninterpreter: {:?}",
        interp.stack().peek(0),
        interp
    );
}
