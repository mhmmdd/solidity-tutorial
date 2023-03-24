pragma solidity ^0.8.0;

contract Constructor {
    // constant: value cannot be changed
    // immutable: value cannot be changed and can only be set in the constructor
    uint public constant MAX_UINT = 2**256 - 1;
    address public immutable owner;

    // set max uint value in constructor
    constructor() {
        owner = msg.sender; // contract deployer
       // MAX_UINT = 2**256 - 1; // error
    }
    
}
