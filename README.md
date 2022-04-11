[![npm version](https://badge.fury.io/js/npm.svg)](https://badge.fury.io/js/npm)
[![Solidity Learning](https://github.com/Thanasornsawan/solidity-learning/actions/workflows/workflow.yml/badge.svg)](https://github.com/Thanasornsawan/solidity-learning/actions/workflows/workflow.yml)
[![Coverage Status](https://coveralls.io/repos/github/Thanasornsawan/solidity-learning/badge.svg)](https://coveralls.io/github/Thanasornsawan/solidity-learning)
![buidler](https://buidler.dev/buidler-plugin-badge.svg?1)

# Solidity Learning
> This project is for practice solidity with hardhat and testing contract with chai. The main contract is 'Courses' contract which only owner can create course and update.The other people will interact with 'Cart' contract which need to choose index of course to cart array and then make the payment of total price of courses in the cart.The 'Courses' contract will act as parent of 'Cart' contract.
You will learn about struct, array, map, inherit, custom error and so on from this project.

```markdown
/contracts
	course.sol
	cart.sol
  	exam.sol
```
*I currently update this project everyday on branch dev and remain branch main as stable version.*

## Prerequisites

This project requires NodeJS (version 8 or later) and NPM.
[Node](http://nodejs.org/) and [NPM](https://npmjs.org/) are really easy to install.
To make sure you have them available on your machine,try running the following command.

```sh
$ npm -v && node -v
8.3.1
v16.14.0
```

Check solidity compiler version:
```sh
solcjs --version
0.8.9+commit.e5eed63a.Emscripten.clang
```

Install dependencies listed in package.json:
```sh
npm install
```

## Table of contents

- [Solidity Learning](#solidity-learning)
  - [Prerequisites](#prerequisites)
  - [Table of contents](#table-of-contents)
  - [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Running project with hardhat](#running-project-with-hardhat)
    - [Running hardhat test](#running-hardhat-test)
    - [Running solhint validate all contracts](#running-solhint-validate-all-contracts)
  - [Security testing tools](#security-testing-tools)
    - [Running slither to check vulnerability on this project](#running-slither-to-check-vulnerability-on-this-project)
    - [Setup echidna-testing on this project](#setup-echidna-testing-on-this-project)
    - [Before running echidna, you must write echidna function testing fuzzing in contract](#before-running-echidna-you-must-write-echidna-function-testing-fuzzing-in-contract)
    - [Running echidna on this project](#running-echidna-on-this-project)
    - [Running echidna with config file](#running-echidna-with-config-file)
  - [Authors](#authors)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Installation

**BEFORE YOU INSTALL:** please read the [prerequisites](#prerequisites)

Start with cloning this repo on your local machine:

```sh
$ git clone https://github.com/Thanasornsawan/solidity-learning.git
$ cd solidity-learning
```
## Usage

### Running project with hardhat

First terminal try this command:
```shell
npx hardhat node
```

![node result](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/node.PNG?raw=true)

Second terminal try this command:
```shell
npx hardhat run --network localhost scripts/testCart.js
```
![node result2](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/local4.PNG?raw=true)

But if you want to run on local without hardhat network, just remove network option:
```shell
npx hardhat run scripts/testCart.js
```

![local result2](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/local1.PNG?raw=true)

Back to the first terminal that have hardhat node, it will show gas execution all of contract.

![local result1](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/local5.PNG?raw=true)

If the function fall to the custom error in solidity,it will shows like this picture.

![custome error](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/result.PNG?raw=true)

Check code coverage in solidity contract for make testing script cover all functions.
```shell
npx hardhat coverage
```

![coverage result](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/cover.PNG?raw=true)

### Running hardhat test

You can test the smart contract and view gas usage compare with currency on each testing function by hardhat gas reporter plugin. About setting currency for gas reporter is optional, you can get API KEY from (coinmarketcap pro)[https://pro.coinmarketcap.com/signup/] and then set credential *COINMARKETCAP_API_KEY* in .env file and then config the currency name in the `hardhat.config.js`.

```shell
npx hardhat test
```

Turn on plugin hardhar gas reporter in the hardhat.config.js

```javascript
gasReporter: {
    enabled: (process.env.REPORT_GAS) ? true : false,
}
```
![gas result3](https://github.com/Thanasornsawan/solidity-learning/blob/dev/photos/testgas3.PNG?raw=true)

Turn off hardhat gas reporter in the hardhat.config.js.

```javascript
gasReporter: {
    enabled: (process.env.REPORT_GAS) ? false : true,
}
```

![gas result4](https://github.com/Thanasornsawan/solidity-learning/blob/dev/photos/testgas4.PNG?raw=true)

You can view another solution of test.js by openzeppelin-testhelper from [here](https://github.com/Thanasornsawan/solidity-learning/tree/main/scripts/openzeppelin)

### Running solhint validate all contracts

```shell
solhint 'contracts/**/*.sol'
```

![solhint](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/solhint.PNG?raw=true)

* Edit rule in file `.solhint.json` see [detail](https://github.com/protofire/solhint/blob/master/docs/rules.md)

## Security testing tools
>I use wsl linux ubuntu on windows because some tools not works on windows rigth now.The path to windows is /mnt

### Running slither to check vulnerability on this project

```shell
slither contracts/cart.sol --solc-remap "@openzeppelin=./node_modules/@openzeppelin"
```

![slither1](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/slither1.PNG?raw=true)

### Setup echidna-testing on this project
You can check new version from https://github.com/crytic/echidna/releases

```shell
wget https://github.com/crytic/echidna/releases/download/v2.0.0/echidna-test-2.0.0-Ubuntu-18.04.tar.gz
sudo tar xzvf echidna-test-2.0.0-Ubuntu-18.04.tar.gz
sudo ln -s /mnt/c/Users/Ploy/Documents/echidna-test /usr/local/bin/echidna-test
chmod +x /mnt/c/Users/Ploy/Documents/echidna-test
```

### Before running echidna, you must write echidna function testing fuzzing in contract
Echidna properties are Solidity functions.A property must:
Have no argument
Return true if it is successful
Have its name starting with echidna
refer from [building-secure-contracts](https://github.com/crytic/building-secure-contracts/blob/master/program-analysis/echidna/how-to-test-a-property.md#write-a-property)

### Running echidna on this project

```shell
echidna-test contracts/course.sol --crytic-args "--solc-remap @openzeppelin=./node_modules/@openzeppelin"
```

### Running echidna with config file

```shell
echidna-test ./ --contract Courses --config echidna-config.yaml
```

Result may return
```shell
Analyzing contract: /mnt/c/Users/Ploy/Documents/moralis/solidity/solidity-learning/contracts/course.sol:Courses
echidna-test: No tests found in ABI
```
Because currently,I still didn't make any function for echidna to test

## Authors

* **Thanasornsawan Varathanamongkolchai** - [Thanasornsawan](https://github.com/Thanasornsawan)
