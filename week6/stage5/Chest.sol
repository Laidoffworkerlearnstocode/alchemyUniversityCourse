// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./IERC20.sol";

contract Chest {
    function plunder (address [] memory _arr)  external {
      for (uint i = 0; i < _arr.length; i++) {
        uint balance = IERC20(_arr[i]).balanceOf(address(this));
        IERC20(_arr[i]).transfer(msg.sender, balance);
      }
    }
}
