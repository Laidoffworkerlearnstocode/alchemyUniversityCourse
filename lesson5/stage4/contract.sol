// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Contract {
    function filterEven(uint[] memory _numbers) external pure returns (uint [] memory _evenNumbers) {
        uint evenElementsCount = 0;
        for (uint i = 0; i < _numbers.length; i++) {
            if (_numbers[i] % 2 == 0) {
                evenElementsCount++;
            }
        }
        _evenNumbers = new uint[](evenElementsCount);
        uint evenElementsIndex = 0;
        for (uint i = 0; i < _numbers.length; i++) {
            if (_numbers[i] % 2 == 0) {
                _evenNumbers[evenElementsIndex] = _numbers[i];
                evenElementsIndex++;
            }
        }
        return _evenNumbers;
    }
}