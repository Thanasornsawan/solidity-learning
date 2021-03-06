//SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MyTokenProxy is Initializable, ERC20Upgradeable, UUPSUpgradeable, OwnableUpgradeable {
uint public width;
uint public length;
address private admin;

    function initialize(uint _length, uint _width) external initializer {
        __ERC20_init("MyToken", "PLY");
        __Ownable_init();

        length = _length;
        width = _width;
        admin = msg.sender;

        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    //need to define this function whenever use UUPSUpgradeable
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

}
