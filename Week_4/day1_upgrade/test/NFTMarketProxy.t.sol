// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/NFTMarketV1.sol";
import "../src/NFTMarketV2.sol";
import "../src/NFTPermit.sol";
import "../src/Token.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract NFTMarketProxyTest is Test {
    Token public token;
    NFTPermit public nftPermit;
    NFTMarketV1 public v1;
    NFTMarketV2 public v2;
    address public admin;
    address public seller;
    uint256 public sellerKey;

    function setUp() public {
        // 初始化变量
        admin = makeAddr("admin");
        (seller, sellerKey) = makeAddrAndKey("seller");
        // 部署token和nftPermit
        token = new Token("MyToken", "MT");
        nftPermit = new NFTPermit("MyNFT", "MNFT");
    }

    function testUpgradeToV2() public {
        uint256 tokenId = 1;
        uint256 nftPrice = 10;

        address proxy = Upgrades.deployTransparentProxy(
            "NFTMarketV1.sol:NFTMarketV1",
            admin,
            abi.encodeCall(NFTMarketV1.initialize, (address(token), address(nftPermit)))
        );
        // 通过代理地址获取v1的实例
        v1 = NFTMarketV1(proxy);
        // v1版本铸造NFT并上架Market
        vm.startPrank(seller);
        nftPermit.mint();
        nftPermit.setApprovalForAll(address(v1), true);
        v1.list(tokenId, nftPrice);
        vm.stopPrank();

        // 检查v1中的状态
        assertEq(v1.tokenIdPrice(tokenId), nftPrice);
        assertEq(v1.tokenIdSeller(tokenId), seller);

        // 升级合约至v2
        vm.startPrank(admin);
        Upgrades.upgradeProxy(proxy, "NFTMarketV2.sol:NFTMarketV2", "");
        vm.stopPrank();

        // 通过代理地址获取v2的实例
        v2 = NFTMarketV2(proxy);
        // 检查v2中的状态
        assertEq(v2.tokenIdPrice(tokenId), nftPrice);
        assertEq(v2.tokenIdSeller(tokenId), seller);

        // 开始测试v2中的permitList功能
        vm.startPrank(seller);
        nftPermit.mint();
        uint256 tokenId2 = 2;
        uint256 nftPrice2 = 20;
        // 使用离线签名授权NFT
        bytes32 digest = keccak256(
            abi.encodePacked(
                keccak256(
                    abi.encode(
                        keccak256("Permit(address owner,address operator,uint256 tokenId,uint256 price)"),
                        seller,
                        address(v2),
                        tokenId2,
                        nftPrice2
                    )
                )
            )
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(sellerKey, digest);

        // 调用v2的permitList方法
        v2.permitList(tokenId2, nftPrice2, v, r, s);
        vm.stopPrank();

        // 检查v2的permitList后的状态
        assertEq(v2.tokenIdPrice(tokenId2), nftPrice2);
        assertEq(v2.tokenIdSeller(tokenId2), seller);
    }
}
