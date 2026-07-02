// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/// @title ShilalNFT42Onchain - Bonus version of ShilalNFT42 with fully on-chain metadata + image
/// @notice Image and metadata are generated and stored entirely on-chain as an SVG + base64 JSON.
contract ShilalNFT42Onchain is ERC721, Ownable {
    using Strings for uint256;

    // Counter used to assign a unique ID to each new NFT
    uint256 private _nextTokenId;

    // Small accent palette so each token's artwork looks slightly different.
    string[5] private _palette = [
        "#bcd9e8", // pale blue
        "#e8c8bc", // pale orange
        "#c8e8bc", // pale green
        "#d9bce8", // pale purple
        "#e8e0bc"  // pale yellow
    ];

    // Sets the NFT collection name, symbol, and the contract owner
    constructor() ERC721("ShilalNFT42Onchain", "SNFT42B") Ownable(msg.sender) {}

    /// @notice Mint a new fully on-chain NFT.
    /// @param to The wallet address that will receive the new NFT
    /// @return tokenId The unique ID assigned to the newly minted NFT
    function safeMint(address to) external onlyOwner returns (uint256) {
        require(to != address(0), "ShilalNFT42Onchain: mint to the zero address");
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        return tokenId;
    }

    // Returns how many NFTs have been minted by this contract
    function totalMinted() external view returns (uint256) {
        return _nextTokenId;
    }

    /// @notice Returns the fully on-chain metadata for a token as a base64-encoded data URI.
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        string memory svg = _generateSVG(tokenId);
        string memory accent = _accentColor(tokenId);

        bytes memory json = abi.encodePacked(
            '{"name":"ShilalNFT42 #', tokenId.toString(), ' - 42 On-Chain",',
            '"description":"Fully on-chain NFT minted for the 42 TokenizeArt bonus part. ',
            'Image and metadata are generated and stored entirely on the blockchain.",',
            '"image":"data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '",',
            '"attributes":[',
                '{"trait_type":"Artist","value":"shilal"},',
                '{"trait_type":"Accent Color","value":"', accent, '"},',
                '{"trait_type":"Storage","value":"Fully on-chain"}',
            ']}'
        );

        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(json)));
    }

    /// @notice Returns the raw SVG markup for a token. Handy for the mint website to
    ///         render the image directly without decoding the full JSON metadata first.
    function tokenSVG(uint256 tokenId) external view returns (string memory) {
        _requireOwned(tokenId);
        return _generateSVG(tokenId);
    }

    // Builds a low-poly "42" emblem.
    function _generateSVG(uint256 tokenId) internal view returns (string memory) {
        string memory accent = _accentColor(tokenId);
        string memory x1 = (40 + (tokenId % 30)).toString();

        return string(abi.encodePacked(
            "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 350 500'>",
            "<rect width='350' height='500' fill='#0a0a0a'/>",
            "<polygon points='", x1, ",40 310,90 280,460 60,420' fill='#1c1c1c'/>",
            "<polygon points='", x1, ",40 180,20 200,180 60,150' fill='#2a2a2a'/>",
            "<polygon points='220,260 310,90 280,460' fill='", accent, "' opacity='0.85'/>",
            "<polygon points='60,420 200,300 280,460' fill='#333333'/>",
            "<text x='175' y='300' font-family='Helvetica, Arial, sans-serif' font-size='110' ",
            "font-weight='bold' fill='#f5f5f5' text-anchor='middle'>42</text>",
            "</svg>"
        ));
    }

    function _accentColor(uint256 tokenId) internal view returns (string memory) {
        return _palette[tokenId % _palette.length];
    }
}
