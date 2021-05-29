// SPDX-License-Identifier: MIT

pragma solidity >=0.4.11 <=0.8.4;


contract Election{
    //Model a Candidate

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    //Store accounts that have votes
    mapping(address=>bool)public voters;
    //Store Candidates
    //Fetch Candididates
    mapping(uint=>Candidate) public candidates;

    //Store total number of Candidates
    uint public candidatesCount;

    //voted count
    event votedEvent(
        uint indexed _candidateId
    );


    constructor()public{
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        addCandidate("Candidate 3");
    }
    //add candidate to our mapping
    function addCandidate(string memory _name) private{
        candidatesCount++;
        candidates[candidatesCount]=Candidate(candidatesCount,_name,0);
    }

    function vote(uint _candidateId) public {
        //require that they havent voted yet
        require(!voters[msg.sender]);


        //require a valid candidate
        require(_candidateId>0 && _candidateId<=candidatesCount);
        //record that voter has voted
        voters[msg.sender]=true;
        //update candidate vote count
        candidates[_candidateId].voteCount++;

        //trigger voted event
        emit votedEvent(_candidateId);
    }

}
