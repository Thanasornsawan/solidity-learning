# Solidity hardhat testing with openzeppelin test-helper

This test script require to install two packages and put in *hardhat.config.js*

```javascript
require("@nomiclabs/hardhat-web3");
require("@nomiclabs/hardhat-truffle5");
```

This script can run with *npx hardhat test* if this file under folder "test"
But I noticed that openzeplin test-helper on [github](https://github.com/OpenZeppelin/openzeppelin-test-helpers) use  [![NPM Package](https://img.shields.io/npm/v/@openzeppelin/test-helpers.svg)](https://www.npmjs.org/package/@openzeppelin/test-helpers) 
but my current project use npm version 8.3.1

Everytime run test command

```shell
npx hardhat test
```

It will show warning about node module as this picture.

![open result](https://github.com/Thanasornsawan/solidity-learning/blob/main/scripts/openzeppelin/result.PNG?raw=true)

I recommend as a choice for whatever you pleasure to use it because it just warning not something break.
