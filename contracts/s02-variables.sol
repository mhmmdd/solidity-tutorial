// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Variables {
    string public text = "Hello";

    function showText() public view returns (string memory) {
        return text;
    }

    function setText(string memory _text) public {
        text = _text;
    }

    // return local variable
    function getLocalVariable() public pure returns (uint) {
        uint localVariable = 10;
        return localVariable;
    }

    // return global variable
    function getGlobalVariable() public view returns (uint) {
        // show all global variables
        // https://docs.soliditylang.org/en/v0.8.0/units-and-global-variables.html
        return block.number;
    }

}

