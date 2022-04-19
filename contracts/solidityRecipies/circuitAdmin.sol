// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
//this contract use for disable deposit and withdraw function when something bad happened
//not recommend to use in real because change status was control by one person
//it should be control by contract and get verify signature approve from many people
contract circuitStatus {
    bool public isActive = true;
    address admin;

    constructor() {
        admin = msg.sender;
    }

    function toggleCircuitBreaker() external {
        require(admin == msg.sender);
        isActive = !isActive;
    }
}