pragma solidity ^0.8.0;

contract Error {
    mapping(address => uint) public userBalance;

    // Custom error
    error InsufficientBalance(uint requested, uint available);
    error Deny(string reason);

    receive() external payable {
        revert Deny("You can't send ether to this contract.");
    }

    fallback() external payable {
        revert Deny("You can't send ether to this contract.");
    }


    function pay() external payable {
        userBalance[msg.sender] += 1 ether;
    }

    function withdraw(uint amount) notZero(amount) external {
        uint balance = userBalance[msg.sender];

        if (amount > userBalance[msg.sender]) {
            // transfer reverts the transaction if the amount is greater than the balance
            revert InsufficientBalance({
                requested : amount,
                available : userBalance[msg.sender]
            });
        }
        userBalance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        assert(userBalance[msg.sender] == balance - amount);
    }

    modifier notZero(uint amount) {
        require(amount > 0, "Amount should be greater than zero.");
        _;
    }
}
