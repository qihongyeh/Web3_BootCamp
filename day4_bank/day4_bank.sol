// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract Bank {
    // 定义相关变量
    mapping (address => uint) balances;
    address[3] depositorTop3;
    uint[3] balancesTop3;
    address owner;
    // 初始化合约控制者
    constructor() {
        owner = msg.sender;
    }
    // 修饰器，检查是否为合约控制者
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner!");
        _;
    }
    // 发送ETH到合约账户
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount can not be zero!");
        balances[msg.sender] += msg.value;
        calcDepositorTop3(msg.sender, balances[msg.sender]);
    }

    // 计算金额top3与相对应地址top3的数组
    function calcDepositorTop3(address depositor, uint amount) private {
        if (amount > balancesTop3[0]) {
            // 与top1进行比较，如果比它大就取代它位置
            balancesTop3[2] = balancesTop3[1];
            depositorTop3[2] = depositorTop3[1];
            balancesTop3[1] = balancesTop3[0];
            depositorTop3[1] = depositorTop3[0];
            balancesTop3[0] = amount;
            depositorTop3[0] = depositor;
        } else if (amount > balancesTop3[1]) {
            // 与top2进行比较，如果比它大就取代它位置
            balancesTop3[2] = balancesTop3[1];
            depositorTop3[2] = depositorTop3[1];
            balancesTop3[1] = amount;
            depositorTop3[1] = depositor;
        } else if (amount > balancesTop3[2]) {
            // 与top3进行比较，如果比它大就取代它位置
            balancesTop3[2] = amount;
            depositorTop3[2] = depositor;
        }
    }
    // 查看top3金额
    function getBalanceTop3() public view returns(uint[3] memory) {
        return balancesTop3;
    }
    // 查看top3地址
    function getDepositorTop3() public view returns (address[3] memory) {
        return depositorTop3;
    }
    // 从合约提取ETH
    function withdraw(uint amount) external onlyOwner  {
        require(address(this).balance >= amount, "The CA don't have enough money!");
        payable(owner).transfer(amount);
    }
}