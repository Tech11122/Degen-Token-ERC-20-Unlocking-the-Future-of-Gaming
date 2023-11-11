# Degen Token (ERC-20): Unlocking the Future of Gaming

Degen Token, an ERC-20 on Avalanche, transforms gaming by offering versatile features like minting, transfers, and in-game redemptions. This token adheres to ERC-20 standards for seamless integration across platforms, shaping a dynamic and rewarding future for the gaming community.

## Description

Degen Token, an ERC-20 standard token on the Avalanche network, is revolutionizing the gaming experience. This versatile digital asset empowers players with features like minting, transfers, and in-game redemptions. By adhering to ERC-20 standards, Degen Token ensures compatibility and usability across diverse platforms. It stands as a beacon in the future of gaming, where blockchain technology and player-centric features converge to create a dynamic and rewarding gaming ecosystem.

## Getting Started

### Executing program
To run this program, you can use remix, an online Solidity IDE. Go to this remix website to start 
https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.23+commit.f704f362.js

At the gitpod website go to idex to run this program. Save this file by clicking the right corner of the window and with the black paper symbol. Save the file named DegenToken.sol and copy paste the code
```
/*
1. Minting new tokens: The platform should be able to create new tokens and distribute them to players as 2. rewards. Only the owner can mint tokens.
3. Transferring tokens: Players should be able to transfer their tokens to others.
4. Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
5. Checking token balance: Players should be able to check their token balance at any time.
6. Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

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
```
To successfully deploy the contract to snowtrace:

.open vs code
.enter: cd (your-project)
.enter: npm init -y
.enter: npm install --save-dev hardhat
.enter: npm install @openzeppelin/contracts
.Delete the existing module.exports code and add the following code to your hardhat.config.js file. This will enable us to test our smart contracts on the local network with data from Avalanche Mainnet.

```
const FORK_FUJI = false
const FORK_MAINNET = false
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: 'https://api.avax.network/ext/bc/C/rpcc',
  }
}
if (FORK_FUJI) {
  forkingData = {
    url: 'https://api.avax-test.network/ext/bc/C/rpc',
  }
}
```
replace the hardhat.config.js code with this code:

```
require("@nomicfoundation/hardhat-toolbox");

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
  };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.18",

  
  etherscan: {
    apiKey: "your snowtrace api key here",
  },

  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined, //Only specify a chainId if we are not forking
      forking: forkingData
    },

    fuji: {
      url: 'https://api.avax-test.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [

        "private key from metamask here"

      ]
    },

    mainnet: {
      url: 'https://api.avax.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: [

        "private key from metamask here"

      ]
    }
  }

};
```

.enter this on vs code terminal: npx hardhat run scripts/deploy.js --network fuji
.check on snowtrace if contract is successfully deployed on your snowtrace account
.To get the code working, follow these steps:

.on the left part of the website, right click and create new file and name the file DegenToken.sol
.paste the code provided above
.on the left, click on the icon below the magnifying glass icon and it should show another window and press the blue button with the compile DegenToken.sol written on it
.click on the icon that is below the compile icon and input the address of the contract that you have deployed on the at address below the orange deploy button

## Help

After cloning the github, you will want to do the following to get the code running on your computer.

Inside the project directory, in the terminal type: npm i
Open two additional terminals in your VS code
In the second terminal type: npx hardhat node
In the third terminal, type: npx hardhat run --network localhost scripts/deploy.js
Back in the first terminal, type npm run dev to launch the front-end.
After this, the project will be running on your localhost. Typically at http://localhost:3000/

## Authors

Juan Alfonso Q. Magpantay - Metacrafters 


