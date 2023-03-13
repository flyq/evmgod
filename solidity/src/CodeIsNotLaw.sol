// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20.sol";

contract CodeIsNotLaw is ERC20("CodeIsNotLaw", "CINL", 18) {
    address public immutable onlyImAllowedToHaveTokens;
    bytes32 public immutable correctCodeHash;

    constructor() {
        onlyImAllowedToHaveTokens = address(new OnlyImAllowedToHaveTokens());
        correctCodeHash = getContractCodeHash(onlyImAllowedToHaveTokens);
    }

    function mint(address receiver) external {
        require(getContractCodeHash(receiver) == correctCodeHash, "code hash does not match");
        if (balanceOf[receiver] == 0) {
            _mint(receiver, 1);
        }
    }

    function getContractCodeHash(address contractAddress) private view returns (bytes32 contractCodeHash) {
        assembly {
            contractCodeHash := extcodehash(contractAddress)
        }
    }
}

contract OnlyImAllowedToHaveTokens {
    function bye() external {
        selfdestruct(payable(msg.sender));
    }
}
