pragma solidity ^0.8.0;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Wallet is Ownable {
    mapping(address => uint) public balances;

    function deposit() public payable onlyOwner {
        balances[msg.sender] += msg.value;
    }

    function withdraw(address payable _to, uint _amount) public onlyOwner {
        require(balances[msg.sender] >= _amount, "Insufficient funds");
        balances[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}
