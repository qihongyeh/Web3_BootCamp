// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract AirdropMerkleNFTMarket {
    address public immutable token;
    address public immutable nft;
    bytes32 public immutable MERKLEROOT;

    mapping(uint256 tokenId => uint256 price) public tokenIdPrice;
    mapping(uint256 tokenId => address seller) public tokenIdSeller;

    event List(uint256 tokenId, uint256 price);
    event PermitPrePay(address indexed from, address indexed to, uint256 value, uint256 deadline);
    event ClaimNFT(address buyer, uint256 tokenId, uint256 price);

    constructor(address _token, address _nft,bytes32 _merkleRoot) {
        token = _token;
        nft = _nft;
        MERKLEROOT = _merkleRoot;
    }

    /**
    ERC721Received
    */
    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return this.onERC721Received.selector;
    }

    // 上架市场售卖，需先对nft的转移进行授权approve
    function list(uint256 _tokenId, uint256 _price) external returns (bool) {
        // 将nft转移至市场
        IERC721(nft).safeTransferFrom(msg.sender, address(this), _tokenId, "");
        // 记录售价
        tokenIdPrice[_tokenId] = _price;
        // 记录卖家
        tokenIdSeller[_tokenId] = msg.sender;

        // 抛出上架事件
        emit List(_tokenId, _price);
        return true;
    }

    function permitPrePay(uint256 _value, uint256 _deadline, uint8 v, bytes32 r, bytes32 s) public returns (bool) {
        // 调用token的permit方法进行授权
        try IERC20Permit(token).permit(msg.sender, address(this), _value, _deadline, v, r, s) {
            
            // 抛出permit授权事件
            emit PermitPrePay(msg.sender, address(this), _value, _deadline);
            return true;
        } catch {
            // 未授权情况下的错误处理
            revert("Permit failed!!!");
        }
    }

    function claimNFT(bytes32[] calldata _merkleProof, uint256 _tokenId, uint256 _price) public returns (bool) {
        // 检查报价是否过低
        require(_price >= tokenIdPrice[_tokenId], "Bid price too low!!!");
        // 检查nft是否已经售卖
        require(IERC721(nft).ownerOf(_tokenId) == address(this), "The nft already sold!!!");

        // 验证购买者是否属于白名单用户
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        bool isWhiteUser = MerkleProof.verify(_merkleProof, MERKLEROOT, leaf);
        // 判断是否是白名单用户
        if (isWhiteUser) {
            // 将token转移给卖家
            IERC20(token).transferFrom(msg.sender, tokenIdSeller[_tokenId], tokenIdPrice[_tokenId] / 2);
            // 将nft转移给买家
            IERC721(nft).transferFrom(address(this), msg.sender, _tokenId);
        } else {
            // 将token转移给卖家
            IERC20(token).transferFrom(msg.sender, tokenIdSeller[_tokenId], tokenIdPrice[_tokenId]);
            // 将nft转移给买家
            IERC721(nft).transferFrom(address(this), msg.sender, _tokenId);
        }
        
        // 抛出领取nft事件
        emit ClaimNFT(msg.sender, _tokenId, _price);
        return true;
    }

    // multicall 调用permitPrePay和claimNFT
    function multicall(bytes[] calldata data) external returns (bytes[] memory results) {
        // 声明一个数组来存储调用返回值
        results = new bytes[](data.length);
        // 遍历传进来的需要去调用的方法字节数组
        for (uint256 i = 0; i < data.length; i++) {
            (bool success, bytes memory result) = address(this).delegatecall(data[i]);
            require(success, "Delegatecall failed");
            results[i] = result;
        }
        return results;
    }
}