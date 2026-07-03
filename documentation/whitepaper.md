# ShilalNFT42 (SNFT42) — Whitepaper

## Overview

This document describes the technical architecture of **ShilalNFT42 (SNFT42)**, the mandatory ERC-721 implementation developed for the **42 TokenizeArt** project.

The contract follows the ERC-721 standard and stores NFT metadata and artwork using **IPFS**, while leveraging audited OpenZeppelin contracts to provide ownership management, metadata support, and access control.

For deployment instructions, refer to `deployment/how_to_deploy.md`.

For the fully on-chain bonus implementation, refer to `bonus/documentation/bonus_notes.md`.

---

# Smart Contract Architecture

The contract is built by extending three OpenZeppelin contracts, each responsible for a specific aspect of the NFT implementation.

```text
                   ShilalNFT42
                        │
        ┌───────────────┼───────────────┐
        │               │               │
        ▼               ▼               ▼
     ERC721      ERC721URIStorage    Ownable
        │               │               │
        └───────────────┴───────────────┘
                        │
                        ▼
               safeMint(to, uri)
```

---

## ERC721

`ERC721` provides the core NFT functionality defined by the ERC-721 standard.

Its responsibilities include:

* Tracking NFT ownership.
* Managing token transfers.
* Maintaining balances for each owner.
* Providing the standard ERC-721 interface recognized by wallets and marketplaces.

---

## ERC721URIStorage

`ERC721URIStorage` extends the base ERC-721 implementation by allowing each token to reference its own metadata through a unique `tokenURI`.

Rather than storing metadata directly on the blockchain, the contract stores a URI pointing to a JSON document hosted on IPFS.

This approach significantly reduces on-chain storage while keeping NFT metadata decentralized.

---

## Ownable

`Ownable` provides a simple access-control mechanism.

Only the contract owner is authorized to mint new NFTs through the custom `safeMint()` function.

This prevents unauthorized token creation while leaving ownership transfers fully compliant with the ERC-721 standard.

---

# Contract Functions

The contract introduces one custom function while inheriting the standard ERC-721 interface.

| Function                           | Purpose                                                    |
| ---------------------------------- | ---------------------------------------------------------- |
| `safeMint(address to, string uri)` | Creates a new NFT and associates it with its metadata URI. |
| `ownerOf(tokenId)`                 | Returns the owner of a specific NFT.                       |
| `balanceOf(owner)`                 | Returns the number of NFTs owned by an address.            |
| `tokenURI(tokenId)`                | Returns the metadata URI associated with a token.          |
| `transferFrom(from, to, tokenId)`  | Transfers ownership of an NFT.                             |

---

# Metadata Architecture

The mandatory implementation stores metadata and artwork using IPFS.

The smart contract stores only a metadata URI.

```text
Smart Contract
       │
       ▼
tokenURI(tokenId)
       │
       ▼
ipfs://metadata.json
       │
       ▼
Metadata
 ├── name
 ├── description
 ├── attributes
 └── image
         │
         ▼
 ipfs://image.png
```

When an application requests an NFT, it first retrieves the metadata URI from the smart contract. The metadata JSON is then loaded from IPFS, where it provides information about the NFT and the location of the associated artwork.

This separation keeps the smart contract lightweight while preserving decentralized storage for both metadata and images.

---

# Security Model

## Controlled Minting

Only the contract owner can create new NFTs through the `safeMint()` function.

This restriction ensures that every NFT in the collection is intentionally issued by the project owner.

---

## Unique Token Identifiers

Each newly minted NFT receives a unique token identifier generated from an incrementing counter.

This guarantees that no two NFTs share the same identifier.

---

## Ownership

Ownership is managed entirely by the ERC-721 implementation.

Once minted, NFTs can be transferred between users using the standard transfer functions provided by the protocol.

---

## Decentralized Metadata

Although metadata is stored off-chain, it resides on IPFS rather than a traditional centralized server.

This improves resilience and avoids dependence on a single hosting provider.

---

# Conclusion

The mandatory implementation of **ShilalNFT42** demonstrates a clean and standards-compliant ERC-721 architecture.

By combining OpenZeppelin's audited contracts with decentralized IPFS storage, the project separates blockchain logic from asset storage while remaining fully compatible with the Ethereum ecosystem. This design provides a secure, lightweight, and maintainable foundation for NFT development.
