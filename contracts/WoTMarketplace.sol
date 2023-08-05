// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./WoTNFT.sol";
import "./MetalToken.sol";

contract WoTMarketplace {
    address public owner;
    uint256 public totalNFTs;
    WoTNFT public wotNFT;
    MetalToken public metalToken;

    struct ListedToken {
        uint256 tokenId;
        address payable owner;
        address payable seller;
        uint256 price;
        bool currentlyListed;
    }

    event TokenListedSuccess(
        uint256 indexed tokenId,
        address owner,
        address seller,
        uint256 price,
        bool currentlyListed
    );

    mapping(uint256 => ListedToken) public idToListedToken;

    constructor(address wotNFTAddress, address metalTokenAddress) {
        owner = msg.sender;
        wotNFT = WoTNFT(wotNFTAddress);
        metalToken = MetalToken(metalTokenAddress);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function getWOTNFT() public view returns (address) {
        return address(wotNFT);
    }

    function getMetalToken() public view returns (address) {
        return address(metalToken);
    }

    function getListedTokenForId(uint256 tokenId) public view returns (ListedToken memory) {
        return idToListedToken[tokenId];
    }

    function approveNFT(uint256 tokenId) public {
        wotNFT.approve(owner, tokenId);
    }

    function ListedNFT(uint256 tokenId,uint256 price) public returns (ListedToken memory) {
        totalNFTs++;
        idToListedToken[tokenId] = ListedToken(
            tokenId,
            payable(owner),
            payable(owner),
            price,
            true
        );
        emit TokenListedSuccess(tokenId, owner, owner, price, true);
        return idToListedToken[tokenId];
    }

    function getAllListedTokens() public view returns (ListedToken[] memory) {
        ListedToken[] memory listedTokens = new ListedToken[](totalNFTs);
        uint256 counter = 0;
        for (uint256 i = 1; i <= totalNFTs; i++) {
            if (idToListedToken[i].currentlyListed) {
                listedTokens[counter] = idToListedToken[i];
                counter++;
            }
        }
        return listedTokens;
    }

    function buyNFT(uint256 tokenId) public payable {
        ListedToken memory listedToken = idToListedToken[tokenId];
        address seller = listedToken.seller;
        uint256 price = listedToken.price;
        require(
            metalToken.transferFrom(owner, seller, price),
            "Token transfer failed"
        );
        wotNFT.transferFrom(seller, owner, tokenId);
        listedToken.owner = payable(owner);
        listedToken.seller = payable(owner);
        listedToken.currentlyListed = false;
        idToListedToken[tokenId] = listedToken;
    }

    function removeFromMarket(uint256 tokenId) public {
        ListedToken storage listedToken = idToListedToken[tokenId];
        require(
            listedToken.seller == owner,
            "You are not the seller of this token"
        );
        delete idToListedToken[tokenId];
    }

    function getMyNFTs() public view returns (ListedToken[] memory) {
        ListedToken[] memory listedTokens = new ListedToken[](totalNFTs);
        uint256 counter = 0;
        for (uint256 i = 1; i <= totalNFTs; i++) {
            if (idToListedToken[i].owner == owner) {
                listedTokens[counter] = idToListedToken[i];
                counter++;
            }
        }
        return listedTokens;
    }

    function getAllNFTs() public view returns (ListedToken[] memory) {
        ListedToken[] memory listedTokens = new ListedToken[](totalNFTs);
        uint256 counter = 0;
        for (uint256 i = 1; i <= totalNFTs; i++) {
            listedTokens[counter] = idToListedToken[i];
            counter++;
        }
        return listedTokens;
    }

    function transctionNFT(address to, uint256 tokenId) public {
        ListedToken memory listedToken = idToListedToken[tokenId];
        require(
            listedToken.owner == owner,
            "You are not the owner of this NFT"
        );
        wotNFT.transferFrom(owner, to, tokenId);
        listedToken.owner = payable(to);
        listedToken.seller = payable(to);
        idToListedToken[tokenId] = listedToken;
    }

    function editPriceNFT(uint256 tokenId, uint256 price) public {
        ListedToken memory listedToken = idToListedToken[tokenId];
        require(
            listedToken.owner == owner,
            "You are not the owner of this NFT"
        );
        listedToken.price = price;
        idToListedToken[tokenId] = listedToken;
    }
}
