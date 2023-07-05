// SPDX-License-Identifier: MIT
pragma solidity ^0.7.5;

contract Contract {
	address public owner;
	uint public configA;
	uint public configB;
	uint public configC;

	constructor() {
		owner = msg.sender;
	}

	function setA(uint _configA) public onlyOwner {
		configA = _configA;
	}

	function setB(uint _configB) public onlyOwner {
		configB = _configB;
	}

	function setC(uint _configC) public onlyOwner {
		configC = _configC;
	}

	modifier onlyOwner {
		// TODO: require only the owner access
        if (msg.sender != owner) {
            revert("Only the owner can call this function");
        }

		// TODO: run the rest of the function body
        _;

	}
}
