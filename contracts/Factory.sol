// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.27;
import {Token} from "./Token.sol";

contract Factory {
   uint256 public  immutable fee;
   address public owner;
   address[] public tokens;
   struct TokenSale{
      address token;
      string name;
      address creator;
      uint256 sold;
      uint256 raised;
      bool isOpen;


   }
   uint256 public totakTokens=0;
      constructor(uint256 _fee){
    fee=_fee;
    owner=msg.sender;
   }
   function create(string memory _name,string memory _symbol) external payable{
      Token token=new Token(msg.sender,_name,_symbol,1_000_000 ether);
      tokens.push(address(token));
      totakTokens++;

   }
}
