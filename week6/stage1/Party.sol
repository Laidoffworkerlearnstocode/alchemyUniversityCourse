// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Party {
	uint256 public amount;
    address [] public guests;

    constructor(uint256 _amount) {
        amount = _amount;
    }

    function rsvp() external payable {
        require(msg.value == amount, "Please pay the right amount");
        for(uint i = 0; i < guests.length; i++) {
            require(guests[i] != msg.sender, "You have already RSVP'd");
        }
        guests.push(msg.sender);
    }

    function payBill(address _venue, uint _amount) external {
        (bool success, ) = _venue.call{value: _amount}("");
        require(success, "Payment failed");
        uint guestCount = guests.length;
        uint remainingAmount = amount * guestCount - _amount;
        uint amountPerGuest = remainingAmount / guestCount;
        for(uint i = 0; i < guestCount; i++) {
            (bool returned, ) = guests[i].call{value: amountPerGuest}("");
            require(returned, "return failed");
        }
    }
}