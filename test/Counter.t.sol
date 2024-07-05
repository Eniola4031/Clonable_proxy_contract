// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Erc20proxyclone.sol";
import "../src/Proxyclone.sol";

contract TokenFactoryTest is Test {
    ERC20 public masterContract;
    TokenFactory public tokenFactory;

    function setUp() public {
        masterContract = new ERC20();
        tokenFactory = new TokenFactory(address(masterContract));
    }

    function testCreateToken() public {
        string memory name = "Test Token";
        string memory symbol = "TTK";
        uint256 initialSupply = 1000;

        address clone = tokenFactory.createToken(name, symbol, initialSupply);

        ERC20 clonedToken = ERC20(clone);

        assertEq(clonedToken.name(), name);
        assertEq(clonedToken.symbol(), symbol);
        assertEq(clonedToken.totalSupply(), initialSupply * 10 ** uint256(clonedToken.decimals()));
        assertEq(clonedToken.balanceOf(address(this)), initialSupply * 10 ** uint256(clonedToken.decimals()));
    }
}