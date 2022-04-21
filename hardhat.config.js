require("@nomiclabs/hardhat-waffle");
require("solidity-coverage");
require("hardhat-gas-reporter");
//uncomment this two line if you want to use openzeppelin test-helper in scripts/openzeppelin/test.js
//require("@nomiclabs/hardhat-web3");
//require("@nomiclabs/hardhat-truffle5");
//There's no need for require("@nomiclabs/hardhat-ethers"), as @nomiclabs/hardhat-waffle already does it.
require('@openzeppelin/hardhat-upgrades');
require("@nomiclabs/hardhat-etherscan");
require("@openzeppelin/hardhat-defender");
require("dotenv").config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.9",
  networks: {
    rinkeby: {
      url: process.env.DEVELOP_ALCHEMY_KEY || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_KEY || ""
  },
  gasReporter: {
    enabled: (process.env.REPORT_GAS) ? false : true,
    currency: "USD",
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    excludeContracts: ["contracts/mocks/", "contracts/libraries/"],
  },
  defender: {
    apiKey: process.env.DEFENDER_TEAM_API_KEY || "",
    apiSecret: process.env.DEFENDER_TEAM_API_SECRET_KEY || "",
  }
};
