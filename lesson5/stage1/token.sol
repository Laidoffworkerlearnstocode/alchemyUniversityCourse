// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}

    mapping (address => User) public users;

    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");
        users[msg.sender] = User(100, true);
    }

    function transfer(address to, uint amount) external {
        if (!users[msg.sender].isActive) {
            revert("User does not exist");
        } else if (!users[to].isActive) {
            revert("Recipient does not exist");
        } else if (users[msg.sender].balance < amount) {
            revert("Insufficient balance");
        }

        users[msg.sender].balance -= amount;
        users[to].balance += amount;
    }

}