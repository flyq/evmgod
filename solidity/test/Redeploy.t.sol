// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/Redeploy.sol";

contract RedeployTest is Test {
    Factory public factory;
    

    function setUp() public {
        factory = new Factory();
    }

    function testRedeploy() public {
        bytes memory test1Bytecode = vm.getCode("Redeploy.sol:Test1");
        emit log_named_bytes("test1 bytecode", test1Bytecode);

        address addr1 = factory.deploy(1, test1Bytecode);

        emit log_named_address("test1 address", addr1);

        Test1 test1 = Test1(addr1);
        test1.setUint(1);

        emit log_named_uint("test1 uint", test1.myUint());

        test1.killme();

        bytes memory test2Bytecode = vm.getCode("Redeploy.sol:Test2");
        emit log_named_bytes("test2 bytecode", test2Bytecode);

        
        // address addr2 = factory.deploy(1, test2Bytecode);

        // emit log_named_address("test2 address", addr2);

        test1.setUint(1);

        emit log_named_uint("test1 uint", test1.myUint());


        // Test2 test2 = Test2(addr1);
        // test2.setUint(1);

        // emit log_named_uint("test2 uint", test2.myUint());
        // test2.killme();

    }
}