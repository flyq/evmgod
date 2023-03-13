# EVMGOD

Recently, I am learning the implementation details of [evm](https://ethereum.org/en/developers/docs/evm/), mainly looking at the implementation of [revm](https://github.com/bluealloy/revm). So here are some demos for debugging revm to help me understand, also some solidity smart contracts.

# CodeIsNotLaw
There is a token called "CodeIsNotLaw", and its src code is here: https://goerli.etherscan.io/address/0x09c9d3c78797ff87aaee6db8aeb5c0a3227310c4#code

how to transfer 1 "CodeIsNotLaw" to any address?

- [x] When the constructor is executing, has the bytecode of the contract been deployed? nope, see solidity/test/Constructor.t.sol, but can call other contract corrently.
  - [x] Can the function of its contract be called in the constructor? nope
  - [x] Can the bytecode of its own contract be obtained in the constructor? nope


## reference
* [Ethereum EVM illustrated](https://takenobu-hs.github.io/downloads/ethereum_evm_illustrated.pdf)
* [revm](https://github.com/bluealloy/revm)
* [EVM through CTFs](https://www.evmthroughctfs.com/)
