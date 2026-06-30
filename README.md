# ShilalNFT42 (SNFT42)

A non-fungible token (NFT) created as part of the **42 TokenizeArt** project, in partnership with BNB Chain.

---

## Choices made

### Blockchain platform — Ethereum (Sepolia testnet)
I reused the same platform as my previous Tokenizer project for consistency, tooling familiarity, and because Sepolia behaves exactly like Ethereum mainnet with zero real monetary risk.

### Token standard — ERC-721
ERC-721 is the standard for non-fungible tokens on Ethereum. Unlike ERC-20, each token has a unique ID and its own metadata, making it suitable for representing one-of-a-kind digital assets like artwork.

### Language — Solidity 0.8.20
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

## Repository structure
```
README.md
code/
ShilalNFT42.sol      ← smart contract source
deployment/
how_to_deploy.md     ← step-by-step deployment guide + contract address
mint/
metadata.json        ← final NFT metadata
mint_info.md         ← minting steps, IPFS links, minted token details
documentation/
whitepaper.md        ← NFT overview and architecture
shilal_nft42.png          ← original NFT image
```

---

## Contract info

| Field             | Value                              |
|-------------------|--------------------------------------|
| Collection name   | ShilalNFT42                          |
| Symbol            | SNFT42                               |
| Standard          | ERC-721                              |
| Network           | Ethereum Sepolia testnet             |
| Contract address  | 0xeD8D4EBA286049A9fcFDdfC817676624c63aaEAA  |
| Artist / login    | shilal                               |
| Image storage     | IPFS                                 |