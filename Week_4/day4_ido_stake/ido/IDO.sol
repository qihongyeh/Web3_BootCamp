// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract IDO {
    event NewIDO(address indexed token, uint256 price, uint256 amount, uint256 softCap, uint256 hardCap, uint256 startTime, uint256 endTime);
    event Presale(address indexed token, address indexed buyer, uint256 value);
    event Claim(address indexed token, address indexed user, uint256 amount, uint256 price);
    event Withdraw(address indexed token, address indexed seller, uint256 value);
    event Refund(address indexed token, address indexed user, uint256 value);

    struct Cap {
        uint256 price;
        uint256 amount;
    }

    struct Target {
        uint256 softCap;
        uint256 hardCap;
    }

    struct Time {
        uint256 startTime;
        uint256 endTime;
    }

    // mapping(address seller => address )
    mapping(address buyer => mapping(address token => uint256 value)) public buyerBalances;
    mapping(address buyer => mapping(address token => bool isClaimed)) public isClaimeds;
    mapping(address token => address seller) public tokenSeller;
    mapping(address token => uint256 value) public totalRaised;
    mapping(address token => Cap) public presaleCap;
    mapping(address token => Target) public presaleTarget;
    mapping(address token => Time) public presaleTime;

    // 项目方新增IDO预售的方法
    function addIDO(
        address _token,
        uint256 _price,
        uint256 _amount,
        uint256 _softCap,
        uint256 _hardCap,
        uint256 _startTime,
        uint256 _endTime
    ) external returns (bool) {
        // 记录IDO的发起项目方
        tokenSeller[_token] = msg.sender;
        // 记录IDO预售价格与数量
        presaleCap[_token] = Cap({price: _price, amount: _amount});
        // 记录IDO预售ETH目标
        presaleTarget[_token] = Target({softCap: _softCap, hardCap: _hardCap});
        // 记录IDO预售起始时间
        presaleTime[_token] = Time({startTime: _startTime, endTime: _endTime});

        // 抛出新增的IDO事件
        emit NewIDO(_token, _price, _amount, _softCap, _hardCap, _startTime, _endTime);
        return true;
    }

    // 用户参与IDO预售的方法
    function presale(address _token) external payable returns (bool) {
        require(block.timestamp >= presaleTime[_token].startTime, "Presale not start yet!!!");
        require(block.timestamp <= presaleTime[_token].endTime, "Presale ended!!!");
        require(totalRaised[_token] < presaleTarget[_token].hardCap, "Presale target met!!!");

        // 加计预售token的募资ETH金额
        totalRaised[_token] += msg.value;
        // 记录用户对token预售存入的ETH
        buyerBalances[msg.sender][_token] = msg.value;

        // 抛出预售token的事件
        emit Presale(_token, msg.sender, msg.value);
        return true;
    }

    // 用户领取已购买的token
    function claim(address _token) external returns (bool) {
        require(block.timestamp > presaleTime[_token].endTime, "Presale is ongoing!!!");
        require(totalRaised[_token] >= presaleTarget[_token].softCap, "Presale failed, please request refund!!!");
        require(buyerBalances[msg.sender][_token] > 0, "Nothing to claim!!!");
        require(!isClaimeds[msg.sender][_token], "Already claimed!!!");

        // 计算预售过后的token价格与用户的领取数量
        presaleCap[_token].price = totalRaised[_token] / presaleCap[_token].amount;
        uint256 amountsToClaim = buyerBalances[msg.sender][_token] / presaleCap[_token].price;
        // 给用户转移相对应的token数量
        IERC20(_token).transfer(msg.sender, amountsToClaim);
        // 更新用户领取状态
        isClaimeds[msg.sender][_token] = true;

        // 抛出claim的事件
        emit Claim(_token, msg.sender, amountsToClaim, presaleCap[_token].price);
        return true;
    }

    // 项目方提取已募集到的ETH
    function withdraw(address _token) external returns (bool) {
        require(block.timestamp > presaleTime[_token].endTime, "Presale is ongoing!!!");
        require(totalRaised[_token] >= presaleTarget[_token].softCap, "Presale failed!!!");
        require(msg.sender == tokenSeller[_token], "Not seller!!!");

        (bool success, ) = msg.sender.call{value: totalRaised[_token]}("");
        require(success, "Withdraw failed!!!");

        // 抛出提款事件
        emit Withdraw(_token, msg.sender, totalRaised[_token]);
        return true;
    }

    // 用户领取募集失败时的ETH退款
    function refund(address _token) external returns (bool) {
        require(block.timestamp > presaleTime[_token].endTime, "Presale is ongoing!!!");
        require(totalRaised[_token] < presaleTarget[_token].softCap, "Presale success, please request claim!!!");
        require(buyerBalances[msg.sender][_token] > 0, "Nothing to refund!!!");

        // 安装预售时用户存入的ETH进行退款操作
        (bool success, ) = msg.sender.call{value: buyerBalances[msg.sender][_token]}("");
        require(success, "Refund failed!!!");
        // 记录更新用户存入的ETH余额为0
        buyerBalances[msg.sender][_token] = 0;

        // 抛出退款事件
        emit Refund(_token, msg.sender, buyerBalances[msg.sender][_token]);
        return true;
    }
}
