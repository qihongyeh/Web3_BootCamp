// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";

import {TokenHook} from "../src/TokenHook.sol";
import {MyNFT} from "../src/MyNFT.sol";
import {NFTMarket} from "../src/NFTMarket.sol";

contract TokenHookNFTTest is Test {

    TokenHook baseERC20;
    MyNFT baseNFT;
    NFTMarket nftMarket;

    function setUp() public {
        baseERC20 = new TokenHook();
        baseNFT = new MyNFT();
        nftMarket = new NFTMarket(address(baseERC20), address(baseNFT));
    }

    function test_tokenHookNFT() public {
        // **********************铸造NFT**********************
        // 声明铸造者与URI
        address minter = address(this);
        string memory tokenURI = "ipfs://QmagmQ3UEvWxqWn6Bk5MaVm1HfwFxXrMC8z6ii9vN9hfUr";
        // 铸造nft
        baseNFT.mint(minter, tokenURI);

        // **********************上架市场测试**********************
        // 声明挂单价和卖家的账户余额
        uint256 testListPrice = 100;
        // 将1号NFT授权给NFTMarket
        baseNFT.approve(address(nftMarket), 1);
        // 对1号NFT进行转移
        nftMarket.list(1, testListPrice);
        // 获取上架的1号NFT的挂单价格和挂单者
        uint256 tokenIdPrice = nftMarket.tokenIdPrice(1);
        address tokenIdSeller = nftMarket.tokenIdSeller(1);
        // 检查真实挂单价与期望挂单价、检查真实挂单者与期望挂单者
        assertEq(tokenIdPrice, testListPrice, "actual price is not equal to test price!!!");
        assertEq(tokenIdSeller, address(this), "actual seller is not equal to test seller!!!");

        // **********************Hook购买测试**********************
        // 声明一个购买者"老六"并转点钱过去
        address lao6 = makeAddr("lao6");
        baseERC20.transfer(lao6, 600);
        
        // 切换签名地址
        vm.startPrank(lao6);
        // 声明要购买的tokenId并编码、声明购买价格
        uint256 tokenId  = 1;
        bytes memory tokenIdBytes = abi.encode(tokenId);
        uint256 bidPrice = 100;
        // 调用ERC20带hook的方法向NFTMarket进行转账
        baseERC20.tokenTransferCallback(address(nftMarket), bidPrice, tokenIdBytes);
        // 获取tokenId为1号的拥有者并进行检查
        address ownerOf = baseNFT.ownerOf(1);
        assertEq(ownerOf, lao6, "Owner of NFT(No.1) is not (lao6)!!!");

        vm.stopPrank();
    }

}