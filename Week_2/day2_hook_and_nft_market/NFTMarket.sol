// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IERC20.sol";
import "./IERC20Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract NFTMarket is IERC721Receiver {

    // 声明nft的报价
    mapping (uint256 tokenId => uint256 price) public tokenIdPrice;
    // 声明nft的出售者
    mapping (uint256 tokenId => address seller) public tokenIdSeller;
    // 声明20token
    address public immutable token;
    // 声明721token
    address public immutable nftToken;


    // 初始化20token和721token
    constructor (address _token, address _nftToken) {
        token = _token;
        nftToken = _nftToken;
    }

    /**
    ERC721Received
    */
    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }


    // 上架售卖 需先对nft的转移进行授权approve
    function list(uint256 tokenId, uint256 amount) external returns (bool) {
        // 将nft转移至市场
        IERC721(nftToken).safeTransferFrom(msg.sender, address(this), tokenId, "");
        // 记录售价
        tokenIdPrice[tokenId] = amount;
        // 记录卖家
        tokenIdSeller[tokenId] = msg.sender;

        return true;
    }

    /**
    *************************本合约buy方法购买NFT*************************
    */
    function buy (uint256 tokenId, uint256 amount) external returns (bool) {
        // 检查报价是否过低
        require(amount >= tokenIdPrice[tokenId], "Bid price too low!");
        // 检查nft是否已经售卖
        require(IERC721(nftToken).ownerOf(tokenId) == address(this), "The nft already sold!");

        // 需先对token的转移进行授权，转移资金给卖家
        IERC20(token).transferFrom(msg.sender, tokenIdSeller[tokenId], tokenIdPrice[tokenId]);
        // nft从市场转移给买家
        IERC721(nftToken).transferFrom(address(this), msg.sender, tokenId);
        return true;
    }

    /**
    *************************ERC20回调函数购买NFT*************************
    */
    function tokensReceivedPlus(address from, uint256 amount, uint256 tokenId) external returns (bool) {
        // 检查报价是否过低
        require(amount >= tokenIdPrice[tokenId], "Bid price too low!");
        // 检查nft是否已经售卖
        require(IERC721(nftToken).ownerOf(tokenId) == address(this), "The nft already sold!");

        // nft从市场转移给买家
        IERC721(nftToken).transferFrom(address(this), from, tokenId);
        return true;
    }


}