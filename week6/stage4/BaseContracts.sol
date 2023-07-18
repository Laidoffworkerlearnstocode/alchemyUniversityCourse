// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Ownable {
    address public owner;
    constructor() {
        // This contract is the owner
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}

contract Transferable is Ownable {
    function transfer (address _newOwner) external onlyOwner {
        owner = _newOwner;
    }
}