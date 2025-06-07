# simple-Smart-Contract

A basic smart contract simulating a simple banking system using Solidity.

## 📌 Overview

SimpleBank is a smart contract that allows users to:

- Deposit Ethereum
- Withdraw Ethereum
- Transfer funds to other users
- Lock/unlock accounts
- Track all transactions via events

## 🛠️ Technologies Used

- Solidity
- Hardhat
- VSCode
- Git / GitHub

## 📂 Project Structure

```
contracts/
├── Proof_of_Work_simple.sol
├──scripts/
│  └── deploy.js
└──README.md
```

## 🚀 How to Deploy

1. Install dependencies:
   ```bash
   npm install --save-dev hardhat

2. Compile the contract:   
   
   bash

   npx hardhat compile

3. Run the deploy script:

   bash

   npx hardhat run scripts/deploy.js

 ## ✅ Features Work
 
- **Reentrancy Protection**  
  Implement safeguards against reentrancy attacks using the Checks-Effects-Interactions pattern and OpenZeppelin's `ReentrancyGuard` to enhance contract security.

- **Interest Calculation Based on Deposit Duration**  
  Utilize `block.timestamp` to calculate and apply interest rewards to users based on the time their funds have been deposited.

- **Integration with NFT and ERC20 Tokens**  
  Develop functionality to link user accounts with NFT membership passes and support ERC20 token deposits and withdrawals.

- **Multi-Signature Wallet Features**  
  Implement multi-signature approval mechanisms to require multiple owners' consent before executing critical transactions, improving security and control.
 