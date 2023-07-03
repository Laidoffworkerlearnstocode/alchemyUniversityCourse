// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    function double(uint z) external pure returns (uint d){
        d = z * 2;
    }
    function double(uint x ,uint y) external pure returns(uint, uint){
        return (x * 2, y * 2);
    }
}