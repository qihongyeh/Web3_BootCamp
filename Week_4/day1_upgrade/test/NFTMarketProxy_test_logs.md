    ├─ [543175] → new NFTMarketV2@0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395
    │   └─ ← [Return] 2713 bytes of code
    ├─ [0] VM::load(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103) [staticcall]
    │   └─ ← [Return] 0x0000000000000000000000005b0091f49210e7b2a57b03dfe1ab9d08289d9294
    ├─ [3995] ProxyAdmin::upgradeAndCall(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 0x)
    │   ├─ [2477] TransparentUpgradeableProxy::upgradeToAndCall(NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 0x)
    │   │   ├─ emit Upgraded(implementation: NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395])
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [978] TransparentUpgradeableProxy::tokenIdPrice(1) [staticcall]
    │   ├─ [530] NFTMarketV2::tokenIdPrice(1) [delegatecall]
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
    ├─ [0] VM::sign("<pk>", 0xe32f4e5f3622a0489ffc493ed979ad7fb18914546e279d03eec401592c2b2761) [staticcall]
    │   └─ ← [Return] 28, 0x18d679aaf5699d5b9029af33d4a4219df34ff7a9d98a07ef26b6fb9e1a41d5e8, 0x6be1f1ce52a95cbc409420ea78787cc81963528833c284872887db8d0f963c78
    ├─ [60028] TransparentUpgradeableProxy::permitList(2, 20, 28, 0x18d679aaf5699d5b9029af33d4a4219df34ff7a9d98a07ef26b6fb9e1a41d5e8, 0x6be1f1ce52a95cbc409420ea78787cc81963528833c284872887db8d0f963c78)
    │   ├─ [59559] NFTMarketV2::permitList(2, 20, 28, 0x18d679aaf5699d5b9029af33d4a4219df34ff7a9d98a07ef26b6fb9e1a41d5e8, 0x6be1f1ce52a95cbc409420ea78787cc81963528833c284872887db8d0f963c78) [delegatecall]
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0xe32f4e5f3622a0489ffc493ed979ad7fb18914546e279d03eec401592c2b2761, 28, 11234453358204821458767911486835449549959182304074253963512159855589061678568, 48796684271308509493353668232796998185473623326940599752080387214802509249656) [staticcall]
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
    ├─ [978] TransparentUpgradeableProxy::tokenIdPrice(2) [staticcall]
    │   ├─ [530] NFTMarketV2::tokenIdPrice(2) [delegatecall]
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

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 3.04s (3.04s CPU time)

Ran 1 test suite in 12.70s (3.04s CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)