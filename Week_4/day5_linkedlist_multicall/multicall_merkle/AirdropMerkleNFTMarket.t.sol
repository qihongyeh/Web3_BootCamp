// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../src/AirdropMerkleNFTMarket.sol";

contract MyToken is ERC20Permit {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) ERC20Permit(name) {
        _mint(msg.sender, 100);
    }
}

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

contract AirdropMerkleNFTMarketTest is Test {
    MyToken public token;
    MyNFT public nft;
    AirdropMerkleNFTMarket public market;
    address public seller = makeAddr("seller");
    address public buyer;
    uint256 public buyerKey;

    /**
     * @notice root:0x8c45324dfdb758b49298dd9d54a562dc9cbed8fb7c87bc3b7a8375a5fbb8d481
     *         proof:0x72155ab19f64defdca605292f85d05e62580c41852b1bff9f02bd9cf4c4ac1ee,0x66af34d373b909013012f47c2e8fcf962ed49c30d72ed525b8867e5fb5f9acbd
     */

    // ts文件生产root
    bytes32 public immutable MERKLEROOT = 0x8c45324dfdb758b49298dd9d54a562dc9cbed8fb7c87bc3b7a8375a5fbb8d481;
    bytes32[] public merkleProof;

    function setUp() public {
        (buyer, buyerKey) = makeAddrAndKey("buyer");
        console.log("buyer: ", buyer);
        console.log("buyerKey: ", buyerKey);
        vm.startPrank(seller);
        token = new MyToken("MyToken", "MT");
        nft = new MyNFT("MyNFT", "MNFT");
        market = new AirdropMerkleNFTMarket(address(token), address(nft), MERKLEROOT);
        token.transfer(buyer, 100);
        nft.mint();
        nft.approve(address(market), 1);
        market.list(1, 10);
        vm.stopPrank();

        // ts文件生成proof
        merkleProof.push(0x72155ab19f64defdca605292f85d05e62580c41852b1bff9f02bd9cf4c4ac1ee);
        merkleProof.push(0x66af34d373b909013012f47c2e8fcf962ed49c30d72ed525b8867e5fb5f9acbd);
    }

    // 测试正常流程
    function test_AirdropMerkleNFTMarket() public {
        // 买家签名permit
        // 声明token花费者、数量、拥有者nonce、有效期
        address spender = address(market);
        uint256 value = 10;
        uint256 nonce = token.nonces(buyer);
        uint256 deadline = block.timestamp + 1 days;
        // 获取域分隔符
        bytes32 DOMAIN_SEPARATOR = token.DOMAIN_SEPARATOR();
        // permit方法的哈希值
        bytes32 PERMIT_TYPEHASH =
            keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
        // 获取第一层结构数据的哈希
        bytes32 stuctHash = keccak256(abi.encode(PERMIT_TYPEHASH, buyer, spender, value, nonce, deadline));
        // 获取第二层结构数据的哈希
        bytes32 digest = keccak256(abi.encodePacked(hex"1901", DOMAIN_SEPARATOR, stuctHash));
        // 对数据进行签名
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(buyerKey, digest);

        // 买家调用multicall
        // 封装permitPrePay函数与参数
        bytes memory permitCall = abi.encodeWithSelector(
            market.permitPrePay.selector,
            value,
            deadline,
            v,
            r,
            s
        );
        // 封装claimNFT函数与参数
        bytes memory claimCall = abi.encodeWithSelector(
            market.claimNFT.selector,
            merkleProof,
            1,
            10
        );
        // 将两个call组成一个数组
        bytes[] memory calls = new bytes[](2);
        calls[0] = permitCall;
        calls[1] = claimCall;
        // 调用multicall
        vm.prank(buyer);
        market.multicall(calls);
        // 检查执行结果是否符合预期
        assertEq(nft.ownerOf(1), buyer);
        assertEq(token.balanceOf(seller), 5);
    }
}