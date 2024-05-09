// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/NFTMarketV1.sol";
import "../src/NFTMarketV2.sol";
import "../src/NFT.sol";
import "../src/Token.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";

contract NFTMarketProxyTest is Test {
    Token public token;
    NFT public nft;
    NFTMarketV1 public v1;
    NFTMarketV2 public v2;
    address public admin;
    address public seller;
    uint256 public sellerKey;

    struct EIP712Domain {
        string name;
        string version;
        uint256 chainId;
        address verifyingContract;
    }

    struct List {
        uint256 tokenId2;
        uint256 nftPrice2;
    }

    bytes32 public constant EIP712DOMAIN_TYPEHASH = 
        keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");

    bytes32 public constant PERMITLIST_TYPEHASH =
        keccak256("PermitList(uint256 tokenId2,nftPrice2)");


    function setUp() public {
        // 初始化变量
        admin = makeAddr("admin");
        (seller, sellerKey) = makeAddrAndKey("seller");
        // 部署token和nftPermit
        token = new Token("MyToken", "MT");
        nft = new NFT("MyNFT", "MNFT");
    }

    function testUpgradeToV2() public {
        uint256 tokenId = 1;
        uint256 nftPrice = 10;

        address proxy = Upgrades.deployTransparentProxy(
            "NFTMarketV1.sol:NFTMarketV1",
            admin,
            abi.encodeCall(NFTMarketV1.initialize, (address(token), address(nft)))
        );
        // 通过代理地址获取v1的实例
        v1 = NFTMarketV1(proxy);
        // v1版本铸造NFT并上架Market
        vm.startPrank(seller);
        nft.mint();
        nft.setApprovalForAll(address(v1), true);
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
        nft.mint();

        // *****************712签名系列*****************
        EIP712Domain memory eip712Domain = EIP712Domain({
            name: "NFTMarketV2",
            version: "1",
            chainId: block.chainid,
            verifyingContract: address(v2)
        });

        bytes32 DOMAIN_SEPARATOR = keccak256(abi.encode(
            EIP712DOMAIN_TYPEHASH,
            eip712Domain.name,
            eip712Domain.version,
            eip712Domain.chainId,
            eip712Domain.verifyingContract
        ));

        List memory list = List({
            tokenId2: 2,
            nftPrice2: 20
        });

        bytes32 structHash = keccak256(abi.encode(
            PERMITLIST_TYPEHASH,
            list.tokenId2,
            list.nftPrice2
        ));

        bytes32 digest = keccak256(abi.encodePacked(
            "\x19\x01",
            DOMAIN_SEPARATOR,
            structHash
        ));

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(sellerKey, digest);

        // 调用v2的permitList方法
        v2.permitList(list.tokenId2, list.nftPrice2, v, r, s);
        vm.stopPrank();

        // 检查v2的permitList后的状态
        assertEq(v2.tokenIdPrice(list.tokenId2), list.nftPrice2);
        assertEq(v2.tokenIdSeller(list.tokenId2), seller);

        
    }
}
