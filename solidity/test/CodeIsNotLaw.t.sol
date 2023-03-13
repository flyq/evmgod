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
    }
}
