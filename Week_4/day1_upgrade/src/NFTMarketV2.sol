// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

// interface IERC721Permit{
//     function permit(address owner, address operator, uint256 tokenId, uint256 price, uint8 v, bytes32 r, bytes32 s)
//         external;
// }

/// @custom:oz-upgrades-from NFTMarketV1
contract NFTMarketV2 is Initializable {
    // 声明nft的挂单价
    mapping(uint256 tokenId => uint256 price) public tokenIdPrice;
    // 声明nft的挂单者
    mapping(uint256 tokenId => address seller) public tokenIdSeller;
    // 声明token
    address public token;
    // 声明nft
    address public nft;

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

    // // 初始化token与nft
    // constructor(address _token, address _nftToken) {
    //     token = _token;
    //     nftToken = _nftToken;
    // }

    // 代理合约部署时的初始化
    function initialize(address _token, address _nft)  public initializer {
        token = _token;
        nft  = _nft;
    }

    // ERC721Received
    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }

    // 出售nft，首次签名进行用户setApprovalForAll, 后续离线签名上架
    function permitList(uint256 tokenId, uint256 nftPrice, uint8 v, bytes32 r, bytes32 s) external returns (bool) {
        EIP712Domain memory eip712Domain = EIP712Domain({
            name: "NFTMarketV2",
            version: "1",
            chainId: block.chainid,
            verifyingContract: address(this)
        });

        bytes32 DOMAIN_SEPARATOR = keccak256(abi.encode(
            EIP712DOMAIN_TYPEHASH,
            eip712Domain.name,
            eip712Domain.version,
            eip712Domain.chainId,
            eip712Domain.verifyingContract
        ));

        List memory list = List({
            tokenId2: tokenId,
            nftPrice2: nftPrice
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
        // 恢复签名信息
        address signer = ecrecover(digest, v, r, s);
        // 检查签名人是否为消息发送者
        if (signer != msg.sender) {
            revert("Invalid signer!!!");
            }

        // 转移nft至市场中
        IERC721(nft).safeTransferFrom(msg.sender, address(this), tokenId, "");
        // 记录挂单价
        tokenIdPrice[tokenId] = nftPrice;
        // 记录挂单者
        tokenIdSeller[tokenId] = msg.sender;

        return true;
    }

    // 购买nft，但需要先对token的转移进行授权
    function buy(uint256 tokenId, uint256 price) external returns (bool) {
        // 检查报价是否过低
        require(price >= tokenIdPrice[tokenId], "Bid price too low!!!");
        // 检查nft是否已经售卖
        require(IERC721(nft).ownerOf(tokenId) == address(this), "The nft already sold!!!");
        // 将token转移给卖家
        IERC20(token).transferFrom(msg.sender, tokenIdSeller[tokenId], tokenIdPrice[tokenId]);
        // 将nft转移给买家
        IERC721(nft).transferFrom(address(this), msg.sender, tokenId);

        return true;
    }
}
