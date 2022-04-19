// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

//use this pattern when you want to group transaction together in one function
contract Utils {
    ContractA public targetA;
    ContractB public targetB;

    constructor (address contractA, address contractB) {
        targetA = ContractA(contractA);
        targetB = ContractB(contractB);
    }

    function groupExecute(uint argA, uint argB) external {
    //Group two transaction from two contracts to sent together here.
    //if either of them fail, it will fail all function
        targetA.foo(argA);
        targetB.bar(argB);
    }
}

contract ContractA {
    uint public balance;
    function foo(uint arg) external {
        balance = balance + arg;
    }
}

contract ContractB {
    uint public balance;
    function bar(uint arg) external {
        balance = balance + arg;
    }
}