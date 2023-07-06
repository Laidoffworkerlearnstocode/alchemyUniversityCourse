// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    uint public counter = 10;
    function tick () external {
        counter--;
        if (counter == 0) {
            selfdestruct(payable(msg.sender));
        }
    }
}