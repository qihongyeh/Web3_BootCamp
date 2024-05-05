// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {PermitToken} from "../src/PermitToken.sol";

contract PermitTokenTest is Test {
    PermitToken public permitToken;

    function setUp() public {
        // 声明token拥有者地址并初始化permitToken
        address owner = makeAddr("owner");
        vm.prank(owner);
        permitToken = new PermitToken("MyPermitToken", "MPT");
    }

    function test_MyPermitToken() public {
        /**
         ************************链下签名部分 Start************************
         */
        // 声明token拥有者及私钥、花费者、数量、拥有者nonce、有效期
        (address owner, uint256 ownerKey) = makeAddrAndKey("owner");
        address spender = makeAddr("spender");
        uint256 value = 10;
        uint256 nonce = permitToken.nonces(owner);
        uint256 deadline = block.timestamp + 1 days;
        // 获取域分隔符
        bytes32 DOMAIN_SEPARATOR = permitToken.DOMAIN_SEPARATOR();
        // permit方法的哈希值
        bytes32 PERMIT_TYPEHASH = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
        // 获取第一层结构数据的哈希
        bytes32 stuctHash = keccak256(abi.encode(
            PERMIT_TYPEHASH,
            owner,
            spender,
            value,
            nonce,
            deadline
        ));
        // 获取第二层结构数据的哈希
        bytes32 digest = keccak256(abi.encodePacked(
            hex"1901",
            DOMAIN_SEPARATOR,
            stuctHash
        ));
        // 对数据进行签名
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerKey, digest);
        /**
         ************************链下签名部分 Finish************************
         */  
        
        // 使用生成的签名对permit方法进行调用
        vm.prank(owner);
        permitToken.permit(owner, spender, value, deadline, v, r, s);

        // 验证授权是否生效
        assertEq(permitToken.allowance(owner, spender), value);
    }
}
