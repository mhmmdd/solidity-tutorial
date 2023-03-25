// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Loop {
    uint256[15] public numbers;

    // fill array with for loop
    function fill() public {
        for (uint256 i = 0; i < numbers.length; i++) {
            // if number is nine, skip it
            if (i == 9) {
                continue;
            }
            numbers[i] = i;
        }
    }

    // fill array with while loop
    function fillWhile() public {
        uint256 i = 0;
        while (i < numbers.length) {
            // if number is nine, skip it
            if (i == 9) {
                i++;
                continue;
            }
            numbers[i] = i;
            i++;
        }
    }

    // get arrays numbers
    function getNumbers() public view returns (uint256[15] memory) {
        return numbers;
    }
}
