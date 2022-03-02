// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "hardhat/console.sol";

interface PaymentInterface {
    function getBalance() view external returns(uint);
}

contract Payment{

mapping(address => uint) internal balance;
event balanceAdded (uint amount, address indexed depositTo);

    function addBalance(uint _toAdd) external returns(uint){
        balance[msg.sender] = balance[msg.sender] + _toAdd;
        return balance[msg.sender];
    }

    function getBalance() external view returns(uint) {
        return balance[msg.sender];
    }

    function deposit() public payable returns(uint){
        balance[msg.sender] += msg.value;
        emit balanceAdded(msg.value, msg.sender);
        return balance[msg.sender];
    }    
}