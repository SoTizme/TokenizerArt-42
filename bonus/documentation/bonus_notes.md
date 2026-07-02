# ShilalNFT42 — Bonus Part

Documentation for the bonus part of the **42 TokenizeArt** project: on-chain metadata
("Inscriptions"), a richer NFT image, and a minimal mint website with a graphical interface.

---

## Contract info

| Field             | Value                              |
|-------------------|--------------------------------------|
| Collection name   | ShilalNFT42Onchain                   |
| Symbol            | SNFT42B                              |
| Standard          | ERC-721                              |
| Network           | Ethereum Sepolia testnet             |
| Contract address  | 0xb9fFC94D4E517730d2Ae0312D41Cc2DFbDAd82F5           |
| Artist / login    | shilal                               |
| Image storage     | Fully on-chain (SVG, base64-encoded) |
| Metadata storage  | Fully on-chain (JSON, base64-encoded)|

---

## Repository structure (bonus)

```
bonus/
    code/
        ShilalNFT42Onchain.sol
    website/
        mint.html
    documentation/
        bonus_notes.md
```

---

## Choices made

### Separate contract — `ShilalNFT42Onchain.sol`
The mandatory contract (`ShilalNFT42.sol`) is already deployed and graded, so it was left
untouched. The bonus is implemented as a second, independent contract rather than a
modification of the original, to avoid any risk of breaking the mandatory submission.

### Fully on-chain metadata — no IPFS
Instead of `ERC721URIStorage` pointing to an external `tokenURI`, this version generates
the JSON metadata and the image on the fly, directly inside the contract, and returns them
as a `data:application/json;base64,...` URI. There is no dependency on IPFS, a pinning
service, or any external link — anyone can read the full NFT (image included) straight
from chain state. This satisfies the "NFT Inscriptions" bonus requirement.

### SVG instead of a raster image
The original PNG artwork was rebuilt as an SVG: a low-poly "42" emblem matching the same
visual identity as the mandatory NFT. SVG was chosen over PNG because storing a raster
image on-chain would make the contract far more expensive to deploy and read; an SVG is a
compact text format that's cheap to store and still renders crisply in wallets, explorers,
and marketplaces.

### Per-token variation
Each token's accent color and a small layout offset are derived deterministically from its
`tokenId` (no off-chain randomness needed), so every mint looks slightly different while
staying visually consistent with the collection.

### Security — owner-only mint
`safeMint` keeps the same `onlyOwner` restriction as the mandatory contract, so only the
deployer can mint. This keeps the access-control story consistent across both contracts:
new tokens are only ever created by the project owner, and ownership of an existing token
can be confirmed by anyone via the standard `ownerOf` function.

### Mint website — plain HTML/JS, no build step
The mint website (`mint.html`) is a single self-contained file using `ethers.js` loaded
from a CDN, with no framework, bundler, or `npm install` required. It was kept deliberately
simple: connect a wallet, mint to an address, and look up an existing token by ID. This
matches the project's "minimalist actions to demonstrate operation" requirement and means
the site can be opened directly in a browser for the defense.

---

## How to verify

1. Deploy `ShilalNFT42Onchain.sol` to Sepolia (Remix, same workflow as the mandatory part).
2. Call `safeMint(<address>)` from the owner wallet.
3. Call `tokenURI(<tokenId>)` and decode the returned base64 string — it should contain
   valid JSON with an `image` field that itself decodes to a renderable SVG.
4. Open `mint.html`, paste in the deployed contract address, connect the same wallet, and
   confirm the **Mint** and **Look Up** actions both work against the live contract.