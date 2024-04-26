// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";

import {TokenHook} from "../src/TokenHook.sol";
import {TokenBank} from "../src/TokenBank.sol";

contract TokenHookBankTest is Test {

    TokenHook baseERC20;
    TokenBank tokenBank;

    function setUp() public {
        baseERC20 = new TokenHook();
        tokenBank = new TokenBank();
    }

    function test_tokenHookBank() public {
        // 声明一个空字节与转账token数量
        bytes memory emptyBytes;
        uint256 testTokenAmount = 100;
        // 调用ERC20带hook的方法向TokenBank进行转账
        baseERC20.tokenTransferCallback(address(tokenBank), testTokenAmount, emptyBytes);
        // 获取TokenBank中DefaultSender的token余额并检查
        uint256 actualAmount = tokenBank.bankBalances(address(this), address(baseERC20));
        assertEq(actualAmount, testTokenAmount, "The actualAmount should be equal to the testTokenAmount!!!");
    }
    
}