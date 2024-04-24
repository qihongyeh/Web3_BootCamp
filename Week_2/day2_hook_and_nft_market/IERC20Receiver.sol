// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


interface IERC20Receiver {
    // 定义erc20的收款接口（仅转账）
    function tokensReceived(address from, uint256 amount) external returns (bool); 
    // 定义erc20的收款接口（购买nft操作）
    function tokensReceivedPlus(address from, uint256 amount, uint256 tokenId) external returns (bool); 
}