// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Erc20proxyclone.sol";

contract TokenFactory{
    event TokenCreated(address indexed tokenAddress, string name, string symbol, uint256 initialSupply);

    address public masterContract;

    constructor(address _masterContract) {
        masterContract = _masterContract;
    }

    function createToken(string memory name, string memory symbol, uint256 initialSupply) external returns (address) {
        address clone = createClone(masterContract);
        ERC20(clone).initialize(name, symbol, initialSupply);
        emit TokenCreated(clone, name, symbol, initialSupply);
        return clone;
    }

    function createClone(address target) internal returns (address result) {
        bytes20 targetBytes = bytes20(target);
        assembly {
            let clone := mload(0x40)
            mstore(clone, 0x3d602d80600a3d3981f3)
            mstore(add(clone, 0x14), targetBytes)
            mstore(add(clone, 0x28), 0x5af43d82803e903d91602b57fd5bf3)
            result := create(0, clone, 0x37)
        }
    }
}