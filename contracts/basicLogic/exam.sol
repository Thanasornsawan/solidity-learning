// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

contract Exam {

   enum ExamStatus{ waiting, retest, complete }
   ExamStatus public status;
   ExamStatus public constant DEFAULT_STATUS = ExamStatus.waiting;

    //status =1
   function setReTest() public returns(uint) {
      status = ExamStatus.retest;
      return uint(status);
   }

    //status =2
    function setComplete() public returns(uint){
      status = ExamStatus.complete;
      return uint(status);
   }

   function getExamStatus() public view returns (ExamStatus) {
      return status;
   }

   //status =0
   function getDefaultStatus() public pure returns (uint) {
      return uint(DEFAULT_STATUS);
   }
}