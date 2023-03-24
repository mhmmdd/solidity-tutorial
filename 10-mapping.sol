pragma solidity ^0.8.0;

contract Mapping {
    // like hash table or dictionary: key => value
    // iterate over mapping is not possible
    mapping(address => bool) public registered;

    bool public registered;

    // register user
    function register() public {
        // check if user is already registered
        require(!registered[msg.sender], "User already registered");

        registered[msg.sender] = true; // msg.sender is the address of the user
    }

    // check sender's registration status
    function isRegistered() public view returns (bool) {
        return registered[msg.sender];
    }

    // delete sender's registration status
    function unregister() public {
        // check if user is already registered
        require(registered[msg.sender], "User not registered");

        delete registered[msg.sender];
    }
}


contract NestedMapping {
    // depts mapping
    mapping(address => mapping(address => uint256)) public depts;

    // increase sender dept with amount
    function increaseDept(address _borrower, uint256 _amount) public {
        // check if amount is greater than zero
        require(_amount > 0, "Amount must be greater than zero");

        depts[msg.sender][_borrower] += _amount;
    }

    // decrease sender dept with amount
    function decreaseDept(address _borrower, uint256 _amount) public {
        // check if amount is greater than zero
        require(_amount > 0, "Amount must be greater than zero");
        // check if amount is less than dept
        require(_amount <= depts[msg.sender][_borrower], "Amount must be less than dept");

        depts[msg.sender][_borrower] -= _amount;
    }

    // get dept of sender with borrower
    function getDept(address _borrower) public view returns (uint256) {
        return depts[msg.sender][_borrower];
    }
}
