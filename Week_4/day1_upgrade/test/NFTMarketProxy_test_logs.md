    ├─ [433068] → new NFTMarketV2@0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395
    │   └─ ← [Return] 2163 bytes of code
    ├─ [0] VM::load(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103) [staticcall]
    │   └─ ← [Return] 0x0000000000000000000000005b0091f49210e7b2a57b03dfe1ab9d08289d9294
    ├─ [3995] ProxyAdmin::upgradeAndCall(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 0x)
    │   ├─ [2477] TransparentUpgradeableProxy::upgradeToAndCall(NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 0x)
    │   │   ├─ emit Upgraded(implementation: NFTMarketV2: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395])
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [956] TransparentUpgradeableProxy::tokenIdPrice(1) [staticcall]
    │   ├─ [508] NFTMarketV2::tokenIdPrice(1) [delegatecall]
    │   │   └─ ← [Return] 10
    │   └─ ← [Return] 10
    ├─ [0] VM::assertEq(10, 10) [staticcall]
    │   └─ ← [Return] 
    ├─ [970] TransparentUpgradeableProxy::tokenIdSeller(1) [staticcall]
    │   ├─ [522] NFTMarketV2::tokenIdSeller(1) [delegatecall]
    │   │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    ├─ [0] VM::assertEq(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [45430] NFTPermit::mint()
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], tokenId: 2)
    │   └─ ← [Return] 2
    ├─ [0] VM::sign("<pk>", 0x732547ecaaeb3eacc542022e0798e10ea6f627198750aaa9457d766ed404d8a9) [staticcall]
    │   └─ ← [Return] 28, 0x4671082702439ed7e915852279f4a58a07724113d4c5cb558b7f547f3f9f57fb, 0x39ea8b9df619b153bdb675706f4cde8e728423b86fb773697f93998248213eb3
    ├─ [62481] TransparentUpgradeableProxy::permitList(2, 20, 28, 0x4671082702439ed7e915852279f4a58a07724113d4c5cb558b7f547f3f9f57fb, 0x39ea8b9df619b153bdb675706f4cde8e728423b86fb773697f93998248213eb3)
    │   ├─ [62012] NFTMarketV2::permitList(2, 20, 28, 0x4671082702439ed7e915852279f4a58a07724113d4c5cb558b7f547f3f9f57fb, 0x39ea8b9df619b153bdb675706f4cde8e728423b86fb773697f93998248213eb3) [delegatecall]
    │   │   ├─ [6736] NFTPermit::permit(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], 2, 20, 28, 0x4671082702439ed7e915852279f4a58a07724113d4c5cb558b7f547f3f9f57fb, 0x39ea8b9df619b153bdb675706f4cde8e728423b86fb773697f93998248213eb3)
    │   │   │   ├─ [3000] PRECOMPILES::ecrecover(0x732547ecaaeb3eacc542022e0798e10ea6f627198750aaa9457d766ed404d8a9, 28, 31861609384795740994936170492499835190280665905439257976941411611152092190715, 26196238183775549809052215875201747106814085073793560449445795767914588094131) [staticcall]
    │   │   │   │   └─ ← [Return] 0x000000000000000000000000dfa97bfe5d2b2e8169b194eaa78fbb793346b174
    │   │   │   ├─ emit ApprovalForAll(owner: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], operator: TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], approved: true)
    │   │   │   └─ ← [Stop] 
    │   │   ├─ [9319] NFTPermit::safeTransferFrom(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], 2, 0x)
    │   │   │   ├─ emit Transfer(from: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], to: TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], tokenId: 2)
    │   │   │   ├─ [1168] TransparentUpgradeableProxy::onERC721Received(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], 2, 0x)
    │   │   │   │   ├─ [699] NFTMarketV2::onERC721Received(TransparentUpgradeableProxy: [0x5991A2dF15A8F6A256D3Ec51E99254Cd3fb576A9], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], 2, 0x) [delegatecall]
    │   │   │   │   │   └─ ← [Return] 0x150b7a0200000000000000000000000000000000000000000000000000000000
    │   │   │   │   └─ ← [Return] 0x150b7a0200000000000000000000000000000000000000000000000000000000
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Return] true
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [956] TransparentUpgradeableProxy::tokenIdPrice(2) [staticcall]
    │   ├─ [508] NFTMarketV2::tokenIdPrice(2) [delegatecall]
    │   │   └─ ← [Return] 20
    │   └─ ← [Return] 20
    ├─ [0] VM::assertEq(20, 20) [staticcall]
    │   └─ ← [Return] 
    ├─ [970] TransparentUpgradeableProxy::tokenIdSeller(2) [staticcall]
    │   ├─ [522] NFTMarketV2::tokenIdSeller(2) [delegatecall]
    │   │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    ├─ [0] VM::assertEq(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 1.91s (1.91s CPU time)

Ran 1 test suite in 3.29s (1.91s CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)