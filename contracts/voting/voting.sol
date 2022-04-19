// SPDX-License-Identifier: MIT
/* It is voting on proposal topic and ask the voter agree with this topic or not 
agree->voted:true, not agree->voted:false and everyone need to have rights to vote on this proposal
from the owner (ballotOfficialAddress), the owner will need to add voter address one by one.
and everyone and rights to vote just once.
*/
pragma solidity 0.8.9;

contract Ballot {
    struct vote {
        address voterAddress;
        bool choice;
    }

    struct voter {
        string voterName;
        bool voted;
    }

    uint private countResult=0;
    uint public finalResult=0;
    uint public totalVoter=0;
    uint public totalVote=0;

    address public ballotOfficialAddress;
    string public ballotOfficialName;
    string public propasal;

    mapping(uint=>vote) private votes;
    mapping(address=>voter) public voterRegister;

    enum State {Created, Voting, Ended }
    State public state;

    modifier condition(bool _condition){
        require(_condition);
        _;
    }

    modifier onlyOfficial() {
        require(msg.sender == ballotOfficialAddress);
        _;
    }

    modifier inState(State _state){
        require(state == _state);
        _;
    }

    constructor(string memory _ballotOfficialName, string memory _propasal){
        ballotOfficialAddress = msg.sender;
        ballotOfficialName = _ballotOfficialName;
        propasal = _propasal;
        state = State.Created;
    }

    function addVoter(address _voterAddress, string memory _voterName) public inState(State.Created) onlyOfficial {
        voter memory v;
        v.voterName = _voterName;
        v.voted = false;
        voterRegister[_voterAddress] = v;
        totalVoter++; //increment of account voter that we have
    }

    function startVote() public inState(State.Created) onlyOfficial {
        state = State.Voting;
    }

    function doVote(bool _choice) public inState(State.Voting) returns (bool voted) {
        bool found = false; //it just original set that we not found this voterAddress in our voterRegister
        //string voterName not have length method,it need to cast type string to bytes
        //we verify that this voterAddress exist in voterRegister or not by check from length
        //and verify that this voterAddress nerver voted before
        if(bytes(voterRegister[msg.sender].voterName).length != 0
        && !voterRegister[msg.sender].voted) {
            voterRegister[msg.sender].voted = true;
            vote memory v;
            v.voterAddress = msg.sender;
            v.choice = _choice;
            if(_choice){
                countResult++;
            }
            votes[totalVote] = v;
            totalVote++;
            found = true;
        }
        return found;
    }

    function endVote() public inState(State.Voting) onlyOfficial {
        state = State.Ended;
        finalResult = countResult;
    }
}