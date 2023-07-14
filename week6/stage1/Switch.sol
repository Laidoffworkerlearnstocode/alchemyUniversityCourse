// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Switch {
    address public recipient;
    address public owner;
    uint public timestampStart;

    constructor(address _recipient) public payable {
        owner = msg.sender;
        recipient = _recipient;
        timestampStart = block.timestamp;
    }

    function withdraw() external {
        (bool success, ) = recipient.call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }

    function ping() external {
        require(msg.sender == owner, "You are not the owner.");
    }
    
}