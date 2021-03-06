//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFTs is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // π ν¨μ mintNFT λ λΌμ΄λΈλ¬λ¦¬ Counters λ₯Ό μ΄μ©ν΄ λ³μ ν ν°μ ID(_tokenIds)λ₯Ό κ΄λ¦¬νλ€

    constructor() ERC721("MyNFTs", "MNFT") {}

    // ν¨μ mintNFT λ μ»¨νΈλνΈ MyNFTs μ ν¬ν¨λ ν¨μμ΄λ€
    // μ΄ ν¨μλ μ»¨νΈλνΈμ μ€λ(owner)λ§μ΄ μλ‘μ΄ ν ν°μ μμ±ν  μ μκ²νλ ν¨μμ΄λ€
    // π ν¨μ mintNFT λ μ»¨νΈλνΈ Ownable μ ν¬ν¨λ onlyOwnerλ₯Ό ν΅ν΄,
    // π ν¨μλ₯Ό μ€νν μ§κ°μ μ£Όμμ μ€λμ μ£Όμκ° κ°μμ§ κ²μ¬νλ€
    // π λ§μ½ ν¨μλ₯Ό μ€νν μ§κ°μ μ£Όμμ μ€λμ μ£Όμκ° κ°λ€λ©΄, ν¨μλ₯Ό μ μμ μΌλ‘ μ€ννλ€
    function mintNFT(address recipient, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
// NFTλ₯Ό μμ±ν  λ, νλΌλ―Έν° tokenURI λ₯Ό μ λ¬νλ€
// tokenURI λ NFTμ μ μ©ν  μ λ³΄λ₯Ό λ΄κ³  μλ json κ°μ²΄μ μλν¬μΈνΈμ΄λ€
// λ€μ λ§ν΄, tokenURI μ μ κ·Όνλ©΄ NFTμ κ·μΉμ λ§λ json κ°μ²΄λ₯Ό λΆλ¬μ¬ μ μμ΄μΌ ν¨
