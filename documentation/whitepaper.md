# ShilalNFT42 (SNFT42) — Documentation

## Overview

**ShilalNFT42** is a non-fungible token (NFT) created as part of the 42 TokenizeArt project. It follows the ERC-721 standard and represents a single, unique piece of digital artwork containing the number 42, deployed on the Ethereum Sepolia testnet for educational purposes.

---

## Token properties

| Property        | Value              |
|-----------------|--------------------|
| Collection name | ShilalNFT42        |
| Symbol          | SNFT42             |
| Standard        | ERC-721            |
| Network         | Ethereum Sepolia   |
| Artist / login  | shilal             |
| Real value      | None (testnet only)|

---

## What makes an NFT different from a regular token

Unlike ERC-20 tokens (where every unit is identical and interchangeable, like currency), each ERC-721 NFT is unique:

- Every NFT has its own `tokenId` (0, 1, 2, ...)
- Every NFT can have its own metadata (image, name, description)
- NFTs cannot be split into smaller amounts — you own one whole NFT or none

---

## Smart contract architecture

The contract inherits from three OpenZeppelin base contracts:

### `ERC721`
The core NFT standard, providing:
- `ownerOf(tokenId)` — returns who owns a specific NFT
- `balanceOf(address)` — how many NFTs an address owns
- `transferFrom(from, to, tokenId)` — transfer a specific NFT

### `ERC721URIStorage`
Adds the ability to attach a unique metadata link (`tokenURI`) to each individual NFT, instead of all NFTs sharing the same metadata.

### `Ownable`
Restricts minting to the contract deployer (owner) only.

### Custom function

| Function | Access | Description |
|---|---|---|
| `safeMint(to, tokenURI)` | Owner only | Creates a new NFT, assigns it the next available ID, and links it to its metadata |

---

## How metadata and images work

```
Smart contract (on-chain)
      |
      | tokenURI(0) returns →
      ↓
ipfs://<metadata-CID>
      |
      | metadata.json contains →
      ↓
{ "name": ..., "image": "ipfs://<image-CID>", "artist": "shilal" }
      |
      | image field points to →
      ↓
The actual NFT artwork file
```

The blockchain only stores a small link (`tokenURI`). The actual image and JSON file live on IPFS — a distributed, decentralized storage network. This keeps the blockchain lightweight while still making the artwork permanently retrievable.

---

## How to use the NFT

### Add Sepolia + your wallet
Same MetaMask setup as the previous Tokenizer project — Sepolia testnet, funded with free test ETH.

### View your NFT
1. Go to `sepolia.etherscan.io`, search the contract address
2. Click the **Token Transfers (ERC-721)** or **NFT** tab
3. Your minted NFT will be listed with its token ID

### Confirm ownership
In Remix, call:
```
ownerOf(0)
```
This returns the wallet address that currently owns token ID 0.

### View the artwork
Take the `tokenURI` result, replace `ipfs://` with `https://ipfs.io/ipfs/` and open it in a browser to see the metadata JSON, which links to the actual image.

---

## Security model

- **Mint control**: only the owner can create new NFTs.
- **Unique IDs**: a counter (`_nextTokenId`) guarantees no duplicate token IDs.
- **Ownership transfer**: any NFT owner (not just the contract owner) can transfer their own NFT using `transferFrom`.
- **No real funds**: contract lives on Sepolia testnet only.

---

## Dependencies

- Solidity `^0.8.20`
- OpenZeppelin Contracts `v5.x`
  - `@openzeppelin/contracts/token/ERC721/ERC721.sol`
  - `@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol`
  - `@openzeppelin/contracts/access/Ownable.sol`
