// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/CodeHash.sol";
import "../src/Constructor.sol";

contract ConstructorTest is Test {
    Constructor public c;
    CodeHash public chash;

    function setUp() public {
        chash = new CodeHash();
        c = new Constructor(address(chash));
    }

    function testConstructor() public {
        emit log_named_uint("3 + 5 = ", c.add(3, 5));

        emit log_named_bytes32("chash.getContractCodeHash ", chash.getContractCodeHash(address(c)));
        emit log_named_bytes32("chash.codehash ", chash.codehash(address(c)));

        emit log_named_uint("c.num ", c.num());

        // Running 1 test for test/Constructor.t.sol:ConstructorTest
        // [PASS] testConstructor() (gas: 19729)
        // Logs:
        //   3 + 5 = : 8
        //   chash.getContractCodeHash : 0xe0cea69d6f7d1ff6d4ef7a0abb36e3fc17fccbffafb95e16e258d772b6629fe0
        //   chash.codehash : 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470
        //   KECCAK_EMPTY:      c5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470
    }
}
