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
