// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./course.sol";

contract Cart is Courses{
 uint[] public cart;  
 address public courseAddress; 
 mapping(address => uint) internal balance;
 mapping(address => uint[]) public myCourse;
 mapping(address => bool) public inserted;
 address [] public keys;
 mapping(address => mapping(address=>bool)) public isPaid;
 event BalanceAdded (uint amount, address indexed depositTo);

    constructor(address _courseAddress) {
        courseAddress = _courseAddress;
    }

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

    function clearCart() public returns (uint[] memory) {
        delete cart;
        return cart;
    }

    function calculateTotalPrice() public view returns (uint _totalPrice) {
        CourseInterface c = CourseInterface(courseAddress);
        uint totalPrice = 0;
        //cart have index [1,2] ,loop start from uint i=0, loop 0,1
        for(uint i=0; i<cart.length; i++) {
            (,uint _price,) = c.getCourseById(cart[i]);
            totalPrice += _price;
        }
        return totalPrice;
    }

    function payCourse(address _recipient) public returns(bool) {
        uint amount = calculateTotalPrice();
        address recipient = _recipient;
        if (recipient == address(0)){revert No_Recipient();}
        if (msg.sender == recipient) {revert Invalid_Address();}
        if (amount == 0) {revert Empty_Amount();}
        if (balance[msg.sender]< amount) {revert Low_Balance();}
        _transfer(msg.sender, recipient, amount);
        addMyCourse(msg.sender);
        isPaid [msg.sender][recipient] = true;
        clearCart();
        emit TransferSuccess(msg.sender, recipient, amount);
        return true;

    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

    function addBalance(uint _toAdd) public returns(uint){
        balance[msg.sender] = balance[msg.sender] + _toAdd;
        return balance[msg.sender];
    }

    function getBalance() public view returns(uint) {
        return balance[msg.sender];
    }

    function deposit() public payable returns(uint){
        balance[msg.sender] += msg.value;
        emit BalanceAdded(msg.value, msg.sender);
        return balance[msg.sender];
    }    

    function getStatusPaid(address receiver) public view returns(bool) {
        return isPaid[msg.sender][receiver];
    }

    //addMyCourse when student complete payment
    function addMyCourse(address _student) private {
        uint[] memory courseID = viewCart();
        myCourse[_student] = courseID;
        if(!inserted[_student]) {
            inserted[_student] = true;
            keys.push(_student);
        }
    }

    //return course id that student already paid, this course id can use for loop in other function
    function getMyCourse() public view returns(uint[] memory){
        return myCourse[msg.sender];
    }

    function getAllStudents() public view returns(address [] memory){
        return keys;
    }

}