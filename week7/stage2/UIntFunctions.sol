// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

library UIntFunctions {
    function isEven(uint input) pure public returns (bool even) {
        return input % 2 == 0;
    }
}