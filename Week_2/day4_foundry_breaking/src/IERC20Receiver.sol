// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


interface IERC20Receiver {
    // 定义erc20的收款接口（带hook）
    function tokensReceived(address from, uint256 amount, bytes calldata data) external returns (bool); 
}