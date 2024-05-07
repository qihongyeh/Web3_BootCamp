// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTPermit is ERC721 {
    uint256 public tokenIds = 1;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function mint() public returns (uint256) {
        uint256 newItemId = tokenIds;
        _mint(msg.sender, newItemId);
        tokenIds++;

        return newItemId;
    }

    function permit(address owner, address operator, uint256 tokenId, uint256 price, uint8 v, bytes32 r, bytes32 s) public {
        // permit全部授权的类型
        bytes32 PERMIT_TYPEHASH = keccak256("Permit(address owner,address operator,uint256 tokenId,uint256 price)");
        // 第一层structHash
        bytes32 structHash = keccak256(abi.encode(PERMIT_TYPEHASH, owner, operator, tokenId, price));
        // 第二层hash
        bytes32 digest = keccak256(abi.encodePacked(structHash));
        // 恢复签名信息
        address signer = ecrecover(digest, v, r, s);
        // 检验签名人是否为owner
        if (signer != owner) {
            revert("Invalid signer!!!");
        }

        // 授权全部nft给operator
        _setApprovalForAll(owner, operator, true);
    }
}
