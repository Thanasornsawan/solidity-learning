// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
//custom error
error Unauthorized(address caller);

contract VendingMachine {
    address payable owner = payable(msg.sender);

    function withdraw() public {
        if(msg.sender != owner) {
            //23642 gas for length of string "error"
            //revert("error");
            revert Unauthorized(msg.sender);
            owner.transfer(address(this).balance);
        }
    }
}