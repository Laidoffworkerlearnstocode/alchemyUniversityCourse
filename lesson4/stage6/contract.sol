pragma solidity ^0.8.4;

contract Contract {
    function sumAndAverage (uint arg0, uint arg1, uint arg2, uint arg3) external pure returns (uint sum, uint average) {
        sum = arg0 + arg1 + arg2 + arg3;
        average = sum / 4;
        return (sum, average);
    }
}