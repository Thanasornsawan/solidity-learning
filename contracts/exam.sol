// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

contract Exam {

   enum ExamStatus{ waiting, retest, complete }
   ExamStatus status;
   ExamStatus constant defaultStatus = ExamStatus.waiting;

    //status =1
   function setReTest() public {
      status = ExamStatus.retest;
   }

    //status =2
    function setComplete() public {
      status = ExamStatus.complete;
   }

   function getExamStatus() public view returns (ExamStatus) {
      return status;
   }

   //status =0
   function getDefaultStatus() public pure returns (uint) {
      return uint(defaultStatus);
   }
}