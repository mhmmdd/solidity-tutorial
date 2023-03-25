// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Functions {
    // show function visibility types

    // public: anyone can call this function
    // private: only this contract can call this function
    // internal: only this contract or contracts that inherit from this contract can call this function
    // external: this function can only be called outside the contract

    // view: this function will not modify the state of the contract
    // pure: this function will not modify the state of the contract and will not read from the state of the contract
    // payable: this function can receive Ether
}
