Ran 3 tests for test/Staking.t.sol:StakingTest
[PASS] testFail_RedeemPartial() (gas: 339586)
Traces:
  [271669] StakingTest::testFail_RedeemPartial()
    ├─ [0] VM::startPrank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [0] VM::warp(1)
    │   └─ ← [Return] 
    ├─ [72638] Staking::stake(200)
    │   ├─ [18562] RNTToken::transferFrom(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 200)
    │   │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ emit Stake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], stakeAmount: 200)
    │   └─ ← [Return] true
    ├─ [648] Staking::RNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200, 1
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::warp(86401 [8.64e4])
    │   └─ ← [Return] 
    ├─ [27164] Staking::unstake(200)
    │   ├─ [3288] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 200)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ emit Unstake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], unstakeAmount: 200)
    │   └─ ← [Return] true
    ├─ [648] Staking::RNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0, 86401 [8.64e4]
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [103870] Staking::claim(100)
    │   ├─ [29988] esRNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 100)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 100)
    │   │   └─ ← [Return] true
    │   ├─ emit Claim(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], claimAmount: 100)
    │   └─ ← [Return] true
    ├─ [0] VM::warp(1382401 [1.382e6])
    │   └─ ← [Return] 
    ├─ [50770] Staking::claim(100)
    │   ├─ [3288] esRNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 100)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 100)
    │   │   └─ ← [Return] true
    │   ├─ emit Claim(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], claimAmount: 100)
    │   └─ ← [Return] true
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::warp(2678401 [2.678e6])
    │   └─ ← [Return] 
    ├─ [57882] Staking::redeem()
    │   ├─ [540] esRNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   │   └─ ← [Return] 200
    │   ├─ [540] esRNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   │   └─ ← [Return] 200
    │   ├─ [8962] esRNTToken::transferFrom(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 200)
    │   │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ [8888] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 150)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 150)
    │   │   └─ ← [Return] true
    │   ├─ [27988] esRNTToken::transfer(0x000000000000000000000000000000000000dEaD, 50)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: 0x000000000000000000000000000000000000dEaD, value: 50)
    │   │   └─ ← [Return] true
    │   ├─ emit Redeem(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], redeemAmount: 150, burnAmount: 50)
    │   └─ ← [Return] true
    ├─ [540] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 350
    ├─ [0] VM::assertEq(350, 400) [staticcall]
    │   └─ ← [Revert] assertion failed: 350 != 400
    └─ ← [Revert] assertion failed: 350 != 400

[PASS] test_RedeemAll() (gas: 248974)
Traces:
  [253187] StakingTest::test_RedeemAll()
    ├─ [0] VM::startPrank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [0] VM::warp(1)
    │   └─ ← [Return] 
    ├─ [72638] Staking::stake(200)
    │   ├─ [18562] RNTToken::transferFrom(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 200)
    │   │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ emit Stake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], stakeAmount: 200)
    │   └─ ← [Return] true
    ├─ [648] Staking::RNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200, 1
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::warp(86401 [8.64e4])
    │   └─ ← [Return] 
    ├─ [27164] Staking::unstake(200)
    │   ├─ [3288] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 200)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ emit Unstake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], unstakeAmount: 200)
    │   └─ ← [Return] true
    ├─ [648] Staking::RNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0, 86401 [8.64e4]
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [103870] Staking::claim(100)
    │   ├─ [29988] esRNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 100)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 100)
    │   │   └─ ← [Return] true
    │   ├─ emit Claim(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], claimAmount: 100)
    │   └─ ← [Return] true
    ├─ [0] VM::warp(1382401 [1.382e6])
    │   └─ ← [Return] 
    ├─ [50770] Staking::claim(100)
    │   ├─ [3288] esRNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 100)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 100)
    │   │   └─ ← [Return] true
    │   ├─ emit Claim(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], claimAmount: 100)
    │   └─ ← [Return] true
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::warp(3974401 [3.974e6])
    │   └─ ← [Return] 
    ├─ [34765] Staking::redeem()
    │   ├─ [540] esRNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   │   └─ ← [Return] 200
    │   ├─ [540] esRNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   │   └─ ← [Return] 200
    │   ├─ [8962] esRNTToken::transferFrom(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 200)
    │   │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ [8888] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 200)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ [5288] esRNTToken::transfer(0x000000000000000000000000000000000000dEaD, 0)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: 0x000000000000000000000000000000000000dEaD, value: 0)
    │   │   └─ ← [Return] true
    │   ├─ emit Redeem(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], redeemAmount: 200, burnAmount: 0)
    │   └─ ← [Return] true
    ├─ [540] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 400
    ├─ [0] VM::assertEq(400, 400) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

