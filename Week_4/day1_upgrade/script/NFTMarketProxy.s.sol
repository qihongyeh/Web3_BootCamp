// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/NFTMarketV1.sol";
import "../src/NFTMarketV2.sol";
import "../src/NFTPermit.sol";
import "../src/Token.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract NFTMarketProxy is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        // 部署20与721
        Token token = new Token("MyToken", "MT");
        NFTPermit nftPermit = new NFTPermit("MyNFT", "MNFT");

        // 部署代理合约与实现合约v1版本
        address proxy = Upgrades.deployTransparentProxy(
            "NFTMarketV1.sol:NFTMarketV1",
            msg.sender,
            abi.encodeCall(NFTMarketV1.initialize, (address(token), address(nftPermit)))
        );

        // 升级实现合约至v2版本
        Upgrades.upgradeProxy(
            proxy,
            "NFTMarketV2.sol:NFTMarketV2",
            "");

        vm.stopBroadcast();
    }
}
