// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    address public owner;
    address payable public charityAddress;
    constructor(address _charityAddress) {
        owner = msg.sender;
        charityAddress = payable(_charityAddress);
    }
    receive() external payable {
        
    }

    function tip() external payable {
        require(msg.value > 0, "You must send some ether");
        payable(owner).transfer(msg.value);
    }

    function donate() external payable {
        charityAddress.transfer(address(this).balance);
        selfdestruct(payable(owner));
    }
    
}