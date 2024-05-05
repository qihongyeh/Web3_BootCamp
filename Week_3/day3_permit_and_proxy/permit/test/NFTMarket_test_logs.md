Ran 1 test for test/NFTMarket.s.sol:NFTMarketTest
[PASS] test_PermitBuy() (gas: 224897)
Traces:
  [2340511] NFTMarketTest::setUp()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    ├─ [0] VM::label(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], "seller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02]
    ├─ [0] VM::label(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], "buyer")
    │   └─ ← [Return] 
    ├─ [0] VM::prank(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02])
    │   └─ ← [Return] 
    ├─ [862395] → new PermitToken@0xca018Fc8B56025933CabBBd5d78f33bA8DA6eA5f
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], value: 100)
    │   └─ ← [Return] 3839 bytes of code
    ├─ [0] VM::startPrank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [877690] → new MyNFT@0xaCF02fa86C7CE8f73725717F69bE6864B09b186d
    │   └─ ← [Return] 4043 bytes of code
    ├─ [445572] → new NFTMarket@0x1b0b9EDba7ADc775B21386882CBA8571b848dA54
    │   └─ ← [Return] 1892 bytes of code
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    └─ ← [Stop] 

  [227678] NFTMarketTest::test_PermitBuy()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    ├─ [0] VM::label(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], "seller")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02]
    ├─ [0] VM::label(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], "buyer")
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [52252] MyNFT::mint()
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], tokenId: 1)
    │   └─ ← [Return] 1
    ├─ [25052] MyNFT::approve(NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], 1)
    │   ├─ emit Approval(owner: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], approved: NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], tokenId: 1)
    │   └─ ← [Stop] 
    ├─ [78219] NFTMarket::list(1, 10)
    │   ├─ [30963] MyNFT::safeTransferFrom(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], 1, 0x)
    │   │   ├─ emit Transfer(from: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], to: NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], tokenId: 1)
    │   │   ├─ [686] NFTMarket::onERC721Received(NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], 1, 0x)
    │   │   │   └─ ← [Return] 0x150b7a0200000000000000000000000000000000000000000000000000000000
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] true
    ├─ [508] NFTMarket::tokenIdPrice(1) [staticcall]
    │   └─ ← [Return] 10
    ├─ [0] VM::assertEq(10, 10) [staticcall]
    │   └─ ← [Return] 
    ├─ [522] NFTMarket::tokenIdSeller(1) [staticcall]
    │   └─ ← [Return] seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]
    ├─ [0] VM::assertEq(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::sign("<pk>", 0x67322fa2c99c6abf0c5c6db517b527a6c5abc1e431593742b74bb1c0230e6080) [staticcall]
    │   └─ ← [Return] 27, 0x37320cff75064ff8d857bec0cb08126a4809945efc3041fec0f579d99ad67bee, 0x0b4e67dcd69b3043dc07d62fdfee070825836d9d8313f3c05da3833b654ddee9
    ├─ [0] VM::startPrank(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02])
    │   └─ ← [Return] 
    ├─ [24739] PermitToken::approve(NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], 100)
    │   ├─ emit Approval(owner: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], spender: NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], value: 100)
    │   └─ ← [Return] true
    ├─ [68236] NFTMarket::permitBuy(10, 1, 27, 0x37320cff75064ff8d857bec0cb08126a4809945efc3041fec0f579d99ad67bee, 0x0b4e67dcd69b3043dc07d62fdfee070825836d9d8313f3c05da3833b654ddee9)
    │   ├─ [3000] PRECOMPILES::ecrecover(0x67322fa2c99c6abf0c5c6db517b527a6c5abc1e431593742b74bb1c0230e6080, 27, 24965638733385267079379198934447901526428679217575145125071391874933253897198, 5113972239131301728679433871197687264396894789516135140998664353445409840873) [staticcall]
    │   │   └─ ← [Return] 0x000000000000000000000000dfa97bfe5d2b2e8169b194eaa78fbb793346b174
    │   ├─ [576] MyNFT::ownerOf(1) [staticcall]
    │   │   └─ ← [Return] NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54]
    │   ├─ [30862] PermitToken::transferFrom(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], 10)
    │   │   ├─ emit Transfer(from: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], to: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], value: 10)
    │   │   └─ ← [Return] true
    │   ├─ [26359] MyNFT::transferFrom(NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 1)
    │   │   ├─ emit Transfer(from: NFTMarket: [0x1b0b9EDba7ADc775B21386882CBA8571b848dA54], to: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], tokenId: 1)
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [576] MyNFT::ownerOf(1) [staticcall]
    │   └─ ← [Return] buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02]
    ├─ [0] VM::assertEq(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02]) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] buyerNoPermit: [0xC22fD71ec5BdFe169421b7DABD0A0172097c326D]
    ├─ [0] VM::label(buyerNoPermit: [0xC22fD71ec5BdFe169421b7DABD0A0172097c326D], "buyerNoPermit")
    │   └─ ← [Return] 
    ├─ [0] VM::prank(buyerNoPermit: [0xC22fD71ec5BdFe169421b7DABD0A0172097c326D])
    │   └─ ← [Return] 
    ├─ [0] VM::expectRevert(custom error f4844814:)
    │   └─ ← [Return] 
    ├─ [4281] NFTMarket::permitBuy(10, 1, 27, 0x37320cff75064ff8d857bec0cb08126a4809945efc3041fec0f579d99ad67bee, 0x0b4e67dcd69b3043dc07d62fdfee070825836d9d8313f3c05da3833b654ddee9)
    │   ├─ [3000] PRECOMPILES::ecrecover(0x414f35428772f7fd8636207c81b5bbbd01e8a83c4c60db8936a87ca1ae00f250, 27, 24965638733385267079379198934447901526428679217575145125071391874933253897198, 5113972239131301728679433871197687264396894789516135140998664353445409840873) [staticcall]
    │   │   └─ ← [Return] 0x0000000000000000000000002aeff8ae1cc265db86b56a219a1a364639dfa93d
    │   └─ ← [Revert] revert: Invalid signature
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 1.52ms (875.46µs CPU time)

Ran 1 test suite in 1.97s (1.52ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)