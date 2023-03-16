/**
 *Submitted for verification at Etherscan.io on 2023-03-11
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract OnlyImAllowedToHaveTokens {
    function bye() external {
        CodeIsNotLaw code = CodeIsNotLaw(0x09c9D3c78797FF87AAEe6dB8aEb5C0a3227310C4);
        code.transfer(0xbd70d89667A3E1bD341AC235259c5f2dDE8172A9, 1);
        selfdestruct(payable(msg.sender));
    }
}

interface CodeIsNotLaw {
    function transfer(address to, uint256 amount) external returns (bool);
}
