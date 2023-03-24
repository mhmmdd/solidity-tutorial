pragma solidity ^0.8.0;

contract IfElse {
    byte32 private hashedPassword;

    // memory is not stored in the blockchain
    // memory only exists during the execution of the function
    constructor(string memory _password) {
        hashedPassword = keccak256(abi.encodePacked(_password));
    }

    function login(string memory _password) public view returns (bool) {
        if (keccak256(abi.encodePacked(_password)) == hashedPassword) {
            return true;
        } else {
            return false;
        }
        // return keccak256(abi.encodePacked(_password)) == hashedPassword;
    }
}
