// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

interface IERC721Permit{
    function permit(address owner, address operator, uint256 tokenId, uint256 price, uint8 v, bytes32 r, bytes32 s)
        external;
}

/// @custom:oz-upgrades-from NFTMarketV1
contract NFTMarketV2 is Initializable  {
    // 声明nft的挂单价
    mapping(uint256 tokenId => uint256 price) public tokenIdPrice;
    // 声明nft的挂单者
    mapping(uint256 tokenId => address seller) public tokenIdSeller;
    // 声明token
    address public token;
    // 声明nft
    address public nftToken;

    // // 初始化token与nft
    // constructor(address _token, address _nftToken) {
    //     token = _token;
    //     nftToken = _nftToken;
    // }

    // 代理合约部署时的初始化
    function initialize(address _token, address _nftToken) public initializer {
        token = _token;
        nftToken  = _nftToken;
    }

    // ERC721Received
    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }

    // 出售nft，离线签名后无需授权
    function permitList(uint256 tokenId, uint256 price, uint8 v, bytes32 r, bytes32 s) external returns (bool) {
        // 通过nft的permit接口进行验证签名和授权
        try IERC721Permit(nftToken).permit(msg.sender, address(this), tokenId, price, v, r, s) {
            // 转移nft至市场中
            IERC721(nftToken).safeTransferFrom(msg.sender, address(this), tokenId, "");
            // 记录挂单价
            tokenIdPrice[tokenId] = price;
            // 记录挂单者
            tokenIdSeller[tokenId] = msg.sender;

            return true;
        } catch {
            // 未授权情况下的错误处理
            revert("Permit failed!!!");
        }
    }

    // 购买nft，但需要先对token的转移进行授权
    function buy(uint256 tokenId, uint256 price) external returns (bool) {
        // 检查报价是否过低
        require(price >= tokenIdPrice[tokenId], "Bid price too low!!!");
        // 检查nft是否已经售卖
        require(IERC721(nftToken).ownerOf(tokenId) == address(this), "The nft already sold!!!");
        // 将token转移给卖家
        IERC20(token).transferFrom(msg.sender, tokenIdSeller[tokenId], tokenIdPrice[tokenId]);
        // 将nft转移给买家
        IERC721(nftToken).transferFrom(address(this), msg.sender, tokenId);

        return true;
    }
}
