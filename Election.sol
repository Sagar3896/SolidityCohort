//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Election {
    
    // Model a Candidate

    struct  Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    
    address public owner;

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Store Candidates;

    // Fetch Candidate
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public candidatesCount;

    //
    modifier ownerOnly() {
    require (msg.sender == owner);
    _;
   }

    
    function election() public {
        //
    }

    function addCandidate(string memory _name) public {
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        candidatesCount++;
    }

    function Vote(uint _candidateId) public {
    
    // require that they haven't voted before
    require(voters[msg.sender] == false, "User has already casted vote !!");

    // require a valid candidate
    require(candidates[_candidateId].id == _candidateId);

    // record that voter has voted
    voters[msg.sender] = true;

    // update candidate vote Count
    candidates[_candidateId].voteCount++;


    }
}
