第一步：编译合约

```bash
forge build
```

第二步：配置.env文件

```
SEPOLIA_RPC_URL=
PRIVATE_KEY=
ETHERSCAN_API_KEY=
```

第三步：编写MyToken.s.sol脚本

第四步：加载.env环境变量

```bash
source .env
```

第五步：forge script

```bash
forge script ./script/MyToken.s.sol:MyTokenScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify $ETHERSCAN_API_KEY
```

