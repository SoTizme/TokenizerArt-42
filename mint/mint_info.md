# Minting Information

This folder contains everything related to minting the ShilalNFT42 token: metadata structure, IPFS links, and the minted token's details.

---

## 1. Image

The image used for this NFT contains the number **42**, as required.

| Field          | Value                                  |
|----------------|-----------------------------------------|
| File name      | `shilal_nft42.png`                      |
| IPFS hash      | *(fill in after upload)*                |
| IPFS link      | `ipfs://bafybeicvjcxbz7bol5rflmwmkoytq5qqab4nlznx47eggj6w4wkayatrdy`               |
| Gateway link   | `https://gateway.pinata.cloud/ipfs/bafybeicvjcxbz7bol5rflmwmkoytq5qqab4nlznx47eggj6w4wkayatrdy` |

---

## 2. Metadata JSON

The metadata file describes the NFT and is also uploaded to IPFS. It must include the artist's name (your 42 login) and a title containing "42".

`./metadata.json`:


| Field          | Value                                     |
|----------------|---------------------------------------------|
| Metadata file  | `metadata.json`                            |
| IPFS hash      | *(fill in after upload)*                   |
| IPFS link      | `ipfs://bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va`               |
| Gateway link   | `https://gateway.pinata.cloud/ipfs/bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va` |

---

## 3. Minting the NFT

Once both the image and metadata are uploaded to IPFS:

1. Open Remix → connect to your deployed `ShilalNFT42` contract (see `deployment/how_to_deploy.md`)
2. Find the orange function **`safeMint`**
3. Fill in the inputs:
   ```
   to:       your wallet address (or any recipient)
   tokenURI: ipfs://bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va
   ```
4. Click **safeMint** → confirm in MetaMask
5. Wait for confirmation

---


## 4. Verifying ownership

In Remix, under your deployed contract:

- Call `ownerOf(0)` → should return your wallet address
- Call `tokenURI(0)` → should return your IPFS metadata link
- Call `balanceOf(yourAddress)` → should return `1`
