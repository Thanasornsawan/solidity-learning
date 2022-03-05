// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

library Finance{
    function getBalanceContract() internal view returns(uint) {
        return address(this).balance;
    }
}