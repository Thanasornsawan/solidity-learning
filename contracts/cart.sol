// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./course.sol";
import "./payment.sol";

contract Cart is Courses, Payment {
 uint[] public cart;  
 address courseAddress;
 address paymentAddress;
 bool isPaid = false;

    constructor(address _courseAddress, address _paymentAddress) {
        courseAddress = _courseAddress;
        paymentAddress = _paymentAddress;
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
        PaymentInterface p = PaymentInterface(paymentAddress);
        address recipient = _recipient;
        if (recipient == address(0)){revert No_Recipient();}
        if (msg.sender == recipient) {revert Invalid_Address();}
        console.log(p.getBalance());
        console.log(msg.sender);
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
}