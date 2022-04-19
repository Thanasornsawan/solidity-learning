// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
//solidity version ^0.8.0 enable safe math by default
import "hardhat/console.sol";

contract unSafeMath {
    //this function will error because safemath
    function testUnderflow() public pure returns (uint) {
        uint x=0;
        x--;
        return x;
        
    }

    //this function avoid safemath and return big amount
    function testUncheckedUnderflow() public pure returns (uint) {
        uint x=0;
        unchecked {x--;}
        return x;
    }
}