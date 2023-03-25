# Solidity Project Tutorial

[![Build Status](https://travis-ci.org/mhmmdd/solidity-tutorial.svg?branch=master)](https://travis-ci.org/mhmmdd/solidity-tutorial)

This is a tutorial project for a Solidity language. It includes a sample contract and a test suite.

## Installation
Install the dependencies with `npm install`.

## Testing
Run the test suite with `npm test`.


## Changes
1. 11-struct-enum.sol - added a struct and an enum.
2. 11-struct-enum.sol - added modifier.<br>
**modifier**: it is used to check the condition before executing the function.
3. 11-struc-enum.sol - added event.<br>
**event**: it is used to log the event in the blockchain.
4. 12-bank-send-ether.sol - send ether to the contract.<br>
   1. **transfer**: it is used to send ether and throw an error.
   ```solidity
    transfer(); // revert if failed
   ```
   2. **send**: it is used send ether and return a boolean value. 
   ```solidity
    bool success = send();
   ```
   3. **call**: it is used to send ether with data.
   ```solidity
    (bool success,) = to.call{value: amount, gas: gas}(data);
   ```
4. 12-bank-send-ether.sol - receive ether from the contract.<br>
   1. **receive**: it is used to receive ether.
   ```solidity
    receive() external payable {}
   ```
   2. **fallback**: it is used to receive ether with data. 
   ```solidity
    fallback() external payable {}
   ```
   Note: Falback is called when the receive function is not defined or when the data is sent with the transaction.
5. 13-error.sol - added custom error.
6. 14-library.sol - added library.
