// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import "./BigBank.sol";

contract Ownable {
    // 声明状态变量
    address public owner;
    // 初始化owner
    constructor() {
        owner = msg.sender;
    }
    // 修饰器，检查owner
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can change owner of this contract!");
        _;
    }
    // 修改owner
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
    // 调用BigBank的withdraw方法
    function toWithdraw(address _address, uint amount) external {
        IWithdraw(_address).withdraw(amount);
    }
    // 实现ownable合约的收款功能
    receive() external payable {}
}