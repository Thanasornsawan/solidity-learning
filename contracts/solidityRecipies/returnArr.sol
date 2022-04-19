// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
pragma experimental ABIEncoderV2;

contract Collections {
    struct User {
        address userAddress;
        uint balance;
    }
    User[] public users;

    function getUser1() external returns(address[] memory,uint[] memory) {
        address[] memory userAddress = new address[](users.length);
        uint[] memory balances = new uint[](users.length);

        for(uint i=0; i<users.length; i++) {
            userAddress[i] = users[i].userAddress;
            balances[i] = users[i].balance;
        }
        return (userAddress, balances);
    }

    function getUser2() external returns(User[] memory) {
        return users;
    }

}

