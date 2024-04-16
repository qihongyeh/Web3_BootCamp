from datetime import datetime
import hashlib
import rsa

name = 'khawa.eth'
nonce = 1
hash_dict = {}

for level in [4, 5]:
    # 设置循环起始时间
    now = datetime.now()
    while True:
        # 更新hash前的数据
        data = name + str(nonce)
        # 计算哈希值
        hex_data = hashlib.sha256(data.encode('utf-8')).hexdigest()
        print(hex_data)
        # 判断哈希值前面零的个数
        if hex_data[:level] == '0' * level:
            hash_dict[level] = hex_data
            break
        nonce += 1
    # 统计当前循环所花费时间
    print(f'time spent: {datetime.now() - now}')
print(hash_dict)

# 生产公、私钥对
public_key, private_key = rsa.newkeys(512)
# 选取4个零开头的哈希值
message = hash_dict[4].encode()
# 使用私钥进行签名
signature = rsa.sign(message, private_key, 'SHA-256')
# 使用公钥进行验证
verify = rsa.verify(message, signature, public_key)
if verify == 'SHA-256':
    print('Verify success!')

