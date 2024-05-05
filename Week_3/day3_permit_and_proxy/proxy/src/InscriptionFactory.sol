// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "../src/InscriptionToken.sol";

contract InscriptionFactory {
    // 初始化相关的变量
    using Clones for address;
    address public implementation;
    address public factoryOwner;
    address public creator;
    mapping(address token => bool isDeployed) public deployedTokens;

    constructor() {
        implementation = address(new InscriptionToken());
        factoryOwner = msg.sender;
    }

    // 通过克隆部署token合约
    function deployInscription(uint256 totalSupply, uint256 perMint, uint256 price) external returns (address) {
        address clone = implementation.clone();
        InscriptionToken(clone).initialize(totalSupply, perMint, price, msg.sender, factoryOwner);
        deployedTokens[clone] = true;

        return clone;
    }

    // 铸造已经部署的token
    function mintInscription(address tokenAddr) external payable returns (bool) {
        require(deployedTokens[tokenAddr], "Invalid token!!!");
        InscriptionToken token = InscriptionToken(tokenAddr);
        token.mint{value: msg.value}(msg.sender);

        return true;
    }
}
