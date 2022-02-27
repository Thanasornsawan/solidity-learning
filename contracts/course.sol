// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Courses is Ownable{
    uint[] public cart;
    using Counters for Counters.Counter;
    Counters.Counter private _courseId;

      struct Course{
        uint price;
        string title;
        uint256 _id;
    }

    mapping (uint => Course) public courses;

    function addCourse(uint _price, string memory _title) public onlyOwner{
        uint256 newCourseId = _courseId.current();
        _courseId.increment();
        courses[newCourseId] = Course(_price, _title, newCourseId);
    }

    function updateDeatailCourse(string memory _title, uint _price) public {
        Course storage course = courses[1];
        course.title = _title;
        course.price = _price;
    }

    function chooseCoursesToBuy(uint index) public{
        cart.push(index); //put id of course
    }

    function viewCart() public view returns (uint[] memory){
        return cart;
    }

    function removeCourseToBuy(uint index) public{
        //move index to last index for pop
        //solidity cannot use "delete cart[1]" because array lenght not change from immutable
        cart[index] = cart[cart.length - 1];
        cart.pop();
    }

    function getCourseById(uint index) public view returns(uint _ID, uint _price, string memory title){
        Course memory course = courses[index];
        _ID = course._id;
        _price = course.price;
        title = course.title;
    }

    function getAllCourses() public view returns (Course[] memory){
      uint256 newCourseId = _courseId.current();
      Course[] memory id = new Course[](newCourseId);
      for (uint i = 0; i < newCourseId; i++) {
          Course storage course = courses[i];
          id[i] = course;
      }
      return id;
  }
}