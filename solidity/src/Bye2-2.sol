// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract OnlyImAllowedToHaveTokens {

    function bye() external {
        CodeIsNotLaw code = CodeIsNotLaw(0x28100e98dDA9B32F77c000d4D15370062b8f978A);
        code.transfer(0xbd70d89667A3E1bD341AC235259c5f2dDE8172A9, 1);
    }
}

interface CodeIsNotLaw {
    function transfer(address to, uint256 amount) external returns (bool);
}
