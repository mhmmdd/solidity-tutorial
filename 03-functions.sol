pragma solidity ^0.8.0;

contract Functions {
    uint luckyNumber = 7;

    function getLuckyNumber() public view returns (uint) {
        return luckyNumber;
    }

    //    uint public luckyNumber = 7;

    function setNumber(uint _luckyNumber) public {
        luckyNumber = _luckyNumber;
    }


    // pure function called nothing returns: 1, true, false
    function nothing() public pure returns (uint, bool, bool) {
        return (1, true, false);
    }
    function nothing() public pure returns (uint x, bool y, bool z) {
        x = 1;
        y = true;
        z = false;
    }

}
