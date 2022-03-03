// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
//use this import when run on remix instread of import from openzeppelin plug in
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

error No_Recipient();
error Empty_Amount();
error Low_Balance();
error Invalid_Address();

interface CourseInterface {
    function getCourseById(uint index) view external returns(uint _ID, uint _price, string memory title);
}

contract Courses is Ownable{
    
    using Counters for Counters.Counter;
    Counters.Counter private _courseId;

      struct Course{
        uint price;
        string title;
        uint256 _id;
    }

    mapping (uint => Course) public courses;
    event transferSuccess (address indexed sender, address indexed reciever, uint amount);

    function addCourse(uint _price, string memory _title) public onlyOwner{
        uint256 newCourseId = _courseId.current();
        _courseId.increment();
        courses[newCourseId] = Course(_price, _title, newCourseId);
    }

    function updateDeatailCourse(string memory _title, uint _price) public returns (bool success) {
        Course storage course = courses[1];
        course.title = _title;
        course.price = _price;
        return true;
    }

    function getCourseById(uint index) view external returns(uint _ID, uint _price, string memory title){
        Course memory course = courses[index];
        _ID = course._id;
        _price = course.price;
        title = course.title;
        return (_ID, _price, title);
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