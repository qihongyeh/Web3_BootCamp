// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 导入接口
import "./IERC20.sol";
import "./IERC20Receiver.sol";

contract BaseERC20 {

    // 声明token的名字
    string public name;
    // 声明token的符号
    string public symbol;
    // 声明token的小数位数
    uint8 public decimals;
    // 声明token的总供应量
    uint256 public totalSupply;    
    // 使用映射类型进行token归属的记账
    mapping (address account => uint256 value) public balances;
    // 使用嵌套映射类型来对某个账户地址的授权对象及数量进行记录
    mapping (address account => mapping (address spender => uint256 value)) public allowances;

    // 转账事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    // 授权事件
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 构造函数，合约部署时传入token的名字、符号、小数位数、总供应量
    constructor() {
        name = "BaseERC20";
        symbol = "BERC20";
        decimals = 18;
        totalSupply = 100000000 * 10 ** 18;
        // 将所有供应的token转入合约创建者的账户余额
        balances[msg.sender] = totalSupply;
    }

    // 返回地址账户的token余额
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    // 转账
    function transfer(address to, uint256 value) public returns (bool) {
        // 检查余额是否满足本次转账的金额
        require(balances[msg.sender] >= value, "ERC20: transfer amount exceeds baview aview aview alance");
        
        // 减计转出账户的数量
        balances[msg.sender] -= value;
        // 加计转入账户的数量
        balances[to] += value;

        // 触发事件，进行记录
        emit Transfer(msg.sender, to, value);
        // 若转账成功，返回true
        return true;
    }

    // 仅转账 callback
    function tokenTransferCallback(address to, uint256 amount) public returns (bool) {

        transfer(to, amount);

        if (to.code.length > 0) {
            bool res = IERC20Receiver(to).tokensReceived(msg.sender, amount);
            require(res, "Send message failed!");
        }

        return true;
    }

    // 购买nft callback
    function buyNFTTransferCallback(address to, uint256 amount, uint256 tokenId) public returns (bool) {

        transfer(to, amount);

        if (to.code.length > 0) {
            bool res = IERC20Receiver(to).tokensReceivedPlus(msg.sender, amount, tokenId);
            require(res, "Send message failed!");
        }

        return true;
    }

    // 授权
    function approve(address spender, uint256 value) public returns (bool) {
        // 对授权的金额进行记录
        allowances[msg.sender][spender] = value;

        // 触发授权的事件
        emit Approval(msg.sender, spender, value);
        // 若授权成功，返回true
        return true;
    }

    // 授权余额
    function allowance(address owner, address spender) public view returns (uint256) {

        // 返回当前授权余额
        return allowances[owner][spender];
    }

    // 授权转账
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        // 检查转账的账户余额是否足够
        require(balances[from] >= value, "ERC20: transfer amount exceeds balance");
        // 检查转账的账户授权余额是否足够
        require(allowances[from][msg.sender] >= value, "ERC20: transfer amount exceeds allowance");
        // 更新账户余额
        balances[from] -= value;
        balances[to] += value;
        // 更新授权余额
        allowances[from][msg.sender] -= value;

        // 触发转账事件
        emit Transfer(from, to, value);
        // 若授权转账成功，返回true
        return true;
    }

}