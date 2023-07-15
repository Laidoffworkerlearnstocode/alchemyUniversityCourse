// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MultiSig {
    address [] public owners;
    uint256 public required;
    uint256 public txCount = 0;
    
    struct Transaction {
        address to;
        uint256 value;
        bool executed;
        bytes data;
    }

    mapping (uint => Transaction) public transactions;
    mapping (uint => mapping (address => bool)) public confirmations;

    constructor(address[] memory _owners, uint256 _required) {
        require(_owners.length >= _required, "owners < required");
        require(_required > 0, "required = 0");
        require(_required < _owners.length, "required > owners");
        owners = _owners;
        required = _required;
    }

    function transactionCount() public view returns (uint256) {
        return txCount;
    }

    function addTransaction(address _to, uint256 _value, bytes calldata _data) internal returns (uint256) {
        uint256 txId = txCount;
        Transaction memory transaction = Transaction({
            to: _to,
            value: _value,
            executed: false,
            data: _data
        });
        transactions[txId] = transaction;
        txCount += 1;
        return txId;
    }

    function submitTransaction(address _to, uint256 _value, bytes calldata _data) external {
        uint256 txID = addTransaction(_to, _value, _data);
        confirmTransaction(txID);
    }

    function confirmTransaction(uint256 _txID) public {
        bool isOwner = false;
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == msg.sender) {
                isOwner = true;
            }
        }
        require(isOwner, "not owner");
        require(_txID < txCount, "txID >= txCount");
        require(confirmations[_txID][msg.sender] == false, "tx already confirmed");
        confirmations[_txID][msg.sender] = true;
        if (isConfirmed(_txID)) {
            executeTransaction(_txID);
        }
    }

    function getConfirmationsCount(uint256 transactionId) public view returns (uint256 confirmationsCount) {
        for (uint256 i = 0; i < owners.length; i++) {
            if (confirmations[transactionId][owners[i]]) {
                confirmationsCount += 1;
            }
        }
        return confirmationsCount;
    }

    receive() external payable {
        require(msg.value > 0, "value = 0");
    }

    function isConfirmed(uint256 _txID) public view returns (bool _confirmed) {
        _confirmed = false;
        if(getConfirmationsCount(_txID) >= required) {
            _confirmed = true;
        }
        return _confirmed;
    }

    function executeTransaction (uint _txID) public {
        require(isConfirmed(_txID), "TX with this ID not confirmed");
        require(transactions[_txID].executed == false, "TX with this ID already executed");
        (bool success, ) = transactions[_txID].to.call{value: transactions[_txID].value}(transactions[_txID].data);
        require(success, "TX failed");
        transactions[_txID].executed = true;
    }
}
