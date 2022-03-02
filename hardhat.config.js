require("@nomiclabs/hardhat-waffle");
require("solidity-coverage");
require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-web3");
require("@nomiclabs/hardhat-truffle5");
require("dotenv").config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  gasReporter: {
    enabled: (process.env.REPORT_GAS) ? true : false,
    currency: "USD",
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    excludeContracts: ["contracts/mocks/", "contracts/libraries/"],
  }
};
