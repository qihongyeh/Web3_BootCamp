from flask import Flask, jsonify, request
from time import time
import hashlib
import json


class BlockChain:
    def __init__(self) -> None:
        # 初始化区块链
        self.chain = []
        # 初始化内存池
        self.mempool = []
        # 创建创世区块
        self.new_block(proof='satoshi', previous_hash='vitalik')

    def new_block(self, proof, previous_hash=None) -> dict:
        """传入出块者的证明信息，并对交易进行打包、出块、上链"""
        # 当前区块信息
        block = {
            'index': len(self.chain) + 1,
            'timestamp': time(),
            'transactions': self.mempool,
            'proof': proof,
            'previous_hash': previous_hash or self.hash(self.chain[-1])
        }
        # 将当前区块加入到链中
        self.chain.append(block)
        # 将内存池清空
        self.mempool = []

        return block

    def new_txn(self, sender, recipient, amount) -> int:
        """创建一笔交易并加到内存池当中"""
        self.mempool.append({
            'sender': sender,
            'recipient': recipient,
            'amount': amount
        })

        return self.last_block['index'] + 1

    def proof_of_work(self, last_proof) -> int:
        """工作量证明"""
        proof = 0
        while self.valid_proof(last_proof, proof) is False:
            proof += 1

        return proof

    @staticmethod
    def valid_proof(last_proof, proof):
        """验证哈希值是否是4个0开头"""
        guess_data = f'{last_proof}{proof}'.encode()
        guess_hash = hashlib.sha256(guess_data).hexdigest()

        return guess_hash[:4] == '0000'

    @staticmethod
    def hash(block):
        """对一个区块数据进行哈希计算得到哈希值, 并返回"""
        block_data = json.dumps(block, sort_keys=True).encode()
        hash_value = hashlib.sha256(block_data).hexdigest()

        return hash_value

    @property
    def last_block(self):
        """返回最新的一个区块信息"""
        return self.chain[-1]


app = Flask(__name__)

blockchain = BlockChain()


@app.route('/txn/new', methods=['POST'])
def new_txn():
    """增加一笔新的交易请求"""
    # 获取交易详情
    values = request.get_json()
    # 检查请求的数据中是否包含要求的字段
    required = ['sender', 'recipient', 'amount']
    if not all(k in values for k in required):
        return 'Missing values', 400
    # 创建一笔新的交易并返回结果
    index = blockchain.new_txn(values['sender'], values['recipient'], values['amount'])
    response = {'message': f'Transaction will be added to Block {index}'}

    return jsonify(response), 201


@app.route('/mine', methods=['GET'])
def mine():
    """产生新的区块请求"""
    # 获取上一个区块的证明并计算当前区块证明
    last_block = blockchain.last_block
    last_proof = last_block['proof']
    proof = blockchain.proof_of_work(last_proof)
    # 节点奖励
    blockchain.new_txn(
        sender='0x0000000000000000000000',
        recipient='miner',
        amount=6.25
    )
    # 生成新区块
    block = blockchain.new_block(proof)
    # 请求返回信息
    response = {
        'message': 'New block forged',
        'index': block['index'],
        'transactions': block['transactions'],
        'proof': block['proof'],
        'previous_hash': block['previous_hash']
    }

    return jsonify(response), 200


@app.route('/mempool', methods=['GET'])
def mempool():
    """查询内存池请求"""
    return jsonify(blockchain.mempool), 200


@app.route('/chain', methods=['GET'])
def chain():
    """查询整条链请求"""
    response = {
        'chain': blockchain.chain,
        'length': len(blockchain.chain)
    }
    return jsonify(response), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)
