   ├─ [454286] → new NFTMarketV2@0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395
    │   └─ ← [Return] 2269 bytes of code
    ├─ [0] VM::load(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103) [staticcall]
    │   └─ ← [Return] 0x0000000000000000000000005b0091f49210e7b2a57b03dfe1ab9d08289d9294
    ├─ [3995] ProxyAdmin::upgradeAndCall(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 0x)
    │   ├─ [2477] TransparentUpgradeableProxy::upgradeToAndCall(NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 0x)
    │   │   ├─ emit Upgraded(implementation: NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395])
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [889] TransparentUpgradeableProxy::tokenIdPrice(1) [staticcall]
    │   ├─ [441] NFTMarketV2::tokenIdPrice(1) [delegatecall]
    │   │   └─ ← [Return] 10
    │   └─ ← [Return] 10
    ├─ [0] VM::assertEq(10, 10) [staticcall]
    │   └─ ← [Return] 
    ├─ [992] TransparentUpgradeableProxy::tokenIdSeller(1) [staticcall]
    │   ├─ [544] NFTMarketV2::tokenIdSeller(1) [delegatecall]
    │   │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    ├─ [0] VM::assertEq(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [45452] NFT::mint()
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], tokenId: 2)
    │   └─ ← [Return] 2
    ├─ [0] VM::sign("<pk>", 0x8191fc9ebeefc98d6899d2751ccbd4e7b889e6bfda132ab2247cf173564b90fe) [staticcall]
    │   └─ ← [Return] 27, 0x05417c4edc95ce81cb858604c0a756d3f05b01a0c1097b180bc7c911be841eeb, 0x6698e7ffdedefbf6e52af686dd981ea250451e45cdb97956563260a1f51889c6
    ├─ [58876] TransparentUpgradeableProxy::permitList(2, 20, 27, 0x05417c4edc95ce81cb858604c0a756d3f05b01a0c1097b180bc7c911be841eeb, 0x6698e7ffdedefbf6e52af686dd981ea250451e45cdb97956563260a1f51889c6)
    │   ├─ [58407] NFTMarketV2::permitList(2, 20, 27, 0x05417c4edc95ce81cb858604c0a756d3f05b01a0c1097b180bc7c911be841eeb, 0x6698e7ffdedefbf6e52af686dd981ea250451e45cdb97956563260a1f51889c6) [delegatecall]
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x8191fc9ebeefc98d6899d2751ccbd4e7b889e6bfda132ab2247cf173564b90fe, 27, 2377267244780100046765452775958029691863197853564560381811377314773460066027, 46406072511003053920410107621325877984859125428602075865065438424087544760774) [staticcall]
    │   │   │   └─ ← [Return] 0x000000000000000000000000dfa97bfe5d2b2e8169b194eaa78fbb793346b174
    │   │   ├─ [9328] NFT::safeTransferFrom(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], 2, 0x)
    │   │   │   ├─ emit Transfer(from: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], to: TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], tokenId: 2)
    │   │   │   ├─ [1155] TransparentUpgradeableProxy::onERC721Received(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], 2, 0x)
    │   │   │   │   ├─ [686] NFTMarketV2::onERC721Received(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], 2, 0x) [delegatecall]
    │   │   │   │   │   └─ ← [Return] 0x150b7a0200000000000000000000000000000000000000000000000000000000
    │   │   │   │   └─ ← [Return] 0x150b7a0200000000000000000000000000000000000000000000000000000000
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Return] true
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [889] TransparentUpgradeableProxy::tokenIdPrice(2) [staticcall]
    │   ├─ [441] NFTMarketV2::tokenIdPrice(2) [delegatecall]
    │   │   └─ ← [Return] 20
    │   └─ ← [Return] 20
    ├─ [0] VM::assertEq(20, 20) [staticcall]
    │   └─ ← [Return] 
    ├─ [992] TransparentUpgradeableProxy::tokenIdSeller(2) [staticcall]
    │   ├─ [544] NFTMarketV2::tokenIdSeller(2) [delegatecall]
    │   │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    ├─ [0] VM::assertEq(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 2.76s (2.76s CPU time)

Ran 1 test suite in 4.73s (2.76s CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)