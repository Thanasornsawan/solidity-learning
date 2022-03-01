# My solidity learning

This project is my personal practice use solidity hardhat and chai testing.
 
##### Running on local.

```shell
npm install --save-dev @openzeppelin/contracts
```

Each file in contracts folder can see result compile function in the folder scripts:

```shell
npx hardhat run scripts/testCustomError.js
```

result
![custome error](https://github.com/Thanasornsawan/solidity-learning/blob/main/result.PNG?raw=true)

Each file in contracts folder can check contract work correctly as function should do in the folder test:

```shell
npx hardhat test
```
result
![custome error](https://github.com/Thanasornsawan/solidity-learning/blob/main/hello.PNG?raw=true)

##### Running project on local hardhat network

first terminal try this command
```shell
npx hardhat node
```

Second terminal try this command
```shell
npx hardhat run --network localhost scripts/testCourse.js
```
![local result2](https://github.com/Thanasornsawan/solidity-learning/blob/main/local2.PNG?raw=true)

Back to the first terminal, you will see gas execution of each functions in contract.

![local result1](https://github.com/Thanasornsawan/solidity-learning/blob/main/local1.PNG?raw=true)

Check code coverage in solidity contract for make testing script cover all functions
```shell
npx hardhat coverage
```

![coverage result](https://github.com/Thanasornsawan/solidity-learning/blob/main/cover.PNG?raw=true)

You can turn on and off hardhat gas reporter plugin by change at hardhat.config.js and see gas result compre with currency when use command

```shell
npx hardhat test
```

Turn on plugin hardhar gas reporter

```javascript
gasReporter: {
    enabled: (process.env.REPORT_GAS) ? true : false,
}
```
![gas result1](https://github.com/Thanasornsawan/solidity-learning/blob/main/testgas1.PNG?raw=true)

Turn off hardhat gas reporter

```javascript
gasReporter: {
    enabled: (process.env.REPORT_GAS) ? false : true,
}
```

![gas result2](https://github.com/Thanasornsawan/solidity-learning/blob/main/testgas2.PNG?raw=true)

Setting currency for gas reporter is optional, you can get API KEY from (coinmarketcap pro)[https://pro.coinmarketcap.com/signup/] and then set credential **COINMARKETCAP_API_KEY** in .env file