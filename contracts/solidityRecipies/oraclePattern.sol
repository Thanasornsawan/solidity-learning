// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
contract Oracle {
    //use this oracle pattern for create random data
    address public admin;
    uint public rand;
    constructor() {
        admin = msg.sender;
    }

    function feedRandomness(uint _rand) external {
        require(msg.sender == admin);
        rand = _rand;
    }
}

contract MyContract {
    Oracle public oracle;
    uint public nonce;

    constructor(address oracleAddress) {
        oracle = Oracle(oracleAddress);
    }

    function makeRand() external returns(string memory) {
        uint rand = _randModulus(100);
        string memory result;
        if(rand==50) {
            result = "You win";
        }
        return result;
    }

    function _randModulus(uint mod) internal returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(
            nonce,
            oracle.rand(),
            block.timestamp,
            block.difficulty,
            msg.sender)
        )) % mod;
        nonce++;
        return rand;
    }

}