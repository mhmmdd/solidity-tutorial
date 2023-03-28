// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BEEToken is ERC20 {

    constructor() ERC20("BEE Token", "BEE") {
        // create 1 million tokens with 18 decimals
        _mint(msg.sender, 1000000000000000000000000);
    }
}
