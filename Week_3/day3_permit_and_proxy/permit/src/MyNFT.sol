// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {

    uint256 public tokenIds = 1;
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    function mint() public returns (uint256) {
        uint256 newItemId = tokenIds;
        _mint(msg.sender, newItemId);
        tokenIds++;

        return newItemId;
    }
}
