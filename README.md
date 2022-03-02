# My solidity learning

This project is my personal practice use solidity hardhat and chai testing.

First terminal try this command:
```shell
npx hardhat node
```

![node result](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/node.PNG?raw=true)

Second terminal try this command:
```shell
npx hardhat run --network localhost scripts/testCourse.js
```
![node result2](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/node2.PNG?raw=true)

But if you want to run on local without hardhat network,just try this command:
```shell
npx hardhat run scripts/testCourse.js
```

![local result2](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/local2.PNG?raw=true)

Back to the first terminal that have hardhat node, it will show gas execution all of contract.

![local result1](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/local3.PNG?raw=true)

If the function fall to the custom error in solidity,it will shows like this picture.

![custome error](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/result.PNG?raw=true)

Check code coverage in solidity contract for make testing script cover all functions.
```shell
npx hardhat coverage
```

![coverage result](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/cover.PNG?raw=true)

You can turn on and off hardhat gas reporter plugin by change at hardhat.config.js and see gas result compare with currency when use command:

```shell
npx hardhat test
```

Turn on plugin hardhar gas reporter

```javascript
gasReporter: {
    enabled: (process.env.REPORT_GAS) ? true : false,
}
```
![gas result1](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/testgas1.PNG?raw=true)

Turn off hardhat gas reporter

```javascript
gasReporter: {
    enabled: (process.env.REPORT_GAS) ? false : true,
}
```

![gas result2](https://github.com/Thanasornsawan/solidity-learning/blob/main/photos/testgas2.PNG?raw=true)

Setting currency for gas reporter is optional, you can get API KEY from (coinmarketcap pro)[https://pro.coinmarketcap.com/signup/] and then set credential **COINMARKETCAP_API_KEY** in .env file.

You can view another solution of test.js by openzeppelin-testhelper from [here](https://github.com/Thanasornsawan/solidity-learning/tree/main/scripts/openzeppelin)