// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract OnlyImAllowedToHaveTokens1 {
    function bye() external {
        selfdestruct(payable(msg.sender));
    }
}
