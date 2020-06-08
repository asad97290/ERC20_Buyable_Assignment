pragma solidity ^0.6.2;

import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract Contract1 is ERC20
{
    using SafeMath for uint256;
    
    address public owner;
    uint256 public basePrice;  
    
    constructor(uint256 _basePrice) 
    public
   ERC20("Asad Token","AT")
    {
        basePrice = _basePrice * (10**uint256(decimals()));
        owner = msg.sender;
        uint initialToken = 1000000 * (10**uint256(decimals()));
        _mint(owner,initialToken);
    }
     modifier onlyOwner(){
        require(msg.sender == owner,"Permission Denied: Only owner can access this resource");
        _;
    }
    
    function buyToken() payable public{
        uint numberOfTokens = basePrice.mul(msg.value).div(1 ether);
        payable(owner).transfer(msg.value);
        _transfer(owner,msg.sender,numberOfTokens);
    }
    
    function adjestPrice(uint256 token_price) onlyOwner public{
        basePrice = token_price;
    }
    
    receive() external payable {
        buyToken();
    }
    
    fallback() external payable {
        buyToken();
    }
}

