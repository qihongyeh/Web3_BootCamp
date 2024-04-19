// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.4;

import "./Bank.sol";
// 定义接口
interface IWithdraw {
    function withdraw(uint amount) external;
}
// 继承父类
contract BigBank is Bank {
    // 设定新owner
    function setOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
    // 修饰器，是否为有钱人
    modifier onlyRich {
        require(msg.value > 1000000000000000, "Only rich man can deposit!");
        _;
    }
    // 存款功能
    function deposit() public override payable onlyRich {
        super.deposit();
    }
    // 修饰器，检查owner
    modifier onlyOwnable {
        require(msg.sender == owner, "You are not ownable!");
        _;
    }
    // 实现取款功能
    function withdraw(uint amount) public override onlyOwnable {
        super.withdraw(amount);
    }
}