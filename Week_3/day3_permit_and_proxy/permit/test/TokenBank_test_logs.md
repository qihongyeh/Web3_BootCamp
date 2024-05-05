Ran 1 test for test/TokenBank.s.sol:TokenBankTest
[PASS] test_PermitDeposit() (gas: 132791)
Traces:
  [1254215] TokenBankTest::setUp()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266]
    ├─ [0] VM::label(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], "owner")
    │   └─ ← [Return] 
    ├─ [0] VM::prank(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266])
    │   └─ ← [Return] 
    ├─ [862395] → new PermitToken@0x88F59F8826af5e695B13cA934d6c7999875A9EeA
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], value: 100)
    │   └─ ← [Return] 3839 bytes of code
    ├─ [294331] → new TokenBank@0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    │   └─ ← [Return] 1470 bytes of code
    └─ ← [Stop] 

  [132791] TokenBankTest::test_PermitDeposit()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266]
    ├─ [0] VM::label(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], "owner")
    │   └─ ← [Return] 
    ├─ [2616] PermitToken::nonces(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [430] PermitToken::DOMAIN_SEPARATOR() [staticcall]
    │   └─ ← [Return] 0xce5df4693386e94a4d97e2f030f03a58308b090ec60d472c6d6a801e9f3ca6ac
    ├─ [0] VM::sign("<pk>", 0x1a54fc9a4551234841f216dd18f4f070025ac8ef854e71b937af4fd6441bf593) [staticcall]
    │   └─ ← [Return] 28, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77
    ├─ [0] VM::startPrank(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266])
    │   └─ ← [Return] 
    ├─ [104183] TokenBank::permitDeposit(PermitToken: [0x88F59F8826af5e695B13cA934d6c7999875A9EeA], 10, 86401 [8.64e4], 28, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77)
    │   ├─ [49484] PermitToken::permit(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], TokenBank: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 10, 86401 [8.64e4], 28, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x1a54fc9a4551234841f216dd18f4f070025ac8ef854e71b937af4fd6441bf593, 28, 104847989224298106371997112892752382736807708590793240728743734770433948600811, 45294886835871360309752801336162791656059890107630812766785381202981215779703) [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000007c8999dc9a822c1f0df42023113edb4fdd543266
    │   │   ├─ emit Approval(owner: owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], spender: TokenBank: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], value: 10)
    │   │   └─ ← [Stop] 
    │   ├─ [30862] PermitToken::transferFrom(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], TokenBank: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 10)
    │   │   ├─ emit Transfer(from: owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], to: TokenBank: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], value: 10)
    │   │   └─ ← [Return] true
    │   └─ ← [Return] true
    ├─ [709] TokenBank::bankBalances(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], PermitToken: [0x88F59F8826af5e695B13cA934d6c7999875A9EeA]) [staticcall]
    │   └─ ← [Return] 10
    ├─ [0] VM::assertEq(10, 10) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::expectRevert(Permit failed!!!)
    │   └─ ← [Return] 
    ├─ [6406] TokenBank::permitDeposit(PermitToken: [0x88F59F8826af5e695B13cA934d6c7999875A9EeA], 11, 86401 [8.64e4], 28, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77)
    │   ├─ [5361] PermitToken::permit(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], TokenBank: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 11, 86401 [8.64e4], 28, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0xf6d37ca011974ded0935d8c069f2448a917c731252a9604f643b4eb7ba61fbf1, 28, 104847989224298106371997112892752382736807708590793240728743734770433948600811, 45294886835871360309752801336162791656059890107630812766785381202981215779703) [staticcall]
    │   │   │   └─ ← [Return] 0x000000000000000000000000696d5643c1fbf5f0800edf0c856538da3cf9be9c
    │   │   └─ ← [Revert] ERC2612InvalidSigner(0x696D5643C1fbf5f0800eDF0c856538da3cF9Be9c, 0x7c8999dC9a822c1f0Df42023113EDB4FDd543266)
    │   └─ ← [Revert] revert: Permit failed!!!
    ├─ [0] VM::expectRevert(Permit failed!!!)
    │   └─ ← [Return] 
    ├─ [6406] TokenBank::permitDeposit(PermitToken: [0x88F59F8826af5e695B13cA934d6c7999875A9EeA], 10, 86402 [8.64e4], 28, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77)
    │   ├─ [5361] PermitToken::permit(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], TokenBank: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 10, 86402 [8.64e4], 28, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x49e6dcdebbc7a8122b3d0f44d14a69e4e73beef86d2d0674aa56211bae961509, 28, 104847989224298106371997112892752382736807708590793240728743734770433948600811, 45294886835871360309752801336162791656059890107630812766785381202981215779703) [staticcall]
    │   │   │   └─ ← [Return] 0x00000000000000000000000079dfd6022e6e22b8a3dde111917a276e9c8009fa
    │   │   └─ ← [Revert] ERC2612InvalidSigner(0x79DFD6022e6e22b8a3dDE111917A276e9C8009fA, 0x7c8999dC9a822c1f0Df42023113EDB4FDd543266)
    │   └─ ← [Revert] revert: Permit failed!!!
    ├─ [0] VM::expectRevert(Permit failed!!!)
    │   └─ ← [Return] 
    ├─ [6296] TokenBank::permitDeposit(PermitToken: [0x88F59F8826af5e695B13cA934d6c7999875A9EeA], 10, 86401 [8.64e4], 29, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77)
    │   ├─ [5251] PermitToken::permit(owner: [0x7c8999dC9a822c1f0Df42023113EDB4FDd543266], TokenBank: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 10, 86401 [8.64e4], 29, 0xe7cddbe12e041b32d9b3885e62ee6314b21d94aea3d7d5d2d6b3a456153349eb, 0x6423ff58768a4a4c8561fba5c4b3fb3487dad67a87cd10865d7017064313bb77)
    │   │   ├─ [3000] PRECOMPILES::ecrecover(0x381335c74eee7c28ccedaabbeb924c028311076e5f51ecd1889c3efabd3bc967, 29, 104847989224298106371997112892752382736807708590793240728743734770433948600811, 45294886835871360309752801336162791656059890107630812766785381202981215779703) [staticcall]
    │   │   │   └─ ← [Return] 
    │   │   └─ ← [Revert] ECDSAInvalidSignature()
    │   └─ ← [Revert] revert: Permit failed!!!
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 1.34ms (902.88µs CPU time)

Ran 1 test suite in 1.16s (1.34ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)