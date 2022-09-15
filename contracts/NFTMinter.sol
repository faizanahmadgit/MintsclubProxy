// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract NFTMinter is ERC1155URIStorageUpgradeable, UUPSUpgradeable, OwnableUpgradeable
{
    using CountersUpgradeable for CountersUpgradeable.Counter;
    string public name;
   
   // mapping(uint256=> bool) isTransferred ;

    mapping(uint256 => string)  private _tokenURIs;

    CountersUpgradeable.Counter private _tokenIdCounter;

    
    function initialize(string memory _name) public initializer {
       name = _name;
       __Ownable_init();
      
    }
    

    function setName(string memory _name) public
    {
        name = _name; // Collection name
    }

    

//Minting Functions
    function mint(address account , uint256 amount , string memory tokenuri)public 
    {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _mint(account,tokenId,amount,"0x00");
        _setURI(tokenId, tokenuri);
        //setApprovalForAll(operator, true);

    
    }
//////////////remove array from tokenuri
    function mintBatch(address to, uint256[] memory amounts, string[] memory tokenUri)public 
    {
        uint[] memory tokenId = new uint[](amounts.length);
        for (uint i = 0; i < amounts.length; i++){
            _tokenIdCounter.increment();
            tokenId[i] = _tokenIdCounter.current();
            _setURI(tokenId[i], tokenUri[i]);
        }
         _mintBatch(to, tokenId, amounts, "0x00");
        //setApprovalForAll(operator, true);
             
    }
// function safeTransferFrom(
//         address from,
//         address to,
//         uint256 id,
//         uint256 amount,
//         bytes memory data
//     ) public virtual override {
//         super.safeTransferFrom(from, to, id, amount, data);
//         isTransferred[id] = true;

//     }

//     function safeBatchTransferFrom(
//         address from,
//         address to,
//         uint256[] memory ids,
//         uint256[] memory amounts,
//         bytes memory data
//     ) public virtual override {
//         super.safeBatchTransferFrom(from, to, ids, amounts, data);
//        for(uint256 i = 0; i< ids.length; i++){
//            isTransferred[ids[i]]= true;
//        }
        
//     }

     function EditNft(uint256 tokenId, string memory newUri) public {
         
         require(super.balanceOf(msg.sender,tokenId)!= 0, "Only NFT Owner can Edit");
       //  require(isTransferred[tokenId] == false,"you cannot change metadata now");
        _setURI(tokenId, newUri);
    }
    
    
   ///@dev required by the OZ UUPS module
   function _authorizeUpgrade(address) internal override onlyOwner {}
    
 
}