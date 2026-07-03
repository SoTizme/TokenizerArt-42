# ShilalNFT42 (SNFT42)

An ERC-721 Non-Fungible Token (NFT) collection developed as part of the **42 TokenizeArt** project.

This project demonstrates the complete NFT lifecycle, from smart contract development and deployment to decentralized storage and minting. Alongside the mandatory implementation, it also includes a bonus version where both the artwork and metadata are stored entirely on-chain, removing any dependency on external storage.

---

# Features

## Mandatory Implementation

* ERC-721 compliant NFT
* Ethereum Sepolia testnet deployment
* Metadata and artwork stored on IPFS
* Owner-only minting
* OpenZeppelin audited contracts

## Bonus Implementation

* Fully on-chain metadata
* Fully on-chain SVG artwork
* Dynamic `tokenURI()` generation
* Lightweight minting website
* Per-token visual variations generated from the token ID

---

# Technology Stack

| Component             | Technology                 |
| --------------------- | -------------------------- |
| Blockchain            | Ethereum (Sepolia Testnet) |
| Standard              | ERC-721                    |
| Language              | Solidity 0.8.34            |
| Libraries             | OpenZeppelin               |
| Development           | Remix IDE                  |
| Wallet                | MetaMask                   |
| Decentralized Storage | IPFS (Mandatory only)      |

---

# Design Choices

## Ethereum (Sepolia Testnet)

The project uses the Ethereum Sepolia Testnet to safely develop and test smart contracts without spending real ETH while maintaining compatibility with Ethereum Mainnet.

## ERC-721

ERC-721 is the standard for non-fungible tokens. Every NFT owns a unique identifier and metadata, making it suitable for representing unique digital assets.

## Solidity 0.8.34

The contracts are written using Solidity **0.8.34**, which includes built-in overflow and underflow protection together with modern compiler improvements.

## OpenZeppelin

The implementation relies on OpenZeppelin's audited smart contracts instead of implementing ERC-721 from scratch.

Mandatory contract:

* ERC721
* ERC721URIStorage
* Ownable

Bonus contract:

* ERC721
* Ownable
* Base64 encoding utilities

---

# Storage Architecture

## Mandatory Contract

The mandatory NFT stores its artwork and metadata on **IPFS**.

* NFT image → IPFS
* Metadata JSON → IPFS
* Smart contract stores the metadata URI

This approach provides decentralized storage while keeping deployment costs low.

## Bonus Contract

The bonus implementation removes IPFS entirely.

The contract generates the metadata JSON dynamically and embeds the SVG artwork directly inside the metadata as a Base64-encoded image.

As a result, the NFT is completely self-contained on the blockchain.

---

# Security

Both implementations follow the same security model.

* Only the contract owner can mint NFTs (`Ownable`).
* Every minted NFT receives a unique token ID.
* The contracts were deployed and tested exclusively on the Ethereum Sepolia Testnet.
* Ownership can always be verified using the standard `ownerOf()` function.

---

# Repository Structure

```text
.
├── README.md
├── code
│   └── ShilalNFT42.sol
├── deployment
│   └── how_to_deploy.md
├── documentation
│   └── whitepaper.md
├── mint
│   ├── metadata.json
│   ├── mint_info.md
|   └── shilal_nft42.png
└── bonus
    ├── code
    │   └── ShilalNFT42Onchain.sol
    ├── documentation
    │   └── bonus_notes.md
    └── website
        └── mint.html
```

---

# Deployments

## Mandatory Contract

| Item     | Value                                        |
| -------- | -------------------------------------------- |
| Contract | `0xeD8D4EBA286049A9fcFDdfC817676624c63aaEAA` |
| Storage  | IPFS                                         |
| Network  | Ethereum Sepolia                             |

### Resources

* **Explorer:** https://sepolia.etherscan.io/address/0xeD8D4EBA286049A9fcFDdfC817676624c63aaEAA
* **Metadata:** https://gateway.pinata.cloud/ipfs/bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va
* **Artwork:** https://gateway.pinata.cloud/ipfs/bafybeicvjcxbz7bol5rflmwmkoytq5qqab4nlznx47eggj6w4wkayatrdy

---

## Bonus Contract

| Item     | Value                                        |
| -------- | -------------------------------------------- |
| Contract | `0xb9fFC94D4E517730d2Ae0312D41Cc2DFbDAd82F5` |
| Storage  | Fully On-Chain                               |
| Network  | Ethereum Sepolia                             |

### Resources

* **Explorer:** https://sepolia.etherscan.io/address/0xb9fFC94D4E517730d2Ae0312D41Cc2DFbDAd82F5
* **Metadata:** Generated entirely on-chain through `tokenURI()`
* **Artwork:** Embedded SVG stored on-chain

---

# Mandatory vs Bonus

| Feature                    | Mandatory | Bonus |
| -------------------------- | :-------: | :---: |
| ERC-721                    |     ✅     |   ✅   |
| Sepolia Deployment         |     ✅     |   ✅   |
| Owner-only Minting         |     ✅     |   ✅   |
| IPFS Metadata              |     ✅     |   ❌   |
| IPFS Artwork               |     ✅     |   ❌   |
| Fully On-Chain Metadata    |     ❌     |   ✅   |
| Fully On-Chain SVG Artwork |     ❌     |   ✅   |
| Dynamic `tokenURI()`       |     ❌     |   ✅   |
| Mint Website               |     ❌     |   ✅   |

---

# Bonus Features

The bonus implementation extends the mandatory project with several additional features.

### Fully On-Chain NFT

Both the metadata and SVG artwork are generated directly by the smart contract without relying on IPFS or any external storage.

### Dynamic Artwork

Each NFT includes small deterministic visual variations derived from its token ID, giving every mint a unique appearance while preserving the overall design.

### Mint Website

A lightweight web interface allows users to:

* Connect MetaMask
* Mint NFTs
* Look up existing tokens
* View NFT metadata directly from the deployed smart contract

---

# Documentation

| File                                 | Description                                       |
| ------------------------------------ | ------------------------------------------------- |
| `deployment/how_to_deploy.md`        | Deployment guide for the mandatory implementation |
| `documentation/whitepaper.md`        | Project overview and architecture                 |
| `mint/mint_info.md`                  | Minting details and IPFS resources                |
| `bonus/documentation/bonus_notes.md` | Documentation for the bonus implementation        |

---

# License

This project was created for the **42 TokenizeArt** project and is intended for educational purposes.
