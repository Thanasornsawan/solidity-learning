const { expect } = require('chai');
const {
  BN,           // Big Number support
  constants,    // Common constants, like the zero address and largest integers
  expectEvent,  // Assertions for emitted events
  expectRevert, // Assertions for transactions that should fail
} = require('@openzeppelin/test-helpers');

const course= artifacts.require('Courses');

  describe("Course contract", function () {

    beforeEach(async function () {
      this.course= await course.new();
    });

    it("viewCart() => should return 1,2", async function () {
        const expected = [1,2];
        let chooseCoursesToBuy = await this.course.chooseCoursesToBuy(1);
        await this.course.chooseCoursesToBuy(2);
        const viewCourseID = await this.course.viewCart();
        //Solidity numbers get converted to BigNumber instances because 
        //Javascript Number types cannot hold a full uint type.
        //So, you are getting an array of BigNumber instances.
        //You’d have to convert it to an array of strings or numbers to be able to do a deepEquals.
        expect(viewCourseID.toString()).to.equal(expected.toString());
      });

      it("calculateTotalPrice() => should return 300", async function () {
        let newCourse = await this.course.addCourse(100, "course1");
        await this.course.addCourse(200, "course2");
        let chooseCourses = await this.course.chooseCoursesToBuy(0);
        await this.course.chooseCoursesToBuy(1);
        const totalPrice = await this.course.calculateTotalPrice();
        expect(totalPrice).to.be.not.undefined;
        expect(totalPrice).to.be.not.null;
        expect(totalPrice).to.be.not.NaN;
        //totalPrice return BigNumber { value: "300" }
        expect(totalPrice.toNumber()).to.equal(300);
      });

  });