// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// 导入接口
import "./IERC20.sol";

contract TokenBank {

    // 初始化银行账表
    mapping (address user => uint256 value) public bankBalances;

    // 银行存款
    function deposit(address tokenAddress, uint256 value) public returns (bool) {
        // 调用目标ERC20合约的授权转账方法
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), value);
        // 加计银行账表
        bankBalances[msg.sender] += value;

        return true;
    }
    
    // 银行取款
    function withdraw(address tokenAddress, uint256 value) public returns (bool) {
        // 检查储户的账户余额是否足够转账
        require(bankBalances[msg.sender] >= value, "Your bank account amount is less than transfer amount!");
        // 调用目标ERC20合约的转账方法
        IERC20(tokenAddress).transfer(msg.sender, value);
        // 减计银行账表
        bankBalances[msg.sender] -= value;

        return true;
    }
}