pragma solidity ^0.5.4;

contract Variables {
    // write all fixed types in solidity
    // uint8, uint16, uint32, uint64, uint128, uint256
    uint8 public myUint8 = 255;
    uint256 public myUint256 = 2**256 - 1;
    int8 public myInt8 = -128;
    int256 public myInt256 = -(2**255);

    // address
    address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // boolean
    bool public myBool = true;

    // string
    string public myString = "Hello World";

    // bytes
    bytes32 public myBytes32 = "Hello World";

    // arrays
    uint[] public myArray = [1, 2, 3];

    // structs
    struct MyStruct {
        uint myUint;
        string myString;
    }

    MyStruct public myStruct = MyStruct(1, "Hello World");

    // enum
    enum Action {ADD, REMOVE, UPDATE}

    if (Action.ADD == 0) {
        // do something
    }

    // units
//    1 ether == 1 * 10**18 wei // 10^18 wei == 1 ether
//    1 wei == 1
//    1 gwei == 1 * 10**9 wei

    // time
//    now == block.timestamp
//    1 minute == 60 seconds
//    1 hour == 60 minutes
//    1 day == 24 hours
//    1 week == 7 days
//    1 year == 365 days
}
