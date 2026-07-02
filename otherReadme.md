# ShilalNFT42 (SNFT42)

A non-fungible token (NFT) created as part of the **42 TokenizeArt** project, in partnership with BNB Chain.

---

## Choices made

### Blockchain platform — Ethereum (Sepolia testnet)
I reused the same platform as my previous Tokenizer project for consistency, tooling familiarity, and because Sepolia behaves exactly like Ethereum mainnet with zero real monetary risk.

### Token standard — ERC-721
ERC-721 is the standard for non-fungible tokens on Ethereum. Unlike ERC-20, each token has a unique ID and its own metadata, making it suitable for representing one-of-a-kind digital assets like artwork.

### Language — Solidity 0.8.34
Includes built-in overflow protection.

### Framework — OpenZeppelin + Remix IDE
I used OpenZeppelin's audited `ERC721`, `ERC721URIStorage`, and `Ownable` base contracts instead of writing the NFT logic from scratch. `ERC721URIStorage` specifically allows storing a unique metadata link (`tokenURI`) for every individual NFT.

### Metadata & image storage — IPFS
The NFT image and its metadata JSON file are stored on IPFS (InterPlanetary File System), a distributed storage network. This satisfies the requirement to avoid centralized storage — if a normal web server goes offline, the file would disappear; IPFS keeps it available as long as at least one node hosts it.

### Security considerations
- **Ownable**: only the deployer can mint new NFTs, preventing unauthorized creation.
- **Unique token IDs**: each mint increments a counter, guaranteeing no two NFTs share an ID.
- **No real funds**: deployed and tested exclusively on Sepolia testnet.

---

## Bonus — On-chain metadata & mint website

### Fully on-chain metadata — no IPFS
The bonus contract (`ShilalNFT42Onchain.sol`) generates the image and metadata entirely inside the contract. `tokenURI()` returns a `data:application/json;base64,...` URI with the SVG image embedded inline — no IPFS link, no external dependency of any kind.

### SVG instead of a raster image
The artwork was rebuilt as an SVG: compact text format, cheap to store on-chain, and renders crisply in any wallet or explorer. Each token gets a slightly different accent color and layout offset derived deterministically from its `tokenId`, so every mint looks unique without any off-chain randomness.

### Mint website — plain HTML/JS, no build step
A single self-contained `mint.html` file using `ethers.js` loaded from a CDN — no framework or `npm install` required. Connect a wallet, mint to an address, and preview the on-chain SVG artwork directly in the browser.

#### Run locally
```bash
cd bonus/website
python3 -m http.server 8080
```
Then open `http://localhost:8080/mint.html`.

> ⚠️ Always use `http://localhost` — opening via `file://` blocks MetaMask and the ethers.js library.

---

## Repository structure

```
README.md
shilal_nft42.png               ← original NFT image
code/
    ShilalNFT42.sol            ← mandatory smart contract
deployment/
    how_to_deploy.md           ← step-by-step deployment guide
mint/
    metadata.json              ← NFT metadata (uploaded to IPFS)
    mint_info.md               ← minting steps, IPFS links, token details
documentation/
    whitepaper.md              ← NFT overview and architecture
bonus/
    code/
        ShilalNFT42Onchain.sol ← fully on-chain NFT contract (bonus)
    website/
        mint.html              ← browser mint interface (bonus)
    documentation/
        bonus_notes.md         ← bonus design decisions
```

---

## Contract info

### Mandatory

| Field            | Value                                        |
|------------------|----------------------------------------------|
| Collection name  | ShilalNFT42                                  |
| Symbol           | SNFT42                                       |
| Standard         | ERC-721                                      |
| Network          | Ethereum Sepolia testnet                     |
| Contract address | 0xeD8D4EBA286049A9fcFDdfC817676624c63aaEAA   |
| Artist / login   | shilal                                       |
| Image storage    | IPFS                                         |
| Metadata storage | IPFS                                         |

### Bonus

| Field            | Value                                        |
|------------------|----------------------------------------------|
| Collection name  | ShilalNFT42Onchain                           |
| Symbol           | SNFT42B                                      |
| Standard         | ERC-721                                      |
| Network          | Ethereum Sepolia testnet                     |
| Contract address | 0xb9fFC94D4E517730d2Ae0312D41Cc2DFbDAd82F5   |
| Artist / login   | shilal                                       |
| Image storage    | Fully on-chain (SVG, base64-encoded)         |
| Metadata storage | Fully on-chain (JSON, base64-encoded)        |