// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract CodeHash {
    mapping(address => bytes32) public codehash;

    function getContractCodeHash(address contractAddress) public view returns (bytes32 contractCodeHash) {
        assembly {
            contractCodeHash := extcodehash(contractAddress)
        }
    }

    function initHash() external {
        codehash[msg.sender] = getContractCodeHash(msg.sender);
    }
}
