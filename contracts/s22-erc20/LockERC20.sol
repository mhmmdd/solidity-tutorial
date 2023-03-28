// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "./BEEToken.sol";
import "hardhat/console.sol";

contract LockERC20 {
    BEEToken public token;
    uint256 public lockerCount;
    uint256 public totalLocked;
    mapping(address => uint256) public lockers;

    constructor(address _token) {
        token = BEEToken(_token);
    }

    function lock(uint256 _amount) public {
        require(_amount > 0, "Amount cannot be 0");

        if (!(lockers[msg.sender] > 0)) {
            lockerCount++;
        }
        totalLocked += _amount;
        lockers[msg.sender] += _amount;

        bool ok = token.transferFrom(msg.sender, address(this), _amount);
        require(ok, "Transfer failed");
    }

    function withdraw() public {
        require(lockers[msg.sender] > 0, "Nothing to withdraw");
//        require(lockers[msg.sender] > 0, "Only the locker can withdraw tokens");

        uint256 amount = lockers[msg.sender];

        console.log(
            "Withdraw: %s, %s",
            msg.sender,
            amount
        );
        delete lockers[msg.sender];
        totalLocked -= amount;
        lockerCount--;

        require(token.transfer(msg.sender, amount), "Transfer failed");
    }
}
