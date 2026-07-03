# Mint Assets

This directory contains the assets used to mint the mandatory **ShilalNFT42** NFT.

The NFT follows the ERC-721 metadata standard, where the smart contract stores a metadata URI (`tokenURI`) that points to a JSON document hosted on IPFS.

---

# Directory Contents

```text
mint/
├── README.md
├── metadata.json
└── shilal_nft42.png
```

## `metadata.json`

This file contains the metadata associated with the NFT.

It includes:

* NFT name
* Description
* Artist (`shilal`)
* Image URI
* Additional metadata required by the ERC-721 standard

After `metadata.json` is uploaded to IPFS, it receives a unique **Content Identifier (CID)**. This CID is then referenced as an IPFS URI (`ipfs://<CID>`), which is passed to the `safeMint()` function as the NFT's `tokenURI`.

For example:

```text
CID
bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va

↓

IPFS URI (tokenURI)
ipfs://bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va

↓

safeMint(
    recipient,
    tokenURI
)

---

## `shilal_nft42.png`

This is the artwork associated with the NFT.

The image satisfies the project requirement by clearly including the number **42**.

Before minting, the image is uploaded to IPFS, and its URI is referenced inside `metadata.json`.

---

# Minting Process

The relationship between the assets is illustrated below.

```text
shilal_nft42.png
        │
        ▼
 Uploaded to IPFS
        │
        ▼
metadata.json (image field → ipfs://...)
        │
        ▼
 Uploaded to IPFS
        │
        ▼
safeMint(recipient, tokenURI)
        │
        ▼
Smart Contract

```

The smart contract stores only the metadata URI. Applications retrieve the metadata from IPFS, which in turn references the NFT artwork.

---

# Related Documentation

For additional information, refer to:

* `README.md` — Project overview
* `documentation/whitepaper.md` — Smart contract architecture
* `deployment/how_to_deploy.md` — Deployment and minting guide
* `bonus/documentation/bonus_notes.md` — Bonus implementation
