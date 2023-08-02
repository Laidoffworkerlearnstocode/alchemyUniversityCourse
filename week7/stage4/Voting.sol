// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Voting {
    enum VoteStates {Absent, Yes, No}

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        mapping (address => VoteStates) voteStates;
    }
    
    Proposal[] public proposals;

    address [] public whitelist;

    event ProposalCreated(uint indexed proposalID);
    event VoteCast(uint indexed proposalID, address indexed voter);
    
    constructor(address[] memory _whitelist ) {
        whitelist = _whitelist;
        whitelist.push(msg.sender);
    }

    modifier onlyWhitelist() {
        bool found = false;
        for(uint i = 0; i < whitelist.length; i++) {
            if(whitelist[i] == msg.sender) {
                found = true;
                break;
            }
        }
        require(found, "Not in whitelist");
        _;
    }

    function checkMinimumVotes(uint _proposalId) public view returns(bool _minimumVotesReached) {
        Proposal storage proposal = proposals[_proposalId];
        if (proposal.yesCount >= 10) {
            _minimumVotesReached = true;
        } else {
            _minimumVotesReached = false;
        }
        return _minimumVotesReached;
    }

    function newProposal(address _target, bytes calldata _data) external onlyWhitelist {
        Proposal storage proposal = proposals.push();
        proposal.target = _target;
        proposal.data = _data;
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint _proposalId, bool _supports) external onlyWhitelist{
        Proposal storage proposal = proposals[_proposalId];

        // clear out previous vote 
        if(proposal.voteStates[msg.sender] == VoteStates.Yes) {
            proposal.yesCount--;
        }
        if(proposal.voteStates[msg.sender] == VoteStates.No) {
            proposal.noCount--;
        }

        // add new vote 
        if(_supports) {
            proposal.yesCount++;
        }
        else {
            proposal.noCount++;
        }

        // we're tracking whether or not someone has already voted 
        // and we're keeping track as well of what they voted
        proposal.voteStates[msg.sender] = _supports ? VoteStates.Yes : VoteStates.No;
        emit VoteCast(_proposalId, msg.sender);

        bool minimumVotesReached = checkMinimumVotes(_proposalId);
        if(minimumVotesReached) {
            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Execution failed");
        }
    }
}
