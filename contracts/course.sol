// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Courses is Ownable{
    uint[] public cart;
    mapping(address => uint) balance;
    using Counters for Counters.Counter;
    Counters.Counter private _courseId;
    bool isPaid = false;

      struct Course{
        uint price;
        string title;
        uint256 _id;
    }

    mapping (uint => Course) public courses;
    event transferSuccess (address indexed sender, address indexed reciever, uint amount);
    event balanceAdded (uint amount, address indexed depositTo);

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

    function getCourseById(uint index) public view returns(uint _ID, uint _price, string memory title){
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

//function about cart

 function chooseCoursesToBuy(uint index) public returns (uint[] memory){
        cart.push(index); //put id of course
        return cart;
    }

    function viewCart() public view returns (uint[] memory){
        return cart;
    }

    function removeCourseToBuy(uint index) public returns (uint[] memory){
        //move index to last index for pop
        //solidity cannot use "delete cart[1]" because array lenght not change from immutable
        cart[index] = cart[cart.length - 1];
        cart.pop();
        return cart;
    }

    function calculateTotalPrice() view public returns (uint _totalPrice) {
        uint totalPrice = 0;
        //cart have index [1,2] ,loop start from uint i=0, loop 0,1
        for(uint i=0; i<cart.length; i++) {
            (, uint _price,) = getCourseById(cart[i]);
            totalPrice += _price;
        }
        return totalPrice;
    }

    function payCourse(address recipient) public returns(bool) {
        uint amount = calculateTotalPrice();
        require(amount != 0, "Please choose courses to buy first!!");
        require(balance[msg.sender]>= amount, "Your balance is insufficient");
        require(msg.sender != recipient, "Do not transfer money back to your address");
        _transfer(msg.sender, recipient, amount);
        isPaid = true;
        emit transferSuccess(msg.sender, recipient, amount);
        return isPaid;
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

    //Additional function for deposit money to address (not relate to course)
    function addBalance(uint _toAdd) public returns(uint){
        balance[msg.sender] = balance[msg.sender] + _toAdd;
        return balance[msg.sender];
    }

    function getBalance()public view returns(uint) {
        return balance[msg.sender];
    }

    function deposit() public payable returns(uint){
        balance[msg.sender] += msg.value;
        emit balanceAdded(msg.value, msg.sender);
        return balance[msg.sender];
    }    

}