// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Constructor {
    uint256 public num;

    constructor(address _codehash) {
        ICodeHash codehash = ICodeHash(_codehash);
        codehash.initHash();

        // ISelf _self = ISelf(address(this));
        // num = _self.add(5, 5);
        //
        // Running 1 test for test/Constructor.t.sol:ConstructorTest
        // [FAIL. Reason: Setup failed: EvmError: Revert] setUp() (gas: 0)
        // Traces:
        //   [160379] ConstructorTest::setUp()
        //     ├─ [50299] → new CodeHash@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
        //     │   └─ ← 251 bytes of code
        //     ├─ [23358] → new <Unknown>@0x2e234DAe75C793f67A35089C9d99245E1C58470b
        //     │   ├─ [22430] CodeHash::initHash()
        //     │   │   └─ ← ()
        //     │   ├─ [0] 0x2e234DAe75C793f67A35089C9d99245E1C58470b::add(5, 5) [staticcall]
        //     │   │   └─ ← ()
        //     │   └─ ← 0 bytes of code
        //     └─ ← "EvmError: Revert"

        // Test result: FAILED. 0 passed; 1 failed; finished in 220.08µs
    }

    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }
}

interface ICodeHash {
    function initHash() external;
}

interface ISelf {
    function add(uint256 a, uint256 b) external pure returns (uint256);
}
