// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract Counter {
    
    uint256 counter;

    function get() public view returns (uint256) {
        return counter;
    }

    function add(uint256 x) public {
        counter = counter + x;
    }

}