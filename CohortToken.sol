// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CohortToken is ERC721, Ownable {

//Declaring all the variables relevant to SC

    uint256 public mintRate = 0.01 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping (address => uint256) public walletsMinted;
    mapping(address => uint) private _tokenCount;
 
// Contructor that initialises name and symbol of token with constructor

    constructor() ERC721("CohortTokens", "CRT") {
        maxSupply = 3;
    }

//Only the Owner/one  who deplpoys SC can use this function
    function EnableMint() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

//Only the Owner/one  who deplpoys SC can use this function
    function updateMaxSupply(uint256 _maxSupply) external onlyOwner{
        maxSupply = _maxSupply;
    }


//Checks for all queries like Mint is enabled, max token and mint rate with below function and call _safeMint iinternally

    function mint() external payable {

        
        require(isMintEnabled, "Minting of token not allowed at the moment as Mint is Disabled !!");

        require(walletsMinted[msg.sender] < 1,"Exceeded max token per wallet !!");

        require(msg.value == mintRate, "Not enough Balance to Mint....");

        require(maxSupply > totalSupply, "Hard Luck , Tokens Sold Out !!");

        walletsMinted[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender,tokenId);
    }
}
