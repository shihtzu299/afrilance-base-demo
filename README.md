# AfriLance Escrow + AI Oracle Demo on Base Sepolia

This is a demo prototype of the AfriLance escrow payment dApp (built on BNB Chain mainnet at [escrow.afrilance.xyz](https://escrow.afrilance.xyz)) ported to Base Sepolia testnet. It secures interests of clients and freelancers/artisans with on-chain payments and a placeholder AI oracle for freelancer-job matching.

## Key Features
- **Escrow Flow**: Client deposits funds, freelancer completes work, client approves release or refunds.
- **AI Oracle Placeholder**: Oracle-controlled update for match score (0-100), with access restricted to oracle address.
- **Simulate AI Match**: On-chain pure function to demo AI-like scoring based on freelancer skills and job requirements.

## Deployment Details
- **Chain**: Base Sepolia Testnet (Chain ID: 84532)
- **Contract Address**: 0xBDd50E38e94f25D2254101DB21AB32354D5B8f10
- **Basescan Link**: [https://sepolia.basescan.org/address/0xBDd50E38e94f25D2254101DB21AB32354D5B8f10](https://sepolia.basescan.org/address/0xBDd50E38e94f25D2254101DB21AB32354D5B8f10) (verified source code)
- **Tested Interactions**:
  - Deposit and balance check.
  - updateAIMatchScore (only from oracle; reverts from client/freelancer).
  - simulateAIMatch with different strings returning varying 0-100 scores.
  - Complete work → Approve release.

## How to Test (Using Remix)
1. Connect to Base Sepolia in MetaMask.
2. Load the contract in Remix at the address above.
3. Call functions as per the flow (use test ETH from faucets).

## Vision
This demo explores Base for lower fees and Coinbase fiat ramps, targeting African freelancers/artisans. 
Future: Integrate real off-chain AI (e.g., ML models via Chainlink) for auto-matching in gig marketplace once completed and live.

## License
MIT License

For questions: @Ares19BC_ on X.
