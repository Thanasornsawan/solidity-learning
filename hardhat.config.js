require("@nomiclabs/hardhat-waffle");
require("solidity-coverage");
require("hardhat-gas-reporter");
//uncomment this two line if you want to use openzeppelin test-helper in scripts/openzeppelin/test.js
//require("@nomiclabs/hardhat-web3");
//require("@nomiclabs/hardhat-truffle5");
//There's no need for require("@nomiclabs/hardhat-ethers"), as @nomiclabs/hardhat-waffle already does it.
require('@openzeppelin/hardhat-upgrades');
require("dotenv").config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.9",
  networks: {
    rinkeby: {
      url: process.env.DEVELOP_ALCHEMY_KEY,
      accounts: [process.env.PRIVATE_KEY]
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: process.env.ETHERSCAN_KEY
  },
  gasReporter: {
    enabled: (process.env.REPORT_GAS) ? false : true,
    currency: "USD",
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    excludeContracts: ["contracts/mocks/", "contracts/libraries/"],
  }
};
