// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract MintsclubProxy is ERC1155Upgradeable, UUPSUpgradeable, OwnableUpgradeable
{
    using CountersUpgradeable for CountersUpgradeable.Counter;
    using SafeMathUpgradeable for uint256;
    
    string public name;
    string private _baseURI ;

    mapping(uint256 => string)  private _tokenURIs;

    CountersUpgradeable.Counter private _tokenIdCounter;

    
    function initialize(string memory _name) public initializer {
       name = _name;
       __Ownable_init();
       _baseURI = "";
    }
    

    function setName(string memory _name) public
    {
        name = _name; // Collection name
    }

    function uri(uint256 tokenId) public view virtual override returns(string memory)
    {
        string memory tokenURI = _tokenURIs[tokenId];
        return bytes(tokenURI).length > 0 ? string(abi.encodePacked(_baseURI , tokenURI)): super.uri(tokenId);
    }


    function _setURI(uint256 tokenId , string memory tokenURI) internal virtual
    {
        _tokenURIs[tokenId] = tokenURI;
        emit URI(uri(tokenId), tokenId); // iska event kahan ha  ? in IERC1155
    }

       function _setBaseURI(string memory baseURI) internal virtual
    {
        _baseURI = baseURI;
    }

//Minting Functions
    function mint(address account , uint256 amount , string memory tokenuri)public 
    {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _mint(account,tokenId,amount,"0x00");
        _setURI(tokenId, tokenuri);
    
    }

    function mintBatch(address to, uint256[] memory amounts, string[] memory tokenUris)public
    {
        require(tokenUris.length == amounts.length , "Ids and TokenUri length mismatch");
        uint[] memory tokenId = new uint[](amounts.length);
        for (uint i = 0; i < amounts.length; i++){
            _tokenIdCounter.increment();
            tokenId[i] = _tokenIdCounter.current();
            _setURI(tokenId[i], tokenUris[i]);
        }
         _mintBatch(to, tokenId, amounts, "0x00");
             
    }
     function EditNft(uint256 tokenId, string memory newUri) public {
        require(super.balanceOf(msg.sender,tokenId)!= 0, "Only NFT Owner can Edit");
        _setURI(tokenId, newUri);
    }
    
   ///@dev required by the OZ UUPS module
   function _authorizeUpgrade(address) internal override onlyOwner {}
    
 
}