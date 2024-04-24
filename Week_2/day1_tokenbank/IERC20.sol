// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 定义erc20的标准接口
interface IERC20 {

    // 转账事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    // 授权事件
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 余额接口
    function balanceOf(address account) external returns (uint256);
    // 转账接口
    function transfer(address to, uint256 value) external returns (bool);
    // 授权接口
    function approve(address spender, uint256 value) external returns (bool);
    // 授权余额接口
    function allowance(address owner, address spender) external returns (uint256);
    // 授权转账接口
    function transferFrom(address from, address to, uint256 value) external returns (bool);

}