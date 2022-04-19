// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenFaucet is ERC20 {
    uint public amountAllowed = 1000000000000000000;

    //when deploying the token give it a name and symbol
    //specify the amount of tokens minted for the owner
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 50000000 * (10 ** 18));
    }

    //when you requestTokens address and blocktime+1 day is saved in Time Lock
    mapping(address => uint) public lockTime;

    //allow users to call the requestTokens function to mint tokens
    function requestTokens (address requestor , uint amount) external {
        
        //perform a few check to make sure function can execute
        require(block.timestamp > lockTime[msg.sender], "lock time has not expired. Please try again later");
        
        //mint tokens
        _mint(requestor, amount);

        //updates locktime 1 day from now
        lockTime[msg.sender] = block.timestamp + 1 days;
    }
}
