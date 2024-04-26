// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage {
    uint256 public _tokenIds = 1;

    constructor() ERC721("BaseNFT", "BNFT") {}

    // ipfs://QmagmQ3UEvWxqWn6Bk5MaVm1HfwFxXrMC8z6ii9vN9hfUr
    function mint(address user, string memory tokenURI) public returns (uint256) {
        uint256 newItemId = _tokenIds;
        _mint(user, newItemId);
        _setTokenURI(newItemId, tokenURI);
        _tokenIds++;

        return newItemId;
    }
}