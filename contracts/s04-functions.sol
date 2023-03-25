// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Functions {
    uint public x = 3;

    function setX(uint _x) public {
        x = _x;
    }

    // veri değişikliği yok sadece değişkeni okuma var o yüzden view kullanıyoruz
    // write view function add value to x
    function addX(uint _x) public view returns (uint) {
        return x + _x;
    }

    // pure kullanıyoruz çünkü okuma ve yazma yok
    function nothing() public pure returns (uint, bool, bool) {
        return (1, true, false);
    }
}
