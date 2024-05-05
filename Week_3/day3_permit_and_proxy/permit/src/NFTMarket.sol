// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract NFTMarket {
    // 声明nft挂单价的映射
    mapping(uint256 tokenId => uint256 price) public tokenIdPrice;
    // 声明nft挂单者的映射
    mapping(uint256 tokenId => address seller) public tokenIdSeller;
    // 声明permitToken
    address public permitToken;
    // 声明nftToken
    address public nftToken;
    // 白名单签名人
    address public whiteListSigner;

    // 初始化permitToken和nftToken
    constructor(address _permitToken, address _nftToken) {
        permitToken = _permitToken;
        nftToken = _nftToken;
        whiteListSigner = msg.sender;
    }

    // IERC721Receiver
    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }

    // 上架市场售卖 需先对nft的转移进行授权approve
    function list(uint256 tokenId, uint256 price) external returns (bool) {
        // 将nft转移至市场
        IERC721(nftToken).safeTransferFrom(msg.sender, address(this), tokenId, "");
        // 记录售价
        tokenIdPrice[tokenId] = price;
        // 记录卖家
        tokenIdSeller[tokenId] = msg.sender;

        return true;
    }

    function permitBuy(uint256 price, uint256 tokenId, uint8 v, bytes32 r, bytes32 s) external returns (bool) {
        // permit白名单的类型哈希
        bytes32 PERMIT_TYPEHASH = keccak256("Whitelist(address buyer,uint256 tokenId)");
        // 第一层strucHash
        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, msg.sender, tokenId));
        // 第二层hash
        bytes32 digest = keccak256(abi.encodePacked(structHash));
        // 检查购买者是否为白名单用户
        require(ecrecover(digest, v, r, s) == whiteListSigner, "Invalid signature");

        // 检查报价是否过低
        require(price >= tokenIdPrice[tokenId], "Bid price too low!");
        // 检查nft是否已经售卖
        require(IERC721(nftToken).ownerOf(tokenId) == address(this), "The nft already sold!");
        // 需先对token的转移进行授权，转移资金给卖家
        IERC20(permitToken).transferFrom(msg.sender, tokenIdSeller[tokenId], tokenIdPrice[tokenId]);
        // nft从市场转移给买家
        IERC721(nftToken).transferFrom(address(this), msg.sender, tokenId);

        return true;
    }
}
