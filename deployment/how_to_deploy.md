# How to Deploy ShilalNFT42 (SNFT42)

A complete step-by-step guide — from image creation to a minted NFT on Sepolia testnet.

---

## Tools used

| Tool | Purpose | Link |
|---|---|---|
| MetaMask | Wallet to sign transactions | https://metamask.io |
| Sepolia faucet | Free test ETH | https://cloud.google.com/application/web3/faucet/ethereum/sepolia |
| Remix IDE | Write, compile, deploy the contract | https://remix.ethereum.org |
| NFT.Storage or Pinata | Upload image & metadata to IPFS | https://nft.storage or https://pinata.cloud |
| Sepolia Etherscan | View the deployed contract publicly | https://sepolia.etherscan.io |

---

## Step 1 — MetaMask and Sepolia setup

Already done if you completed the Tokenizer project — same wallet, same network. If needed:

1. Install MetaMask, create a wallet, save your recovery phrase safely
2. Enable **Show test networks** in Settings → Security & Privacy
3. Switch network to **Sepolia**
4. Get free test ETH from the [Google faucet](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)

---

## Step 2 — Create your NFT image

Create an image containing the number **42** somewhere in it. Any style is allowed as long as it is not insulting. Save it as `.png` or `.jpg`.

---

## Step 3 — Upload the image to IPFS

1. Go to [https://nft.storage](https://nft.storage) (or Pinata)
2. Sign up for a free account
3. Click **Upload** → select your image file
4. Once uploaded, copy the **CID** (Content Identifier) — a long string like `bafybeigdyrzt5...`
5. Your image's IPFS link is:
   ```
   ipfs://<your-image-CID>
   ```

---

## Step 4 — Create and upload the metadata file

Create a file named `metadata.json` on your computer:

```json
{
  "name": "ShilalArt42 #1",
  "description": "An original digital artwork created for the 42 TokenizeArt project.",
  "image": "ipfs://<your-image-CID>",
  "artist": "shilal",
  "attributes": [
    { "trait_type": "Project", "value": "TokenizeArt" },
    { "trait_type": "Network", "value": "Sepolia" }
  ]
}
```

Replace `<your-image-CID>` with the real CID from Step 3.

1. Upload this `metadata.json` file to IPFS the same way (nft.storage or Pinata)
2. Copy its CID too
3. Your metadata's IPFS link is:
   ```
   ipfs://<your-metadata-CID>
   ```

> This is the link you will pass into `safeMint` later.

---

## Step 5 — Open Remix and create the contract file

1. Go to [https://remix.ethereum.org](https://remix.ethereum.org)
2. Create a new file `ShilalNFT42.sol`
3. Paste the contract code from `code/ShilalNFT42.sol`

---

## Step 6 — Compile

1. Go to the **Solidity Compiler** tab
2. Set version to **0.8.20**
3. Enable **Optimization**
4. Click **Compile ShilalNFT42.sol**

---

## Step 7 — Deploy

1. Go to **Deploy & Run Transactions**
2. Environment: **Injected Provider — MetaMask**
3. Connect MetaMask, confirm network is **Sepolia**
4. This contract's constructor takes no arguments
5. Click **Deploy** → confirm in MetaMask
6. Wait for confirmation, then copy the contract address from **Deployed Contracts**

---

## Step 8 — Mint your NFT

1. Under **Deployed Contracts**, expand your contract
2. Find the orange function **`safeMint`**
3. Fill in:
   ```
   to:       your wallet address
   tokenURI: ipfs://<your-metadata-CID>
   ```
4. Click **safeMint** → confirm in MetaMask
5. Wait for confirmation — your NFT now exists with token ID `0`

---

## Step 9 — Verify your NFT

In Remix, under your deployed contract:

- `ownerOf(0)` → should return your wallet address
- `tokenURI(0)` → should return `ipfs://<your-metadata-CID>`
- `balanceOf(yourAddress)` → should return `1`

On Etherscan:

1. Go to [https://sepolia.etherscan.io](https://sepolia.etherscan.io)
2. Search your contract address
3. Check the **NFT Transfers** tab — your mint transaction should appear

---

## Step 10 — View the actual artwork

Take your metadata IPFS link and open it through a public gateway in your browser:

```
https://ipfs.io/ipfs/<your-metadata-CID>
```

This shows the JSON file, which contains the `image` field — open that link the same way to see your actual artwork:

```
https://ipfs.io/ipfs/<your-image-CID>
```

---

## Step 11 — Reconnecting later (no redeploying)

Your contract lives permanently on Sepolia. To reconnect instead of deploying again:

1. Open Remix, load `ShilalNFT42.sol`, compile
2. Deploy & Run Transactions → Injected Provider (MetaMask) → Sepolia
3. Scroll to **Deployed Contracts** → click **add (+)**
4. Paste your existing contract address
5. The contract loads, ready to use

---

## Important notes

- **Never use real ETH** — Sepolia testnet only
- **Keep your deployer wallet safe** — only it can call `safeMint`
- **IPFS links are permanent** as long as at least one node keeps hosting the file (services like nft.storage/Pinata handle this automatically)
- The contract address and network are saved in `deployment/deploy_info.md`
- Minting details (token ID, IPFS links) are saved in `mint/mint_info.md`
