const { expect } = require("chai");
const { ethers } = require("hardhat");
const { deepEql } = require("deep-eql");

  describe("Course and Cart contract", function () {
    let owner;
    let addr1;
    let addr2;
    let addrs;
    
    before(async function () {
      this.Course = await hre.ethers.getContractFactory('Courses');
      this.Cart = await hre.ethers.getContractFactory('Cart');
      this.Exam = await hre.ethers.getContractFactory('Exam');
    });
  
    beforeEach(async function () {
      [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
      this.course = await this.Course.deploy();
      await this.course.deployed();
      this.exam = await this.Exam.deploy();
      await this.exam.deployed();
      this.cart = await this.Cart.deploy(this.course.address, this.exam.address);
      await this.cart.deployed();
    });

    it("viewCart() => should return 1,2", async function () {
        const expected = [1,2];
        let chooseCoursesToBuy = await this.cart.chooseCoursesToBuy(1);
        await this.cart.chooseCoursesToBuy(2);
        const viewCourseID = await this.cart.viewCart();
        //Solidity numbers get converted to BigNumber instances because 
        //Javascript Number types cannot hold a full uint type.
        //So, you are getting an array of BigNumber instances.
        //You’d have to convert it to an array of strings or numbers to be able to do a deepEquals.
        expect(viewCourseID.toString()).to.equal(expected.toString());
      });

      it("calculateTotalPrice() => should return 300", async function () {
        let newCourse = await this.course.addCourse(100, "course1");
        await this.course.addCourse(200, "course2");
        let chooseCourses = await this.cart.chooseCoursesToBuy(0);
        await this.cart.chooseCoursesToBuy(1);
        const totalPrice = await this.cart.calculateTotalPrice();
        //totalPrice return BigNumber { value: "300" }
        //need to make expected price to be BigNumber for compare
        //Avoid to use .toNumber() with BigNumber to cause overflow on javascript
        const expected = hre.ethers.BigNumber.from("300");
        const zero = hre.ethers.BigNumber.from("0");
        expect(totalPrice).to.be.not.undefined;
        expect(totalPrice).to.be.not.null;
        expect(totalPrice).to.be.not.NaN;
        expect(totalPrice).to.be.not.equal(zero);
        expect(totalPrice).to.equal(expected);
      });
});