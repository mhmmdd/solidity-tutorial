// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Interact {
    address public caller;
    mapping(address => uint256) public counts;

    function callThis() public {
        caller = msg.sender;
        counts[msg.sender]++;
    }

    receive() external payable {
        caller = msg.sender;
        counts[msg.sender]++;
    }

    fallback() external payable {
        caller = msg.sender;
        counts[msg.sender]++;
    }
}

contract Pay {
    mapping(address => uint256) public balances;

    function payEth(address sender) public payable {
        balances[sender] += msg.value;
    }
}

contract Caller {
    Interact public interact;

    constructor(address payable _interact) {
        interact = Interact(_interact);
    }

    function callInteract() public {
        interact.callThis();
    }

    function readCaller() public view returns (address) {
        // caller variable is called like a function
        return interact.caller();
    }

    function readCounts() public view returns (uint256) {
        // counts variable is called like a function
        return interact.counts(msg.sender);
    }

    function payToPay(address _payAddress) public payable {
        Pay(_payAddress).payEth{value : msg.value}(msg.sender);
        // Pay pay = Pay(_payAddress);
        // pay.payEth{value : msg.value}(msg.sender);
    }

    function sendEthToInteractDirectly() public payable {
        payable(address(interact)).transfer(msg.value);
//        (bool success, ) = address(interact).call{value : msg.value}("");
//        require(success, "Failed to send Ether");
    }
}
