import { toHex, encodePacked, keccak256 } from 'viem';
import { MerkleTree } from "merkletreejs";

const users: `0x${string}`[] = [
  "0xD08c8e6d78a1f64B1796d6DC3137B19665cb6F1F",
  "0xb7D15753D3F76e7C892B63db6b4729f700C01298",
  "0xf69Ca530Cd4849e3d1329FBEC06787a96a3f9A68",
  "0x0fF93eDfa7FB7Ad5E962E4C0EdB9207C03a0fe02" // 测试中需要用到的白名单地址buyer
];

  // equal to MerkleDistributor.sol #keccak256(abi.encodePacked(account, amount));
  const elements = users.map((x) => keccak256(encodePacked(["address"], [x])));

  console.log(elements)

  const merkleTree = new MerkleTree(elements, keccak256, { sort: true });

  const root = merkleTree.getHexRoot();
  console.log("root:" + root);


  const leaf = elements[3];
  const proof = merkleTree.getHexProof(leaf);
  console.log("proof:" +proof);

  // 0xa8532aAa27E9f7c3a96d754674c99F1E2f824800, 30, [0xd24d002c88a75771fc4516ed00b4f3decb98511eb1f7b968898c2f454e34ba23,0x4e48d103859ea17962bdf670d374debec88b8d5f0c1b6933daa9eee9c7f4365b]




