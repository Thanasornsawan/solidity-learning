const { expect } = require("chai");

describe("HelloWorld contract", function () {
    it("Should return hello world", async function () {
      const helloContractFactory = await ethers.getContractFactory("helloWorld");
      const helloContract = await helloContractFactory.deploy();
      expect(await helloContract.hello()).to.equal("Hello World");
    });
  });