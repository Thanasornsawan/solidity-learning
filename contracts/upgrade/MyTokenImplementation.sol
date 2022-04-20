//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./MyTokenUpgradeable.sol";

contract MyTokenImplementation is MyTokenProxy {
    function version() public pure returns (string memory) {
        return "v2!";
    }

    function area() public view returns(uint) {
        return length * width;
    }
}