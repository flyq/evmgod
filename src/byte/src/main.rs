use revm::interpreter::instructions::bitwise::byte2;
use revm::interpreter::{Contract, Interpreter};
use revm::primitives::U256;

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
}
