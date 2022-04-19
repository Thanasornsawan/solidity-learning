// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "./circuitAdmin.sol";
contract circuitControlContract {
    circuitStatus public factory;
    constructor(address _factory) {
        factory = circuitStatus(_factory);
    }
    function withdraw() external contractIsActive() {}
    receive() external payable {}
    modifier contractIsActive() {
        require(factory.isActive() == true, "contract is lock");
        _;
    }
}