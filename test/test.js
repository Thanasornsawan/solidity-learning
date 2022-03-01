var chai = require("chai");
var web3 = require('web3');
const BN = web3.utils.BN;
const chaiBN = require('chai-bn')(BN);
chai.use(chaiBN);
const { solidity } = require("ethereum-waffle");
chai.use(solidity);

var deepEql = require("deep-eql");
var chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);

const expect = chai.expect;

describe("HelloWorld contract", function () {
    it("Should return hello world", async function () {
      const helloContractFactory = await ethers.getContractFactory("helloWorld");
      const helloContract = await helloContractFactory.deploy();
      expect(await helloContract.hello()).to.equal("Hello World");
    });
  });

  describe("Course contract", function () {
    it("function viewCart, should return 1,2", async function () {
      const courseContractFactory = await ethers.getContractFactory("Courses");
      const courseContract = await courseContractFactory.deploy();
      const expected = [1,2];
      let chooseCoursesToBuy = await courseContract.chooseCoursesToBuy(1);
      chooseCoursesToBuy = await courseContract.chooseCoursesToBuy(2);
      const viewCourseID = await courseContract.viewCart();
      //Solidity numbers get converted to BigNumber instances because 
      //Javascript Number types cannot hold a full uint type.
      //So, you are getting an array of BigNumber instances.
      //You’d have to convert it to an array of strings or numbers to be able to do a deepEquals.
      expect(viewCourseID.toString()).to.equal(expected.toString());
    });
  });

