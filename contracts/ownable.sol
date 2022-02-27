// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Ownable {
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner, "not owner");
        _;
    }

    function setOwner(address _NewOwner) external onlyOwner{
        require(_NewOwner != address(0), "invalid address");
        owner = _NewOwner;
    }
}