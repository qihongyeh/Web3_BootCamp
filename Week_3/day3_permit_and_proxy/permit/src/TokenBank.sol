// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

interface IERC20 {
    // 普通转账接口
    function transfer(address to, uint256 value) external returns (bool);
    // 授权转账接口
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

interface IERC20Permit {
    // Permit接口
    function permit(address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s)
        external;
}

contract TokenBank {
    // 初始化银行账目表
    mapping(address depositor => mapping(address token => uint256 value)) public bankBalances;

    // 预授权的存款方法
    function deposit(address token, uint256 value) public returns (bool) {
        // 调用token合约的授权转账方法
        IERC20(token).transferFrom(msg.sender, address(this), value);
        // 加计银行账目表
        bankBalances[msg.sender][token] += value;

        return true;
    }

    // permit存款方法
    function permitDeposit(address token, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s)
        public
        returns (bool)
    {
        // 调用token的permit方法进行授权
        try IERC20Permit(token).permit(msg.sender, address(this), value, deadline, v, r, s) {
            // 调用token的授权转账
            IERC20(token).transferFrom(msg.sender, address(this), value);
            // 加计银行账目表
            bankBalances[msg.sender][token] += value;

            return true;
        } catch {
            // 未授权情况下的错误处理
            revert("Permit failed!!!");
        }
    }

    // 提款方法
    function withdraw(address token, uint256 value) public returns (bool) {
        // 检查存款人余额是否足够
        require(bankBalances[msg.sender][token] >= value, "Your bank account amount is less than transfer amount!");
        // 调用token合约的普通转账方法
        IERC20(token).transfer(msg.sender, value);
        // 减计银行账目表
        bankBalances[msg.sender][token] -= value;

        return true;
    }
}
