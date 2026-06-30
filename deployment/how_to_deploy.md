# How to Deploy ShilalNFT42 (SNFT42)

A complete step-by-step guide — from image creation to a minted NFT on Sepolia testnet.

---

## Tools used

| Tool | Purpose | Link |
|---|---|---|
| MetaMask | Wallet to sign transactions | https://metamask.io |
| Sepolia faucet | Free test ETH | https://cloud.google.com/application/web3/faucet/ethereum/sepolia |
| Remix IDE | Write, compile, deploy the contract | https://remix.ethereum.org |
| Pinata | Upload image & metadata to IPFS | https://pinata.cloud |
| Sepolia Etherscan | View the deployed contract publicly | https://sepolia.etherscan.io |

---

## Contract Address

**Contract Address:** `0xeD8D4EBA286049A9fcFDdfC817676624c63aaEAA`

**Explorer Link:** [View on Sepolia Etherscan](https://sepolia.etherscan.io/address/0xeD8D4EBA286049A9fcFDdfC817676624c63aaEAA)

## Step 1 — Create a MetaMask wallet

1. Go to [https://metamask.io](https://metamask.io) and click **Download**
2. Install the browser extension (Chrome or Firefox recommended)
3. Click **Create a new wallet**
4. Set a strong password
5. **Save your Secret Recovery Phrase (12 words) somewhere safe** — if you lose this, you lose access to your wallet forever
6. Confirm the phrase when asked
7. Your wallet is ready — you will see your public address at the top (starts with `0x...`)

> ⚠️ Never share your Secret Recovery Phrase or private key with anyone.

---

## Step 2 — Enable Sepolia testnet in MetaMask

By default MetaMask hides test networks. To show Sepolia:

1. Open MetaMask → click the **three dots (⋮)** at the top right → **Settings**
2. Go to **Security & Privacy**
3. Scroll down and turn ON **Show test networks**
4. Go back to the main screen
5. Click the network name at the top (it says "Ethereum Mainnet")
6. In the list, select **Sepolia test network**

Your MetaMask is now on Sepolia — you will see "Sepolia" at the top.

---

## Step 3 — Get free test ETH (SepoliaETH)

You need test ETH to pay for gas fees when deploying. It is completely free.

1. Go to [https://cloud.google.com/application/web3/faucet/ethereum/sepolia](https://cloud.google.com/application/web3/faucet/ethereum/sepolia)
2. Sign in with a Google account
3. Paste your MetaMask wallet address in the field (copy it from MetaMask — starts with `0x...`)
4. Click **Request 0.5 ETH**
5. Wait ~30 seconds
6. Open MetaMask → you should see **0.5 SepoliaETH** in your balance

> ℹ️ You can request again after 24 hours if you need more.

---

## Step 4 — Open Remix IDE and create the contract file

1. Go to [https://remix.ethereum.org](https://remix.ethereum.org)
2. In the left panel, under **File Explorer**, Inside the `contracts` folder click the **new file** icon
3. Name the file `ShilalToken42.sol`
4. Paste the full contract code from the `code/ShilalToken42.sol` file in this repository

---

## Step 5 — Compile the contract

1. Click the **Solidity Compiler** tab on the left (icon looks like an "S")
2. Set the compiler version to **0.8.20**
3. Check **Enable optimization** (leave runs at 200)
4. Click **Compile ShilalToken42.sol**
5. You should see a green checkmark — no errors, only a possible SPDX warning which is harmless

---

## Step 6 — Reconnect to your contract anytime (no redeploying)

Your contract lives permanently on Sepolia. To reconnect instead of deploying again:

1. Open Remix, load `ShilalNFT42.sol`, compile
2. Deploy & Run Transactions → Injected Provider (MetaMask) → Sepolia
3. Scroll to **Deployed Contracts** → click **add (+)**
4. Paste your existing contract address
5. The contract loads, ready to use

---

## Step 3 — Verify your NFT

In Remix, under your deployed contract:

- `ownerOf(0)` → should return your wallet address
- `tokenURI(0)` → should return `ipfs://bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va`
- `balanceOf(yourAddress)` → should return `1`

Or Etherscan:

---

## Step 7 — View the actual artwork

Take your metadata IPFS link and open it through a public gateway in your browser:

```
https://gateway.pinata.cloud/ipfs/bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va
```

This shows the JSON file, which contains the `image` field — open that link the same way to see your actual artwork:

```
https://gateway.pinata.cloud/ipfs/bafybeicvjcxbz7bol5rflmwmkoytq5qqab4nlznx47eggj6w4wkayatrdy
```

---

## Important notes

- **Never use real ETH** — Sepolia testnet only
- **IPFS links are permanent** as long as at least one node keeps hosting the file (service Pinata handle this automatically)
- The contract address and network are saved in `deployment/deploy_info.md`
- Minting details (token ID, IPFS links) are saved in `mint/mint_info.md`
