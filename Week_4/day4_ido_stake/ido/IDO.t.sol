// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "../src/IDO.sol";

contract MyToken is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(uint256 _amount) public {
        _mint(msg.sender, _amount);
    }
}

contract IDOTest is Test {
    MyToken public token;
    IDO public ido;
    uint256 public IDOPrice = 1 ether;
    uint256 public IDOAmount = 100;
    uint256 public IDOSoftCap = 100 ether;
    uint256 public IDOHardCap = 200 ether;
    uint256 public IDOStartTime = block.timestamp;
    uint256 public IDOEndTime = block.timestamp + 7 days;
    address public seller = makeAddr("seller");
    address public buyer = makeAddr("buyer");


    function setUp() public {
        token = new MyToken("MyToken", "MT");
        ido = new IDO();
    }

    function test_IDOSuccess() public {
        // 铸造准备IDO的token数量
        vm.startPrank(seller);
        token.mint(IDOAmount);
        token.transfer(address(ido), 100);
        // 添加此次IDO预售活动
        ido.addIDO(address(token),IDOPrice, IDOAmount, IDOSoftCap, IDOHardCap, IDOStartTime, IDOEndTime);
        vm.stopPrank();

        // 用户参加预售
        uint256 buyerValue = 100 ether;
        vm.deal(buyer, buyerValue);
        vm.startPrank(buyer);
        (bool success1, ) = address(ido).call{value: buyerValue}(
            abi.encodeWithSignature("presale(address)", address(token))
        );
        require(success1, "Call failed!!!");
        // 用户提取token
        vm.warp(block.timestamp + 8 days);
        ido.claim(address(token));
        vm.stopPrank();
        // 检查用户账户是否有对应数量的token
        assertEq(token.balanceOf(buyer), 100);

        // 项目方提取ETH
        vm.prank(seller);
        ido.withdraw(address(token));
        // 检查项目方是否有对应数量的ETH
        assertEq(seller.balance, buyerValue);
    }

    function test_IDORefund() public {
        // 铸造准备IDO的token数量
        vm.startPrank(seller);
        token.mint(IDOAmount);
        token.transfer(address(ido), 100);
        // 添加此次IDO预售活动
        ido.addIDO(address(token),IDOPrice, IDOAmount, IDOSoftCap, IDOHardCap, IDOStartTime, IDOEndTime);
        vm.stopPrank();

        // 用户参加预售
        uint256 buyerValue = 50 ether;
        vm.deal(buyer, buyerValue);
        vm.startPrank(buyer);
        (bool success1, ) = address(ido).call{value: buyerValue}(
            abi.encodeWithSignature("presale(address)", address(token))
        );
        require(success1, "Call failed!!!");

        // 用户领取退款
        vm.warp(block.timestamp + 8 days);
        ido.refund(address(token));
        vm.stopPrank();
        // 检查用户账户是否有对应数量的token
        assertEq(buyer.balance, buyerValue);
    }

    function testFail_IDOTimestamp() public {
        // 铸造准备IDO的token数量
        vm.startPrank(seller);
        token.mint(IDOAmount);
        token.transfer(address(ido), 100);
        // 添加此次IDO预售活动
        ido.addIDO(address(token),IDOPrice, IDOAmount, IDOSoftCap, IDOHardCap, IDOStartTime, IDOEndTime);
        vm.stopPrank();

        // 用户参加预售
        uint256 buyerValue = 100 ether;
        vm.deal(buyer, buyerValue);
        vm.startPrank(buyer);
        (bool success, ) = address(ido).call{value: buyerValue}(
            abi.encodeWithSignature("presale(address)", address(token))
        );
        require(success, "Call failed!!!");
        // 用户提取token（非有效时间）
        vm.warp(block.timestamp + 3 days);
        ido.claim(address(token));
        vm.stopPrank();
        // 检查用户账户是否有对应数量的token
        assertEq(token.balanceOf(buyer), 100);
    }

    function testFail_IDOReplay() public {
        // 铸造准备IDO的token数量
        vm.startPrank(seller);
        token.mint(IDOAmount);
        token.transfer(address(ido), 100);
        // 添加此次IDO预售活动
        ido.addIDO(address(token),IDOPrice, IDOAmount, IDOSoftCap, IDOHardCap, IDOStartTime, IDOEndTime);
        vm.stopPrank();

        // 用户参加预售
        uint256 buyerValue = 100 ether;
        vm.deal(buyer, buyerValue);
        vm.startPrank(buyer);
        (bool success, ) = address(ido).call{value: buyerValue}(
            abi.encodeWithSignature("presale(address)", address(token))
        );
        require(success, "Call failed!!!");
        // 用户提取token
        vm.warp(block.timestamp + 8 days);
        // 重放
        ido.claim(address(token));
        ido.claim(address(token));
        vm.stopPrank();
        // 检查用户账户是否有对应数量的token
        assertEq(token.balanceOf(buyer), 100);
    }
    
}