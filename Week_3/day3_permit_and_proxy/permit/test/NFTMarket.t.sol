// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {PermitToken} from "../src/PermitToken.sol";
import {NFTMarket} from "../src/NFTMarket.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract NFTMarketTest is Test {
    MyNFT public myNFT;
    PermitToken public permitToken;
    NFTMarket public nftMarket;

    function setUp() public {
        // 初始化买卖双方
        address seller = makeAddr("seller");
        address buyer = makeAddr("buyer");
        // 初始化买方的token
        vm.prank(buyer);
        permitToken = new PermitToken("MyPermitToken", "MPT");
        // 初始化卖方的nft以及市场
        vm.startPrank(seller);
        myNFT = new MyNFT("MyNFT", "MNFT");
        nftMarket = new NFTMarket(address(permitToken), address(myNFT));
        vm.stopPrank();
    }

    function test_PermitBuy() public {
        // 初始化买卖双方
        (address seller, uint256 sellerKey) = makeAddrAndKey("seller");
        address buyer = makeAddr("buyer");
        vm.startPrank(seller);
        // 铸造nft授权
        uint256 tokenId = myNFT.mint();
        myNFT.approve(address(nftMarket), tokenId);
        // 将nft上架市场并检查确认
        nftMarket.list(1, 10);
        assertEq(nftMarket.tokenIdPrice(tokenId), 10);
        assertEq(nftMarket.tokenIdSeller(tokenId), seller);
        vm.stopPrank();
        /**
         * 链下签名部分 Start************************
         */
        // permit白名单的类型哈希
        bytes32 PERMIT_TYPEHASH = keccak256("Whitelist(address buyer,uint256 tokenId)");
        // 第一层strucHash
        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, buyer, tokenId));
        // 第二层hash
        bytes32 digest = keccak256(abi.encodePacked(structHash));
        // 对数据进行签名
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(sellerKey, digest);
        /**
         * 链下签名部分 Finish************************
         */
        vm.startPrank(buyer);
        // 授权20token
        permitToken.approve(address(nftMarket), 100);
        // 调用permitBuy方法
        nftMarket.permitBuy(10, tokenId, v, r, s);
        vm.stopPrank();
        // 检查nft是否成功购买
        assertEq(myNFT.ownerOf(tokenId), buyer);

        // 未permit情况下的测试
        address buyerNoPermit = makeAddr("buyerNoPermit");
        vm.prank(buyerNoPermit);
        vm.expectRevert();
        nftMarket.permitBuy(10, tokenId, v, r, s);
    }
}
