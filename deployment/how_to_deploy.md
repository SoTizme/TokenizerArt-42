# Deploying ShilalNFT42 (Mandatory Contract)

This guide explains how to deploy and interact with the **mandatory** version of **ShilalNFT42**, which stores NFT metadata and artwork on **IPFS**.

> **Note**
>
> This guide covers **only the mandatory implementation** (`ShilalNFT42.sol`).
>
> The bonus implementation (`ShilalNFT42Onchain.sol`), which stores metadata and artwork entirely on-chain, is documented separately in `bonus/documentation/bonus_notes.md`.

---

# Prerequisites

Before deploying, make sure you have:

* A MetaMask wallet
* Sepolia test ETH
* Access to Remix IDE
* A Pinata account (for uploading files to IPFS)

---

# Tools

| Tool                  | Purpose                                  |
| --------------------- | ---------------------------------------- |
| MetaMask              | Wallet used to sign transactions         |
| Remix IDE             | Compile and deploy the smart contract    |
| Pinata                | Upload artwork and metadata to IPFS      |
| Google Sepolia Faucet | Obtain free Sepolia ETH                  |
| Sepolia Etherscan     | View deployed contracts and transactions |

---

# Contract Information

| Field    | Value            |
| -------- | ---------------- |
| Contract | ShilalNFT42      |
| Standard | ERC-721          |
| Network  | Ethereum Sepolia |
| Solidity | 0.8.34           |

---

# Step 1 — Create a MetaMask Wallet

If you already have a MetaMask wallet, you can skip this step.

1. Install the MetaMask browser extension.
2. Create a new wallet.
3. Choose a secure password.
4. Save your Secret Recovery Phrase in a safe location.
5. Finish the setup.

> ⚠️ Never share your Secret Recovery Phrase or private key.

---

# Step 2 — Enable the Sepolia Test Network

1. Open MetaMask.
2. Navigate to **Settings → Security & Privacy**.
3. Enable **Show test networks**.
4. Return to the main wallet screen.
5. Select **Ethereum Sepolia** as the active network.

---

# Step 3 — Obtain Sepolia ETH

Deployment requires test ETH to pay transaction fees.

1. Open the Google Sepolia Faucet.
2. Sign in.
3. Paste your wallet address.
4. Request test ETH.
5. Wait for the balance to appear in MetaMask.

---

# Step 4 — Upload the NFT to IPFS

Before deploying, upload both files to IPFS using Pinata.

Upload:

* NFT image
* `metadata.json`

After uploading, note:

* Image CID
* Metadata CID

The metadata should reference the uploaded image using an `ipfs://` URI.

---

# Step 5 — Open Remix IDE

1. Open Remix IDE.
2. Create a new Solidity file named:

```text
ShilalNFT42.sol
```

3. Copy the contract from:

```text
code/ShilalNFT42.sol
```

4. Paste it into Remix.

---

# Step 6 — Compile the Contract

1. Open the **Solidity Compiler** tab.
2. Select compiler version **0.8.34**.
3. Enable optimization.
4. Compile **ShilalNFT42.sol**.

Compilation should complete without errors.

---

# Step 7 — Deploy the Contract

1. Open **Deploy & Run Transactions**.
2. Select:

```
Injected Provider - MetaMask
```

3. Ensure MetaMask is connected to the **Sepolia** network.
4. Select **ShilalNFT42**.
5. Click **Deploy**.
6. Confirm the transaction in MetaMask.

After confirmation, Remix will display the deployed contract.

---

# Step 8 — Mint an NFT

Expand the deployed contract and call:

```
safeMint(address to, string uri)
```

Parameters:

| Parameter | Value                    |
| --------- | ------------------------ |
| `to`      | Recipient wallet address |
| `uri`     | Metadata IPFS URI        |

Example:

```text
ipfs://bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va
```

Confirm the transaction in MetaMask.

---

# Step 9 — Verify the NFT

The following functions can be called from Remix.

### Check the owner

```
ownerOf(0)
```

Returns the owner's wallet address.

---

### Check the metadata

```
tokenURI(0)
```

Returns the IPFS metadata URI.

---

### Check the balance

```
balanceOf(<wallet>)
```

Returns the number of NFTs owned by the specified wallet.

---

# Reconnecting to an Existing Contract

If the contract has already been deployed, there is no need to deploy it again.

1. Compile the contract in Remix.
2. Open **Deploy & Run Transactions**.
3. Connect MetaMask using **Injected Provider**.
4. Under **Deployed Contracts**, click **At Address**.
5. Paste the deployed contract address.

Current deployment:

```text
0xeD8D4EBA286049A9fcFDdfC817676624c63aaEAA
```

The contract interface will immediately become available.

---

# Current Deployment

| Item             | Value                                                                |
| ---------------- | -------------------------------------------------------------------- |
| Network          | Ethereum Sepolia                                                     |
| Contract Address | `0xeD8D4EBA286049A9fcFDdfC817676624c63aaEAA`                         |
| Metadata         | `ipfs://bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va` |
| Image            | `ipfs://bafybeicvjcxbz7bol5rflmwmkoytq5qqab4nlznx47eggj6w4wkayatrdy` |

---

# Viewing the NFT

Open the metadata through an IPFS gateway:

```text
https://gateway.pinata.cloud/ipfs/bafkreicyilrbckkxywftgb4zfaari43nulqgigs65afc5wqej5dcmg55va
```

The JSON contains an `image` field pointing to the NFT artwork.

Open the image using:

```text
https://gateway.pinata.cloud/ipfs/bafybeicvjcxbz7bol5rflmwmkoytq5qqab4nlznx47eggj6w4wkayatrdy
```

---

# Notes

* Deploy only to the **Ethereum Sepolia Testnet**.
* Never use real ETH.
* Only the contract owner can mint new NFTs.
* The deployed contract remains permanently accessible through its address and can be reloaded in Remix at any time.
