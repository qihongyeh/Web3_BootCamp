// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";

import {TokenHook} from "../src/TokenHook.sol";
import {TokenBank} from "../src/TokenBank.sol";

contract TokenBankTest is Test {

    TokenHook baseERC20;
    TokenBank tokenBank;

    function setUp() public {
        baseERC20 = new TokenHook();
        tokenBank = new TokenBank();
    }

    function test_tokenBank() public {
        // 首先对token的转移进行授权
        baseERC20.approve(address(tokenBank), 1000);

        // **********************存款测试**********************
        // 声明存款金额并进行存款
        uint256 depositAmount = 500;
        tokenBank.deposit(address(baseERC20), depositAmount);
        // 获取银行的记账结果
        uint256 balanceOfStep1 = tokenBank.bankBalances(address(this), address(baseERC20));
        // 检查真实存款数量与期望存款数量
        assertEq(balanceOfStep1, depositAmount, "Balance in bank is not equal to depositAmount!!!");

        // **********************取款测试**********************
        // 声明取款金额并进行取款
        uint withdrawAmount = 200;
        tokenBank.withdraw(address(baseERC20), withdrawAmount);
        // 获取银行的记账结果
        uint256 balanceOfStep2 = tokenBank.bankBalances(address(this), address(baseERC20));
        // 检查真实取款数量与期望取款数量
        assertEq(balanceOfStep1 - balanceOfStep2, withdrawAmount, "Withdraw has problem!!!");
    }

}

