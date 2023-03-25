// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    // override is required
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);

    // override is not required
    event Transfer(address indexed from, address indexed to, uint256 value);
}

// Vault contract is generic and can be used for any token that implements IToken
contract Vault {
    mapping(address => mapping(IToken => uint256)) public balances;

    function deposit(IToken token, uint256 amount) external {
        token.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender][token] += amount;
    }

    function withdraw(IToken token, uint256 amount) external {
        require(balances[msg.sender][token] >= amount, "Insufficient balance");
        balances[msg.sender][token] -= amount;
        token.transfer(msg.sender, amount);
    }

    function balanceOf(IToken token) external view returns (uint256) {
        return token.balanceOf(address(this));
    }
}

contract TokenA is IToken {
    mapping(address => uint256) public balances;

    function transferFrom(address from, address to, uint256 amount) external override returns (bool) {
        require(balances[from] >= amount, "Insufficient balance");
        balances[from] -= amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external override returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return balances[account];
    }
}



