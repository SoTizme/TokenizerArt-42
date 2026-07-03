# ShilalNFT42 — Bonus Documentation

This document describes the **bonus implementation** of **ShilalNFT42**, developed for the **42 TokenizeArt** project.

Unlike the mandatory version, which stores NFT metadata and artwork on IPFS, this implementation stores both the metadata and the artwork entirely on-chain. It also includes a lightweight web interface for minting and viewing NFTs.

> **Note**
>
> This document covers only the bonus implementation (`ShilalNFT42Onchain.sol`).
>
> The mandatory contract (`ShilalNFT42.sol`) and its deployment process are documented separately in `deployment/how_to_deploy.md`.

---

# Contract Information

| Field            | Value                                        |
| ---------------- | -------------------------------------------- |
| Contract         | ShilalNFT42Onchain                           |
| Symbol           | SNFT42B                                      |
| Standard         | ERC-721                                      |
| Network          | Ethereum Sepolia                             |
| Contract Address | `0xb9fFC94D4E517730d2Ae0312D41Cc2DFbDAd82F5` |
| Image Storage    | Fully On-Chain                               |
| Metadata Storage | Fully On-Chain                               |

---

# Overview

The bonus contract demonstrates an alternative approach to NFT storage.

Instead of referencing external resources hosted on IPFS, the smart contract generates both the metadata and the artwork directly on-chain. Every NFT is therefore completely self-contained and can be reconstructed solely from blockchain data.

The implementation also includes a browser-based minting application that interacts directly with the deployed contract using MetaMask and `ethers.js`.

---

# Architecture

```text id="fjj70m"
                User
                  │
                  ▼
             mint.html
                  │
              ethers.js
                  │
                  ▼
     ShilalNFT42Onchain.sol
          │            │
          │            │
          ▼            ▼
    Base64 JSON    Base64 SVG
          │
          ▼
      tokenURI()
```

---

# Design Decisions

## Fully On-Chain Metadata

The mandatory implementation stores a URI pointing to metadata hosted on IPFS.

The bonus implementation removes this dependency entirely.

The `tokenURI()` function dynamically generates a JSON document, encodes it using Base64, and returns it as a `data:application/json;base64,...` URI. No external storage or pinning service is required.

---

## Fully On-Chain Artwork

Instead of storing a PNG image on IPFS, the artwork is generated as an SVG directly inside the smart contract.

The SVG is then Base64 encoded and embedded into the metadata returned by `tokenURI()`.

This approach guarantees that both the artwork and its metadata remain permanently available as long as the blockchain exists.

---

## SVG Instead of PNG

SVG was selected because it is a text-based vector format.

Compared to raster images such as PNG, SVG significantly reduces storage requirements while remaining fully supported by wallets, block explorers, and NFT marketplaces.

This makes it a practical choice for on-chain NFTs.

---

## Deterministic NFT Variations

Each NFT includes small visual differences generated from its `tokenId`.

These variations include:

* Accent color
* Minor layout offsets

Because they are derived deterministically from the token identifier, the same NFT will always render identically without requiring randomness or off-chain computation.

---

## Owner-Only Minting

The contract uses OpenZeppelin's `Ownable` module.

Only the contract owner can execute `safeMint()`, matching the security model used by the mandatory implementation.

Ownership of every NFT can be verified using the standard ERC-721 functions such as `ownerOf()`.

---

# Mint Website

The repository includes a lightweight browser application located at:

```text id="zhmccm"
bonus/website/mint.html
```

The website was intentionally designed without a build system or external framework.

It consists of a single HTML file that loads `ethers.js` from a CDN and allows users to:

* Connect MetaMask
* Mint NFTs
* Look up existing NFTs
* Retrieve metadata directly from the deployed smart contract

This minimalist approach satisfies the project requirements while making the application easy to demonstrate during evaluation.

---

# Running the Website

From the project root:

```bash
./bonus/run.sh
```

Then open:

```
http://localhost:8080/mint.html
```

The script starts a local Python HTTP server in the `bonus/website` directory.

> **Note:** If the script is not executable, run:
>
> ```bash
> chmod +x bonus/run.sh
> ```

> **Important**
>
> Always use `http://localhost` instead of opening the file directly with `file://`.
>
> Browsers block MetaMask and `ethers.js` interactions when local files are opened directly.

---

# Verifying the Bonus Contract

After deployment:

1. Connect the owner wallet to Remix.
2. Call:

```text id="n40xkp"
safeMint(<recipient>)
```

3. Retrieve the generated metadata:

```text id="rl7vko"
tokenURI(<tokenId>)
```

The returned value should be a Base64-encoded JSON document.

After decoding it, the JSON should contain an `image` field.

The value of this field is itself a Base64-encoded SVG image representing the NFT artwork.

---

# Current Deployment

| Item             | Value                                        |
| ---------------- | -------------------------------------------- |
| Network          | Ethereum Sepolia                             |
| Contract Address | `0xb9fFC94D4E517730d2Ae0312D41Cc2DFbDAd82F5` |
| Storage          | Fully On-Chain                               |
| Metadata         | Generated dynamically by `tokenURI()`        |
| Artwork          | Embedded Base64 SVG                          |

---

# Bonus Features Summary

Compared to the mandatory implementation, this version provides:

* Fully on-chain metadata generation
* Fully on-chain SVG artwork
* Dynamic `tokenURI()` implementation
* Deterministic artwork variations
* Browser-based minting interface
* No dependency on IPFS or external storage

These additions demonstrate how an ERC-721 NFT can remain entirely self-contained while still complying with the standard and remaining compatible with existing wallets and blockchain explorers.
