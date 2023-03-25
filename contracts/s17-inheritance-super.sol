// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Member {
    function sayHello() public pure virtual returns (string memory) {
        return "Hello from Member";
    }
}

contract User is Member {
    function sayHello() public pure override returns (string memory) {
        return "Hello from User";
    }

    function welcome(bool isMember) public pure returns (string memory) {
        if (isMember) {
            return User.sayHello();
        } else {
            // return Member.sayHello(); // same as below
            // call parent function
            return super.sayHello();
        }
    }
}
