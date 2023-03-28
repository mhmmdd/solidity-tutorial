# Solidity Project Tutorial

[![Build Status](https://travis-ci.org/mhmmdd/solidity-tutorial.svg?branch=master)](https://travis-ci.org/mhmmdd/solidity-tutorial)

This is a tutorial project for a Solidity language. It includes a sample contract and a test suite.

[Source Code](https://github.com/itublockchain/web3-bootcamp)

## Installation
1. Node.js and npm are required to run this project.
   ```shell
   $ node -v
   v18.15.0
   ```
Install the dependencies with `npm install`.

## Steps for creating a project
Source: [Hardhat](https://hardhat.org/getting-started/), [ITU Blockchain](https://github.com/itublockchain/web3-bootcamp/tree/master/2x0_Hardhat%26Ethers)

```shell
$ mkdir solidity-tutorial
$ cd solidity-tutorial
$ npm init -y
$ npm install --save-dev hardhat
$ npx hardhat
# select "Create a TypeScript project"
$ npm install --save-dev @nomicfoundation/hardhat-toolbox
$ npm install @openzeppelin/contracts

$ npm install --save-dev typescript @types/node @types/mocha @types/chai
$ npm install --save-dev @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers
$ npm install --save-dev ts-node
$ npx hardhat compile
$ npx hardhat test
```

## Deploying the contract
1. Create a new file in the `scripts` folder called `deploy.ts`.
2. Add the following code to the file:
```typescript
import { ethers } from "hardhat";

async function main() {
   const [deployer] = await ethers.getSigners();

   const lockFactory = await ethers.getContractFactory("Lock");
   // const lock = await lockFactory.deploy(1000, { value: ethers.utils.parseEther("0.001") });
   const lock = await lockFactory.deploy("0x0000000");
   console.log(`Lock deployed to ${lock.address}`);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
```
3. Run the following command to deploy the contract:
````shell
# Deploying to Fuji Testnet
$ npm hardhat run scripts/deploy.ts --network fuji
````
4. Run the following command to verify the contract:
````shell
# Verifying the contract on Fuji Testnet
$ npm hardhat verify --network fuji DEPLOYED_CONTRACT_ADDRESS "0x0000000"
````
5. https://testnet.snowtrace.io/contract/0x0000000


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
7. 15-storage-memory-calldata.sol - added storage, memory and calldata.
8.  [16-inheritance-override.sol](contracts/s16-inheritance-override.sol),
[17-inheritance-super.sol](contracts/s17-inheritance-super.sol),
[18-inheritance-import-ownable.sol](contracts/s18-inheritance-import-ownable.sol) - added inheritance.
9. [19-interaction.sol](contracts/s19-interaction.sol) - added interaction with other contracts.
10. [20-interface.sol](contracts/s20-interface.sol), 
[21-interface-event.sol](contracts/s21-interface-event.sol) - added interface.
11. Hardhat environment added.
12. ERC20 token and lock contract added.
13. Deployed the contract on Fuji Testnet.
