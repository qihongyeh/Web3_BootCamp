import { createPublicClient, http, parseAbiItem} from "viem";
import { mainnet } from "viem/chains";

const client = createPublicClient({
    chain: mainnet,
    transport: http("https://rpc.particle.network/evm-chain?chainId=1&projectUuid=f61dd10e-9690-4143-953e-73a7dc4f154b&projectKey=cST4CzbFX0NBsMbtINnHwlNXAMR0epKSReAxZp0a"),
});

async function main() {

    const endBlock = await client.getBlockNumber();
    const startBlock = endBlock - BigInt(100);
    const filter = await client.createEventFilter({
        // USDC合约地址
        address: "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
        event: parseAbiItem(
            "event Transfer(address indexed from, address indexed to, uint256 value)"
        ),
        fromBlock: startBlock,
        toBlock: endBlock, 
    });
    const logs = await client.getFilterLogs({ filter });

    console.log(logs);
    logs.forEach((log) => {
        console.log(
            `从 ${log.args.from} 转账给 ${log.args.to} ${log.args.value! / BigInt(1e6)} USDT, 
            https://etherscan.io/tx/${log.transactionHash}`
        );
    });

}

main().catch((err) => console.log(err));