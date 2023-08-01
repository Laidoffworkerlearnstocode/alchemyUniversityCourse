// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

library Prime {
    function dividesEvenly(uint _number, uint _divisor) public pure returns (bool) {
        return _number % _divisor == 0;
    }

    function isPrime(uint _number) public pure returns (bool) {
        if (_number <= 1) {
            return false;
        }

        for (uint i = 2; i < _number; i++) {
            if (dividesEvenly(_number, i)) {
                return false;
            }
        }

        return true;
    }
}