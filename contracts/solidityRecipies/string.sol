// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract MyString {
    function getLength(string calldata str) external pure returns(uint){
        return bytes(str).length;
    }

    function concatenateStr(
        string calldata a,
        string calldata b) external pure returns(string memory) {
            return string(abi.encodePacked(a,b));
        }
    
    function reverseStr(string calldata _str) external pure returns(string memory) {
        bytes memory str = bytes(_str);
        string memory tmp = new string(str.length); //create new string in the same length
        bytes memory _reverse = bytes(tmp);

        for(uint i=0; i<str.length; i++) {
            _reverse[str.length - i -1] = str[i];
        }
        return string(_reverse);
    }

    function compareStr(
        string calldata a,
        string calldata b) external pure returns(bool) {
            //compare two strings abc and abc in bytes
            return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
        }
}