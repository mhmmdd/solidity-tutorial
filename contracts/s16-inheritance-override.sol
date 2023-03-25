// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    uint public x = 10;
    uint public y = 20;

    // virtual function can be overridden
    function setX(uint _x) virtual public {
        x = _x;
    }

    function setY(uint _y) public {
        y = _y;
    }
}

contract B is A {

    // override setX function
    function setX(uint _x) public override {
        x = _x * 2;
    }
}
