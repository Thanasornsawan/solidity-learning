// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./course.sol";

contract Cart is Courses{
 uint[] public cart;  
 address courseAddress; 
 bool isPaid = false;
 mapping(address => uint) internal balance;
 event balanceAdded (uint amount, address indexed depositTo);

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

    function calculateTotalPrice() public view returns (uint _totalPrice) {
        CourseInterface c = CourseInterface(courseAddress);
        uint totalPrice = 0;
        //cart have index [1,2] ,loop start from uint i=0, loop 0,1
        for(uint i=0; i<cart.length; i++) {
            (, uint _price,) = c.getCourseById(cart[i]);
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
        isPaid = true;
        emit transferSuccess(msg.sender, recipient, amount);
        return isPaid;

    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

    function addBalance(uint _toAdd) external returns(uint){
        balance[msg.sender] = balance[msg.sender] + _toAdd;
        return balance[msg.sender];
    }

    function getBalance() external view returns(uint) {
        return balance[msg.sender];
    }

    function deposit() public payable returns(uint){
        balance[msg.sender] += msg.value;
        emit balanceAdded(msg.value, msg.sender);
        return balance[msg.sender];
    }    
}