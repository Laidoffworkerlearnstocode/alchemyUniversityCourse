// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Escrow {
    address payable public arbiter;
    address payable public beneficiary;
    address payable public depositor; 
    bool public isApproved;

    event Approved(uint indexed amount);
    
    constructor(address payable _arbiter, address payable _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = payable(msg.sender);
        isApproved = false;
    }

    function approve() public {
        require(msg.sender == arbiter, "Only the arbiter can approve this transaction");
        uint amount = address(this).balance;
        (bool success, ) = beneficiary.call{value: amount}("");
        require(success, "Transfer failed.");
        isApproved = true;
        emit Approved(amount);
    }
}