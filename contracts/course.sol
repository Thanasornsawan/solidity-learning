// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
//use this import when run on remix instread of import from openzeppelin plug in
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Courses is Ownable{
    
    using Counters for Counters.Counter;
    Counters.Counter private _courseId;

      struct Course{
        uint price;
        string title;
        uint256 id;
        bool exam;
    }

    mapping (uint => Course) public courses;

    //calldata save gas more than memory
    function addCourse(uint _price, string calldata _title) public onlyOwner {
        uint256 newCourseId = _courseId.current();
        _courseId.increment();
        courses[newCourseId] = Course(_price, _title, newCourseId, false);
    }

    function updateDeatailCourse(uint _index, string calldata _title, uint _price, bool _exam) public onlyOwner returns (Course memory) {
        Course storage course = courses[_index];
        course.title = _title;
        course.price = _price;
        course.exam = _exam;
        return course;
    }

    function getCourseById(uint index) external view returns(uint _id, uint _price, string memory _title, bool _exam){
        Course storage course = courses[index];
        _id = course.id;
        _price = course.price;
        _title = course.title;
        _exam = course.exam;
        return (_id, _price, _title, _exam);
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