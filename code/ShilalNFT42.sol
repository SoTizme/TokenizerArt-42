// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title ShilalNFT42 - A simple ERC-721 NFT for the 42 TokenizeArt project
/// @notice Deployed on the Ethereum Sepolia testnet for educational purposes only.
///         This NFT has no real monetary value.
contract ShilalNFT42 is ERC721, ERC721URIStorage, Ownable {

    // Counter used to assign a unique ID to each new NFT
    uint256 private _nextTokenId;


    // Sets the NFT collection name, symbol, and the contract owner
    constructor() ERC721("ShilalNFT42", "SNFT42") Ownable(msg.sender) {}


    /// @notice Mint a brand new NFT and assign it a metadata URI (usually an IPFS link)
    /// @param to       The wallet address that will own the new NFT
    /// @param tokenURI A link (e.g. ipfs://...) pointing to the NFT's JSON metadata
    /// @return tokenId The unique ID assigned to the newly minted NFT
    function safeMint(address to, string memory tokenURI) external onlyOwner returns (uint256) {
        require(to != address(0), "ShilalNFT42: mint to the zero address");
        require(bytes(tokenURI).length > 0, "ShilalNFT42: tokenURI cannot be empty");

        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return tokenId;
    }



    // Returns how many NFTs have been minted by this contract
    function totalMinted() external view returns (uint256) {
        return _nextTokenId;
    }



    // Required override because both ERC721 and ERC721URIStorage define tokenURI
    function tokenURI(uint256 tokenId) public view 
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    // Required override because both ERC721 and ERC721URIStorage define supportsInterface
    function supportsInterface(bytes4 interfaceId) public view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
