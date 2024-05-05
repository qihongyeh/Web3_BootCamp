Ran 1 test for test/InscriptionFactory.t.sol:InscriptionFactoryTest
[PASS] testMintInscription() (gas: 163706)
Traces:
  [1329263] InscriptionFactoryTest::setUp()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69
    ├─ [0] VM::prank(0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69)
    │   └─ ← [Return] 
    ├─ [1021021] → new InscriptionFactory@0x82c839Fa4a41E158f613EC8A1A84Be3c816D370F
    │   ├─ [737466] → new InscriptionToken@0x4408afEFB5551251eB9Fb7aad7627625da608e49
    │   │   └─ ← [Return] 3226 bytes of code
    │   └─ ← [Return] 1031 bytes of code
    ├─ [0] VM::prank(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf)
    │   └─ ← [Return] 
    ├─ [176181] InscriptionFactory::deployInscription(10000 [1e4], 1, 10)
    │   ├─ [9031] → new <unknown>@0x656CBAB9E0CB58Cc89996EE4050bCae9be0B7189
    │   │   └─ ← [Return] 45 bytes of code
    │   ├─ [111659] 0x656CBAB9E0CB58Cc89996EE4050bCae9be0B7189::initialize(10000 [1e4], 1, 10, 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf, 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69)
    │   │   ├─ [111463] InscriptionToken::initialize(10000 [1e4], 1, 10, 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf, 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69) [delegatecall]
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   └─ ← [Return] 0x656CBAB9E0CB58Cc89996EE4050bCae9be0B7189
    └─ ← [Stop] 

  [163706] InscriptionFactoryTest::testMintInscription()
    ├─ [0] VM::deal(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF, 100)
    │   └─ ← [Return] 
    ├─ [0] VM::prank(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF)
    │   └─ ← [Return] 
    ├─ [138975] InscriptionFactory::mintInscription{value: 10}(0x656CBAB9E0CB58Cc89996EE4050bCae9be0B7189)
    │   ├─ [126781] 0x656CBAB9E0CB58Cc89996EE4050bCae9be0B7189::mint{value: 10}(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF)
    │   │   ├─ [124112] InscriptionToken::mint{value: 10}(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF) [delegatecall]
    │   │   │   ├─ [0] 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf::fallback{value: 9}()
    │   │   │   │   └─ ← [Stop] 
    │   │   │   ├─ [0] 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69::fallback{value: 1}()
    │   │   │   │   └─ ← [Stop] 
    │   │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF, value: 1)
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Return] 
    │   └─ ← [Return] true
    ├─ [0] VM::assertEq(9, 9) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::assertEq(1, 1) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 1.09ms (57.46µs CPU time)

Ran 1 test suite in 1.33s (1.09ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)