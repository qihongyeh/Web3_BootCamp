// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "../src/Staking.sol";

contract RNTToken is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(uint256 _amount) public {
        _mint(msg.sender, _amount);
    }
}

contract esRNTToken is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(uint256 _amount) public {
        _mint(msg.sender, _amount);
    }
}

contract StakingTest is Test {
    RNTToken public RNT;
    esRNTToken public esRNT;
    Staking public staking;
    address staker = makeAddr("staker");
    address projectOwner = makeAddr("projectOwner");

    function setUp() public {
        RNT = new RNTToken("RNT", "RNT");
        esRNT = new esRNTToken("esRNT", "esRNT");
        staking = new Staking(address(RNT), address(esRNT));
        // 测试准备：1200个RNT，200个转移至质押者, 1000个转移至质押合约。1000个esRNT转移至质押合约。
        vm.startPrank(projectOwner);
        RNT.mint(1_200);
        esRNT.mint(1_000);
        RNT.transfer(staker, 200);
        RNT.transfer(address(staking), 1_000);
        esRNT.transfer(address(staking), 1_000);
        vm.stopPrank();
        // 用户提前对RNT和esRNT的转移进行授权
        vm.startPrank(staker);
        RNT.approve(address(staking), 1_000_000_000);
        esRNT.approve(address(staking), 1_000_000_000);
        vm.stopPrank();
    }

    function test_RedeemPartial() public {
        vm.startPrank(staker);
        uint256 t0 = block.timestamp;
        vm.warp(t0);
        // 质押并检查RNT与esRNT余额数量是否一致
        staking.stake(200);
        (uint256 balance100, ) = staking.RNTBalances(staker);
        assertEq(balance100, 200);
        assertEq(staking.esRNTBalances(staker), 0);

        // 解除全部质押并检查是否有200个esRNT的奖励和200个RNT是否全部回到staker的账户
        uint256 t1 = t0 + 1 days;
        vm.warp(t1);
        staking.unstake(200);
        (uint256 balance0, ) = staking.RNTBalances(staker);
        assertEq(balance0, 0);
        assertEq(staking.esRNTBalances(staker), 200);
        assertEq(RNT.balanceOf(staker), 200);

        // 多次领取esRNT并检查
        // 当前时间点领取100个esRNT的奖励并开始线性释放
        staking.claim(100);
        // 15天后再次领取100个esRNT的奖励并开始线性释放
        uint256 t2 = t1 + 15 days;
        vm.warp(t2);
        staking.claim(100);
        // 检查奖励是否全部领取完毕
        assertEq(staking.esRNTBalances(staker), 0);

        // 再将时间向前推进15天检查线性释放的数据
        uint256 t3 = t2 + 15 days;
        vm.warp(t3);
        staking.redeem();
        assertEq(RNT.balanceOf(staker), 350);
    }

        function test_RedeemAll() public {
        vm.startPrank(staker);
        uint256 t0 = block.timestamp;
        vm.warp(t0);
        // 质押并检查RNT与esRNT余额数量是否一致
        staking.stake(200);
        (uint256 balance100, ) = staking.RNTBalances(staker);
        assertEq(balance100, 200);
        assertEq(staking.esRNTBalances(staker), 0);

        // 解除全部质押并检查是否有200个esRNT的奖励和200个RNT是否全部回到staker的账户
        uint256 t1 = t0 + 1 days;
        vm.warp(t1);
        staking.unstake(200);
        (uint256 balance0, ) = staking.RNTBalances(staker);
        assertEq(balance0, 0);
        assertEq(staking.esRNTBalances(staker), 200);
        assertEq(RNT.balanceOf(staker), 200);

        // 多次领取esRNT并检查
        // 当前时间点领取100个esRNT的奖励并开始线性释放
        staking.claim(100);
        // 15天后再次领取100个esRNT的奖励并开始线性释放
        uint256 t2 = t1 + 15 days;
        vm.warp(t2);
        staking.claim(100);
        // 检查奖励是否全部领取完毕
        assertEq(staking.esRNTBalances(staker), 0);

        // 再将时间向前推进30天检查线性释放的数据
        uint256 t3 = t2 + 30 days;
        vm.warp(t3);
        staking.redeem();
        assertEq(RNT.balanceOf(staker), 400);
    }

    function testFail_RedeemPartial() public {
        vm.startPrank(staker);
        uint256 t0 = block.timestamp;
        vm.warp(t0);
        // 质押并检查RNT与esRNT余额数量是否一致
        staking.stake(200);
        (uint256 balance100, ) = staking.RNTBalances(staker);
        assertEq(balance100, 200);
        assertEq(staking.esRNTBalances(staker), 0);

        // 解除全部质押并检查是否有200个esRNT的奖励和200个RNT是否全部回到staker的账户
        uint256 t1 = t0 + 1 days;
        vm.warp(t1);
        staking.unstake(200);
        (uint256 balance0, ) = staking.RNTBalances(staker);
        assertEq(balance0, 0);
        assertEq(staking.esRNTBalances(staker), 200);
        assertEq(RNT.balanceOf(staker), 200);

        // 多次领取esRNT并检查
        // 当前时间点领取100个esRNT的奖励并开始线性释放
        staking.claim(100);
        // 15天后再次领取100个esRNT的奖励并开始线性释放
        uint256 t2 = t1 + 15 days;
        vm.warp(t2);
        staking.claim(100);
        // 检查奖励是否全部领取完毕
        assertEq(staking.esRNTBalances(staker), 0);

        // 再将时间向前推进15天检查线性释放的数据
        uint256 t3 = t2 + 15 days;
        vm.warp(t3);
        staking.redeem();
        assertEq(RNT.balanceOf(staker), 400);
    }


}