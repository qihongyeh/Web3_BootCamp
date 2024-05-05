// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract InscriptionToken is ERC20 {
    // 声明相关状态变量
    uint256 public totalSupply_;
    uint256 public perMint_;
    uint256 public price_;
    uint256 public totalMinted_;
    string public name_ = "InscriptionToken";
    string public symbol_ = "IT";

    address public creator_;
    address public factoryOwner_;

    bool private initialized;

    constructor() ERC20(name_, symbol_) {}

    // 初始化token
    function initialize(uint256 _totalSupply, uint256 _perMint, uint256 _price, address _creator, address _factoryOwner)
        external
        returns (bool)
    {
        require(!initialized, "Already initialized");
        initialized = true;

        totalSupply_ = _totalSupply;
        perMint_ = _perMint;
        price_ = _price;
        creator_ = _creator;
        factoryOwner_ = _factoryOwner;

        return true;
    }

    function mint(address minter) external payable {
        // 检查铸造者的价格与是否铸造结束
        require(msg.value == price_, "Ivvalid price!!!");
        require(totalMinted_ + perMint_ <= totalSupply_, "Mint over!!!");

        //费用分配：90% 给发行者，10%给工厂合约的拥有者
        uint256 feeToCreator = (msg.value * 90) / 100;
        uint256 feeToFactoryOwner = (msg.value * 10) / 100;
        payable(creator_).transfer(feeToCreator);
        payable(factoryOwner_).transfer(feeToFactoryOwner);

        // 铸造token
        _mint(minter, perMint_);
        totalMinted_ += perMint_;

    }
}
