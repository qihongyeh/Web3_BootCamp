// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.25;

import {Script, console} from "forge-std/Script.sol";
import "../src/MyToken.sol";

contract MyTokenScript is Script {
    function setUp() public {}

    function run() public {
        // 获取私钥
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        // 签名广播
        vm.startBroadcast(privateKey);
        // 创建合约
        MyToken MyTokenContract = new MyToken("MyToken", "MT");
        // 打印日志
        console.log("Contract 'MyToken' Deploying!", address(MyTokenContract));
        // 广播结束
        vm.stopBroadcast();
    }
}
