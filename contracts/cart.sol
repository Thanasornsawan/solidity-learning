// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import "./library.sol";
import "./exam.sol";

/*
In this example, we define how to use function from other contract 2 methods
1. public contract from other project in this case is "Course contract"
when we want to use course function, we need to define interface as external
2. other contract that we have in project in this case is "Exam contract"
when we want to use function we need to import file and define contract address with variable
ex. exam = Exam(_examAddress);
*/

interface CourseInterface {
    function getCourseById(uint index) external view returns(uint _id, uint _price, string memory title);
}

error No_Recipient();
error Empty_Amount();
error Low_Balance();
error Invalid_Address();

contract Cart {
 Exam public exam;
 uint[] public cart;  
 address public courseAddress; 
 mapping(address => uint) internal balance;
 mapping(address => uint[]) public myCourse;
 mapping(address => bool) public inserted;
 mapping(address => uint) public studentExam;
 address [] public keys;
 mapping(address => mapping(address=>bool)) public isPaid;
 event BalanceAdded (uint amount, address indexed depositTo);
 event FallbackLog(string func, address sender,uint value, bytes data);
 event ReceiveLog(uint amount, uint gas);
 event TransferSuccess (address indexed sender, address indexed reciever, uint amount);

    constructor(address _courseAddress, address _examAddress) {
        courseAddress = _courseAddress;
        exam = Exam(_examAddress);
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
        emit BalanceAdded(_toAdd, msg.sender);
        return balance[msg.sender];
    }

    function getBalance() public view returns(uint) {
        return balance[msg.sender];
    }

    function depositContract() public payable returns(uint){
        balance[address(this)] += msg.value;
        balance[msg.sender] -= msg.value;
        return Finance.getBalanceContract();
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

    //when somebody try to call non-exist function and sent ether to this contract
    fallback() external payable {
        emit FallbackLog("fallback", msg.sender, msg.value, msg.data);
    }
    //when somebody sent money + empty data to contract
    receive() external payable {
        emit ReceiveLog(msg.value, gasleft());
    }

    function registerExam() public {
        studentExam[msg.sender] = exam.getDefaultStatus();
    }

    function registerRetakeExam() public {
        studentExam[msg.sender] = exam.setReTest();
    }

    function completeExam() private {
        studentExam[msg.sender] = exam.setComplete();
    }

    function getStatusExam() public view returns(uint){
        return studentExam[msg.sender];
    }

}