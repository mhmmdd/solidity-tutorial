//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Strategy {
    // abstract contract can hold state variables
    uint256 public amount;
    address public owner;
    function getAddressAndAmount() public virtual returns (address, uint256);
}

interface IStrategy {
    function getAddressAndAmount() external returns (address, uint256);
}

contract EthSender {
    function send(address _strategyAddress) public {
        (address _address, uint256 _amount) = IStrategy(_strategyAddress).getAddressAndAmount();
        payable(_address).transfer(_amount);
    }

    function send(IStrategy _strategy) public {
        (address _address, uint256 _amount) = _strategy.getAddressAndAmount();
        payable(_address).transfer(_amount);
    }
}

contract AddressStratey1 is Strategy {
    function getAddressAndAmount() public override returns (address, uint256) {
        return (address(0x123), 100);
    }
}

contract AddressStratey2 is Strategy {
    function getAddressAndAmount() public override returns (address, uint256) {
        return (address(0x456), 200);
    }
}

