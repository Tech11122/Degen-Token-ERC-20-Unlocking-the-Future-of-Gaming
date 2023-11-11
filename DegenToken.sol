
/*
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as 2. rewards. Only the owner can mint tokens.
3. Transferring tokens: Players should be able to transfer their tokens to others.
4. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
5. Checking token balance: Players should be able to check their token balance at any time.
6. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    
    uint256 public constant REDEMPTION_RATE = 100;

    mapping(address => uint256) public swordsOwned;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        _mint(msg.sender, 10 * (10 ** uint256(decimals())));
    }

    function redeemSword(uint256 quantity) public {
        uint256 cost = REDEMPTION_RATE * quantity;
        require(balanceOf(msg.sender) >= cost, "Not enough tokens to redeem for a sword");

        swordsOwned[msg.sender] += quantity;
        _burn(msg.sender, cost);
    }

    function checkSwordsOwned(address user) public view returns (uint256) {
        return swordsOwned[user];
    }

    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function burnTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough tokens to burn");
        _burn(msg.sender, amount);
    }

    function transferTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid address");
        require(balanceOf(msg.sender) >= amount, "Not enough tokens to transfer");
        _transfer(msg.sender, to, amount);
    }
}
