pragma solidity ^0.8.0;

contract Library {
    using Math for uint;

    function trial1(uint a, uint b) public pure returns (uint) {
        // return a.plus(b); // same as below
        return Math.plus(a, b);
    }

    function trial2(uint a, uint b) public pure returns (uint) {
        return Math.minus(a, b);
    }

    function trial3(uint a, uint b) public pure returns (uint) {
        return Math.multiply(a, b);
    }

    function trial4(uint a, uint b) public pure returns (uint) {
        return Math.divide(a, b);
    }

    function trial5(uint [] memory data, uint value) public pure returns (uint) {
        return Search.indexOf(data, value);
    }
}

library Math {
    function plus(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    function minus(uint a, uint b) public pure returns (uint) {
        return a - b;
    }

    function multiply(uint a, uint b) public pure returns (uint) {
        return a * b;
    }

    function divide(uint a, uint b) public pure returns (uint) {
        require(b != 0, "Math: divide by zero");
        return a / b;
    }

    function min(uint a, uint b) public pure returns (uint) {
        return a < b ? a : b;
    }
}

library Search {
    function indexOf(uint[] storage self, uint value) public view returns (uint) {
        for (uint i = 0; i < self.length; i++) {
            if (self[i] == value) {
                return i;
            }
        }
        return uint(- 1);
    }
}
