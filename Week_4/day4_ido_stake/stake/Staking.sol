// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Staking {
    event Stake(address indexed staker, uint256 stakeAmount);
    event Unstake(address indexed staker, uint256 unstakeAmount);
    event Claim(address indexed staker, uint256 claimAmount);
    event Redeem(address indexed staker, uint256 redeemAmount, uint256 burnAmount);

    // 质押代币RNT
    address RNT;
    // 质押奖励esRNT
    address esRNT;
    // 每秒esRNT的奖励数量
    uint256 public constant SECONDS_PERDAY = 86400;
    // 燃烧地址
    address burnAddr = 0x000000000000000000000000000000000000dEaD;

    struct RNTStake {
        uint256 balance;
        uint256 time;
    }

    struct esRNTRelease {
        uint256 amount;
        uint256 startTime;
    }

    mapping (address user => RNTStake) public RNTBalances;
    mapping (address user => uint256 balance) public esRNTBalances;
    mapping (address user => esRNTRelease[]) public esRNTReleaseArray;
    
    constructor(address _RNT, address _esRNT) {
        RNT = _RNT;
        esRNT = _esRNT;
    }
    
    // 用户存入RNT进行质押挖矿(用户需要对RNT进行授权)
    function stake(uint256 _amount) external returns (bool) {
        // 更新esRNT的奖励数量
        esRNTBalances[msg.sender] += 
        (block.timestamp - RNTBalances[msg.sender].time) / SECONDS_PERDAY * RNTBalances[msg.sender].balance;
        // 存入RNT并记录
        IERC20(RNT).transferFrom(msg.sender, address(this), _amount);
        RNTBalances[msg.sender].balance += _amount;
        RNTBalances[msg.sender].time = block.timestamp;

        //抛出存入RNT进行质押事件
        emit Stake(msg.sender, _amount);
        return true;
    } 

    // 用户提取先前质押的RNT
    function unstake(uint256 _amount) external returns (bool) {  
        // 检查解除质押数量是否小于当前数量
        require(_amount <= RNTBalances[msg.sender].balance, "Insufficient balance!!!");

        // 更新esRNT的奖励数量
        esRNTBalances[msg.sender] += 
        (block.timestamp - RNTBalances[msg.sender].time) / SECONDS_PERDAY * RNTBalances[msg.sender].balance;
        // 提取RNT并记录
        IERC20(RNT).transfer(msg.sender, _amount);
        RNTBalances[msg.sender].balance -= _amount;
        RNTBalances[msg.sender].time = block.timestamp;

        // 抛出提取RNT结束质押事件
        emit Unstake(msg.sender, _amount);
        return true;
    }

    // 用户领取质押奖励的esRNT
    function claim(uint256 _amount) external returns (bool) {
        // 检查领取数量是否小于当前数量
        require(_amount <= esRNTBalances[msg.sender], "Insufficient balance!!!");

        // 领取esRNT数量并记录
        IERC20(esRNT).transfer(msg.sender, _amount);
        esRNTBalances[msg.sender] -= _amount;
        // 在领取esRNT后记录开始释放的数量与开始事件戳
        esRNTReleaseArray[msg.sender].push(esRNTRelease({amount: _amount, startTime: block.timestamp}));

        // 抛出领取esRNT事件
        emit Claim(msg.sender, _amount);
        return true;
    }

    // 用户用esRNT兑换RNT,
    function redeem() external returns (bool) {
        require(IERC20(esRNT).balanceOf(msg.sender) > 0, "Insufficient balance of esRNT!!!");
        require(esRNTReleaseArray[msg.sender].length > 0, "Insufficient balance of rewards to redeem!!!");
        // 兑换时用户需将全部esRNT先转入合约内(用户对此授权)
        uint256 redeemAmounts = IERC20(esRNT).balanceOf(msg.sender);
        IERC20(esRNT).transferFrom(msg.sender, address(this), redeemAmounts);

        // 声明此次redeem的数量与burn的数量
        uint256 totalRedeem;
        uint256 totalBurn;
        // 遍历数组计算相应的redeem数量与burn数量
        for (uint i = 0; i < esRNTReleaseArray[msg.sender].length; i++) {
            uint256 timedelta = block.timestamp - esRNTReleaseArray[msg.sender][i].startTime;
            uint256 claimAmount = esRNTReleaseArray[msg.sender][i].amount;
            uint256 amountsToRedeem;
            uint256 amountsToBurn;
            if (timedelta < SECONDS_PERDAY * 30) {
                // 计算单次claim至今的可以领取数量
                amountsToRedeem = (timedelta * claimAmount) / (SECONDS_PERDAY * 30);
                // 计算单次claim至今需要burn的数量
                amountsToBurn = claimAmount - amountsToRedeem;
                // 加总此次redeem总数量
                totalRedeem += amountsToRedeem;
                // 加总此次burn总数量
                totalBurn += amountsToBurn; 
            } else {
                // 超过30天，不燃烧直接加总
                totalRedeem += claimAmount;
            }
        }

        // 清空数组
        delete esRNTReleaseArray[msg.sender];
        // 转移对应数量的RNT和燃烧对应数量的esRNT
        IERC20(RNT).transfer(msg.sender, totalRedeem);
        IERC20(esRNT).transfer(burnAddr, totalBurn);

        // 抛出esRNT兑换RNT事件
        emit Redeem(msg.sender, totalRedeem, totalBurn);
        return true;
    }
}