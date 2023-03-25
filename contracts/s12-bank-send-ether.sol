// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {

    mapping(address => uint) balance;

    // Deposit (pull) ether to the contract
    function sendEtherToContract() public payable {
        balance[msg.sender] += msg.value;
    }

    function showBalance() public view returns (uint) {
        return balance[msg.sender];
    }

    // Send ether to the contract sender
    function withdraw() public {
        uint amount = balance[msg.sender];
        balance[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    // Send ether to a specific address
    function withdraw(address payable to, uint amount) public {
        balance[msg.sender] -= amount;
        // transfer reverts the transaction if the amount is greater than the balance
        to.transfer(amount);
    }

    // Contract
    // Send ether to a specific address
    function withdraw(address payable to, uint amount, bytes memory data) public {
        balance[msg.sender] -= amount;
        // transfer reverts the transaction if the amount is greater than the balance
        bool success = to.send(amount);
        require(success, "Transfer failed.");
    }

    function withdraw(address payable to, uint amount, bytes memory data, uint gas) public {
        balance[msg.sender] -= amount;
        // transfer reverts the transaction if the amount is greater than the balance
        (bool success,) = to.call{value: amount, gas: gas}(data);
        require(success, "Transfer failed.");
    }


    // Receive ether
    receive() external payable {
        balance[msg.sender] += msg.value;
    }

    // Receive ether with data
    fallback() external payable {
        balance[msg.sender] += msg.value;
//        data = msg.data; // data should be hex encoded
    }

}

