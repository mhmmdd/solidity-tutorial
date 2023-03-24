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

    constructor() {
        owner = msg.sender;
    }

    // create order function only zipCode and items
    function createOrder(string memory zipCode, uint256 [] memory items) public returns (uint256) {
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
        return order.length - 1;
    }


    // advance order function
    function advanceOrder(uint256 orderId) public {
        require(msg.sender == owner, "Only owner can advance order");
        require(orderId < orders.length, "Order not found");

        Order storage order = orders[orderId];

        // check if order is already shipped
        require(order.status == Status.Shipped, "Order is not shipped yet");

        order.status = Status(uint256(order.status) + 1);
    }

    // get order function
    function getOrder(uint256 orderId) public view returns (Order memory) {
        require(orderId < orders.length, "Order not found");
        return orders[orderId];
    }

    // update zip code function
    function updateZipCode(uint256 orderId, string memory zipCode) public {
        require(orderId < orders.length, "Order not found");
        Order storage order = orders[orderId];
        require(order.buyer == msg.sender, "Only buyer can update zip code");
        order.zipCode = zipCode;
    }
}

