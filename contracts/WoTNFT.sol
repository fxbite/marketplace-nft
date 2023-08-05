// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract WoTNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter private _itemsSold;
    address public owner;

    constructor() ERC721("World of Tanks", "WOTNFT") {
        owner = msg.sender;
    }

    function createNFT(string memory uri) public returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(owner, newItemId);
        _setTokenURI(newItemId, uri);
        return newItemId;
    }

    function approveNFT(uint256 tokenId) public {
        approve(owner, tokenId);
    }

    function getAllMyNFT() public view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](_tokenIds.current());
        uint256 counter = 0;
        for (uint256 i = 1; i <= _tokenIds.current(); i++) {
            if (ownerOf(i) == owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function getNFTURI(uint256 tokenId) public view returns (string memory) {
        return tokenURI(tokenId);
    }

    function transferNFT(address to, uint256 tokenId) public {
        safeTransferFrom(owner, to, tokenId);
    }
}