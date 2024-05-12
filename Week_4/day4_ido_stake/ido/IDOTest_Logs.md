Ran 4 tests for test/IDO.t.sol:IDOTest
[PASS] testFail_IDOReplay() (gas: 373794)
Traces:
  [333994] IDOTest::testFail_IDOReplay()
    ├─ [0] VM::startPrank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [46728] MyToken::mint(100)
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], value: 100)
    │   └─ ← [Stop] 
    ├─ [25188] MyToken::transfer(IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 100)
    │   ├─ emit Transfer(from: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], to: IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 100)
    │   └─ ← [Return] true
    ├─ [158632] IDO::addIDO(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 1000000000000000000 [1e18], 100, 100000000000000000000 [1e20], 200000000000000000000 [2e20], 1, 604801 [6.048e5])
    │   ├─ emit NewIDO(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], amount: 100, softCap: 100000000000000000000 [1e20], hardCap: 200000000000000000000 [2e20], startTime: 1, endTime: 604801 [6.048e5])
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::deal(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 100000000000000000000 [1e20])
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02])
    │   └─ ← [Return] 
    ├─ [47586] IDO::presale{value: 100000000000000000000}(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ emit Presale(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], buyer: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], value: 100000000000000000000 [1e20])
    │   └─ ← [Return] true
    ├─ [0] VM::warp(691201 [6.912e5])
    │   └─ ← [Return] 
    ├─ [52588] IDO::claim(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ [25188] MyToken::transfer(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 100)
    │   │   ├─ emit Transfer(from: IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], to: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], value: 100)
    │   │   └─ ← [Return] true
    │   ├─ emit Claim(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], user: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], amount: 100, price: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [1566] IDO::claim(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   └─ ← [Revert] revert: Already claimed!!!
    └─ ← [Revert] revert: Already claimed!!!

[PASS] testFail_IDOTimestamp() (gas: 319637)
Traces:
  [299737] IDOTest::testFail_IDOTimestamp()
    ├─ [0] VM::startPrank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [46728] MyToken::mint(100)
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], value: 100)
    │   └─ ← [Stop] 
    ├─ [25188] MyToken::transfer(IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 100)
    │   ├─ emit Transfer(from: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], to: IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 100)
    │   └─ ← [Return] true
    ├─ [158632] IDO::addIDO(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 1000000000000000000 [1e18], 100, 100000000000000000000 [1e20], 200000000000000000000 [2e20], 1, 604801 [6.048e5])
    │   ├─ emit NewIDO(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], amount: 100, softCap: 100000000000000000000 [1e20], hardCap: 200000000000000000000 [2e20], startTime: 1, endTime: 604801 [6.048e5])
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::deal(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 100000000000000000000 [1e20])
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02])
    │   └─ ← [Return] 
    ├─ [47586] IDO::presale{value: 100000000000000000000}(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ emit Presale(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], buyer: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], value: 100000000000000000000 [1e20])
    │   └─ ← [Return] true
    ├─ [0] VM::warp(259201 [2.592e5])
    │   └─ ← [Return] 
    ├─ [652] IDO::claim(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   └─ ← [Revert] revert: Presale is ongoing!!!
    └─ ← [Revert] revert: Presale is ongoing!!!

[PASS] test_IDORefund() (gas: 316030)
Traces:
  [316030] IDOTest::test_IDORefund()
    ├─ [0] VM::startPrank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [46728] MyToken::mint(100)
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], value: 100)
    │   └─ ← [Stop] 
    ├─ [25188] MyToken::transfer(IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 100)
    │   ├─ emit Transfer(from: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], to: IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 100)
    │   └─ ← [Return] true
    ├─ [158632] IDO::addIDO(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 1000000000000000000 [1e18], 100, 100000000000000000000 [1e20], 200000000000000000000 [2e20], 1, 604801 [6.048e5])
    │   ├─ emit NewIDO(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], amount: 100, softCap: 100000000000000000000 [1e20], hardCap: 200000000000000000000 [2e20], startTime: 1, endTime: 604801 [6.048e5])
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::deal(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 50000000000000000000 [5e19])
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02])
    │   └─ ← [Return] 
    ├─ [47586] IDO::presale{value: 50000000000000000000}(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ emit Presale(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], buyer: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], value: 50000000000000000000 [5e19])
    │   └─ ← [Return] true
    ├─ [0] VM::warp(691201 [6.912e5])
    │   └─ ← [Return] 
    ├─ [35593] IDO::refund(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ [0] buyer::fallback{value: 50000000000000000000}()
    │   │   └─ ← [Stop] 
    │   ├─ emit Refund(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], user: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], value: 0)
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(50000000000000000000 [5e19], 50000000000000000000 [5e19]) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

[PASS] test_IDOSuccess() (gas: 371085)
Traces:
  [371085] IDOTest::test_IDOSuccess()
    ├─ [0] VM::startPrank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [46728] MyToken::mint(100)
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], value: 100)
    │   └─ ← [Stop] 
    ├─ [25188] MyToken::transfer(IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], 100)
    │   ├─ emit Transfer(from: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], to: IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], value: 100)
    │   └─ ← [Return] true
    ├─ [158632] IDO::addIDO(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 1000000000000000000 [1e18], 100, 100000000000000000000 [1e20], 200000000000000000000 [2e20], 1, 604801 [6.048e5])
    │   ├─ emit NewIDO(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], price: 1000000000000000000 [1e18], amount: 100, softCap: 100000000000000000000 [1e20], hardCap: 200000000000000000000 [2e20], startTime: 1, endTime: 604801 [6.048e5])
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::deal(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 100000000000000000000 [1e20])
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02])
    │   └─ ← [Return] 
    ├─ [47586] IDO::presale{value: 100000000000000000000}(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ emit Presale(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], buyer: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], value: 100000000000000000000 [1e20])
    │   └─ ← [Return] true
    ├─ [0] VM::warp(691201 [6.912e5])
    │   └─ ← [Return] 
    ├─ [52588] IDO::claim(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ [25188] MyToken::transfer(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], 100)
    │   │   ├─ emit Transfer(from: IDO: [0x2e234DAe75C793f67A35089C9d99245E1C58470b], to: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], value: 100)
    │   │   └─ ← [Return] true
    │   ├─ emit Claim(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], user: buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02], amount: 100, price: 1000000000000000000 [1e18])
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [540] MyToken::balanceOf(buyer: [0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02]) [staticcall]
    │   └─ ← [Return] 100
    ├─ [0] VM::assertEq(100, 100) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::prank(seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174])
    │   └─ ← [Return] 
    ├─ [35386] IDO::withdraw(MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f])
    │   ├─ [0] seller::fallback{value: 100000000000000000000}()
    │   │   └─ ← [Stop] 
    │   ├─ emit Withdraw(token: MyToken: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], seller: seller: [0xDFa97bfe5d2b2E8169b194eAA78Fbb793346B174], value: 100000000000000000000 [1e20])
    │   └─ ← [Return] true
    ├─ [0] VM::assertEq(100000000000000000000 [1e20], 100000000000000000000 [1e20]) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 4 passed; 0 failed; 0 skipped; finished in 849.04µs (566.29µs CPU time)

Ran 1 test suite in 930.25ms (849.04µs CPU time): 4 tests passed, 0 failed, 0 skipped (4 total tests)