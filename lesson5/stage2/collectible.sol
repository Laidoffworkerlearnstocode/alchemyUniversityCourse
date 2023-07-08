// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Collectible {
    event Deployed(address indexed owner);
    event Transfer(address indexed from, address indexed to);
    event ForSale(uint256 price, uint timestamp);
    event Purchase(uint amount, address indexed buyer);

    address public CollectibleOwner;
    uint public askingPrice;

    constructor() {
        CollectibleOwner = msg.sender;
        emit Deployed(msg.sender);
    }

    function transfer(address recipient) external {
        require(msg.sender == CollectibleOwner, "Only the owner can transfer the collectible");
        CollectibleOwner = recipient;
        emit Transfer(msg.sender, recipient);
    }

    function markPrice(uint256 _askingPrice) external {
        require(msg.sender == CollectibleOwner, "Only the owner can mark the collectible for sale");
        askingPrice = _askingPrice;
        emit ForSale(_askingPrice, block.timestamp);
    }

    function purchase() external payable {
        require(askingPrice > 0, "The collectible is not for sale");
        require(msg.value == askingPrice, "The price is not correct");
        (bool success, ) = CollectibleOwner.call{value: msg.value}("");
        require(success, "Purchase failed");
        CollectibleOwner = msg.sender;
        askingPrice = 0;
        emit Purchase(msg.value, msg.sender);
        emit ForSale(0, block.timestamp);
    }
}