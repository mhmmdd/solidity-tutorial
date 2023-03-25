// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructEnum {

    // enum
    enum Status {Pending, Shipped, Accepted, Rejected, Canceled}

    struct Order {
        address buyer;
        uint256 amount;
        string zipCode;
        uint256 [] items;
        Status status;
    }

    Order [] public orders;
    address public owner;
    uint256 public orderCount;

    // events
    // indexed keyword is used to filter events on etherscan
    event OrderCreated(uint256 orderId, address indexed buyer);
    event ZipCodeUpdated(uint256 orderId, string zipCode);

    constructor() {
        owner = msg.sender;
    }

    // create order function only zipCode and items
    function createOrder(string memory zipCode, uint256 [] memory items) checkItems(items) incrementOrderCount
    public returns (uint256) {
        // it is not necessary because of checkItems modifier
        // require(products.length > 0, "No products found");

        Order memory order = Order(msg.sender, 0, zipCode, items, Status.Pending);

        // another way to create struct
        //        Order memory order = Order({
        //            buyer: msg.sender,
        //            amount: 0,
        //            zipCode: zipCode,
        //            items: items,
        //            status: Status.Pending
        //        });
        orders.push(order);

        // emit event
        emit OrderCreated(orders.length - 1, msg.sender);
        return orders.length - 1;
    }


    // advance order function
    function advanceOrder(uint256 orderId) onlyOwner public {
        require(orderId < orders.length, "Order not found");

        Order storage order = orders[orderId];

        // check if order is already shipped
        require(order.status == Status.Shipped, "Order is not shipped yet");

        order.status = Status(uint256(order.status) + 1);
    }

    // get order function
    function getOrder(uint256 orderId) checkOrder(orderId) public view returns (Order memory) {
        // it is not necessary because of checkOrder modifier
        // require(orderId < orders.length, "Order not found");

        return orders[orderId];
    }

    // update zip code function
    function updateZipCode(uint256 orderId, string memory zipCode) checkOrder(orderId) onlyBuyer(orderId) incrementOrderCount public {
        // it is not necessary because of checkOrder modifier
        // require(orderId < orders.length, "Order not found");

        Order storage order = orders[orderId];
        require(order.buyer == msg.sender, "Only buyer can update zip code");
        order.zipCode = zipCode;

        // emit event
        emit ZipCodeUpdated(orderId, zipCode);
    }

    // check items modifier
    modifier checkItems(uint256 [] memory items) {
        require(items.length > 0, "Order must have at least one item");
        _;
        // continue execution, this is basically a body of the function
    }

    modifier checkOrder(uint256 orderId) {
        require(orderId < orders.length, "Order not found");
        _;
        // continue execution, this is basically a body of the function
    }

    modifier incrementOrderCount {
        _;
        // continue execution, this is basically a body of the function
        orderCount++;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can advance order");
        _;
        // continue execution, this is basically a body of the function
    }

    modifier onlyBuyer(uint256 orderId) {
        require(orders[orderId].buyer == msg.sender, "Only buyer can update zip code");
        _;
        // continue execution, this is basically a body of the function
    }
}

