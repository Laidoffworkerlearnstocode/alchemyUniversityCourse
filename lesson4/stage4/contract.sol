// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    error notEnoughEther(string message);
    error onlyOwner(string message);
    uint public minimumDonation = 1 ether;
    address public owner;

    modifier onlyOwnerFunction() {
        if (msg.sender != owner) {
            revert onlyOwner("Only the owner can call this function");
        }
        _;
    }

    constructor() payable {
        if (msg.value < minimumDonation) {
            revert notEnoughEther("You must send 1 ether or more");
        }
        owner = msg.sender;
    }

    function withdraw() external {
        if (msg.sender != owner) {
            revert onlyOwner("Only the owner can withdraw");
        }
        payable(msg.sender).transfer(address(this).balance);
    }
}