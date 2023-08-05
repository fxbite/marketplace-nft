// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MetalToken is ERC20, Ownable {
    uint256 private total = 50 * 10 ** decimals();

    constructor() ERC20("Metal Token", "MET") {
        console.log("owner: %s", msg.sender);
        _mint(msg.sender, total);
        transferOwnership(msg.sender);
    }

    // Get more tokens. If the existing token is lower than the initial token.
    function mint(address to, uint256 amount) public onlyOwner {
        require(
            ERC20.totalSupply() + amount <= total,
            "Metal Token: total exceeded"
        );
        _mint(to, amount);
    }

    // Remove amount of existing token
    function burn(address account, uint256 amount) public onlyOwner {
        require(
            amount <= ERC20.balanceOf(account),
            "Metal Token: can not burn" 
        );
        _burn(account, amount);
    }

    // Transfer token for other account
    function transfer(address to, uint256 amount) public override returns (bool) {
        console.log("balanceOf: %s", ERC20.balanceOf(to));
        console.log("amount: %s", amount);
        console.log("total: %s", total);
        return super.transfer(to, amount);
    }
}