[PASS] test_RedeemPartial() (gas: 267432)
Traces:
  [271645] StakingTest::test_RedeemPartial()
    ├─ [0] VM::startPrank(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb])
    │   └─ ← [Return] 
    ├─ [0] VM::warp(1)
    │   └─ ← [Return] 
    ├─ [72638] Staking::stake(200)
    │   ├─ [18562] RNTToken::transferFrom(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 200)
    │   │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ emit Stake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], stakeAmount: 200)
    │   └─ ← [Return] true
    ├─ [648] Staking::RNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200, 1
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::warp(86401 [8.64e4])
    │   └─ ← [Return] 
    ├─ [27164] Staking::unstake(200)
    │   ├─ [3288] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 200)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ emit Unstake(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], unstakeAmount: 200)
    │   └─ ← [Return] true
    ├─ [648] Staking::RNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0, 86401 [8.64e4]
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [540] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 200
    ├─ [0] VM::assertEq(200, 200) [staticcall]
    │   └─ ← [Return] 
    ├─ [103870] Staking::claim(100)
    │   ├─ [29988] esRNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 100)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 100)
    │   │   └─ ← [Return] true
    │   ├─ emit Claim(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], claimAmount: 100)
    │   └─ ← [Return] true
    ├─ [0] VM::warp(1382401 [1.382e6])
    │   └─ ← [Return] 
    ├─ [50770] Staking::claim(100)
    │   ├─ [3288] esRNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 100)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 100)
    │   │   └─ ← [Return] true
    │   ├─ emit Claim(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], claimAmount: 100)
    │   └─ ← [Return] true
    ├─ [542] Staking::esRNTBalances(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] VM::assertEq(0, 0) [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::warp(2678401 [2.678e6])
    │   └─ ← [Return] 
    ├─ [57882] Staking::redeem()
    │   ├─ [540] esRNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   │   └─ ← [Return] 200
    │   ├─ [540] esRNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   │   └─ ← [Return] 200
    │   ├─ [8962] esRNTToken::transferFrom(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], 200)
    │   │   ├─ emit Transfer(from: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], to: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], value: 200)
    │   │   └─ ← [Return] true
    │   ├─ [8888] RNTToken::transfer(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], 150)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], value: 150)
    │   │   └─ ← [Return] true
    │   ├─ [27988] esRNTToken::transfer(0x000000000000000000000000000000000000dEaD, 50)
    │   │   ├─ emit Transfer(from: Staking: [0xF62849F9A0B5Bf2913b396098F7c7019b51A820a], to: 0x000000000000000000000000000000000000dEaD, value: 50)
    │   │   └─ ← [Return] true
    │   ├─ emit Redeem(staker: staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb], redeemAmount: 150, burnAmount: 50)
    │   └─ ← [Return] true
    ├─ [540] RNTToken::balanceOf(staker: [0x8eDc168c9bBB5ed126960E4a9F99b6c96EC76BEb]) [staticcall]
    │   └─ ← [Return] 350
    ├─ [0] VM::assertEq(350, 350) [staticcall]
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 3 passed; 0 failed; 0 skipped; finished in 906.88µs (734.71µs CPU time)

Ran 1 test suite in 134.39ms (906.88µs CPU time): 3 tests passed, 0 failed, 0 skipped (3 total tests)