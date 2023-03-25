// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Constructor {
    string public tokenName;
    uint public totalSupply;

    constructor(string memory _tokenName, uint _totalSupply) {
        tokenName = _tokenName;
        totalSupply = _totalSupply;
    }

    function getTokenName() public view returns(string memory) {
        return tokenName;
    }

    function getTotalSupply() public view returns(uint) {
        return totalSupply;
    }

    
}
