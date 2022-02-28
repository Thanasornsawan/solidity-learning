# My solidity learning

This project use solidity hardhat and openzeppelin running on local.

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

running project on local hardhat network

first terminal try this command
```shell
npx hardhat node
```

Second terminal try this command
```shell
npx hardhat run --network localhost scripts/testCourse.js
```

Back to the first terminal, you will see gas execution of each functions in contract.
![local result](https://github.com/Thanasornsawan/solidity-learning/blob/main/local1.PNG?raw=true)