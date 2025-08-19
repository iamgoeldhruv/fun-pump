// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.27;
import {Token} from "./Token.sol";

contract Factory {
   uint256 public  immutable fee;
   address public owner;
   address[] public tokens;
   mapping(address=> TokenSale) public tokenToSale;
   struct TokenSale{
      address token;
      string name;
      address creator;
      uint256 sold;
      uint256 raised;
      bool isOpen;


   }
   uint256 public totakTokens=0;
   event created(address indexed token);
   event buy(address indexed token,uint256 amount);
      constructor(uint256 _fee){
    fee=_fee;
    owner=msg.sender;
   }
   function getTokenFromSale(uint256 _index) public view returns(TokenSale memory){
      return tokenToSale[tokens[_index]];
   }
   function getCosts(uint256 _sold) public pure returns(uint256){
      uint256 floor=0.0001 ether;
      uint256 step=0.0001 ether;
      uint256 increment=1000 ether;
      uint256 cost=(step*(_sold/increment))+floor;
      return cost;


   }
   function create(string memory _name,string memory _symbol) external payable{
      require(msg.value>=fee,"Not Enough ETH sent");
      Token token=new Token(msg.sender,_name,_symbol,1_000_000 ether);
      tokens.push(address(token));
      totakTokens++;
      TokenSale memory sale=TokenSale(
         address(token),
         _name,
         msg.sender,
         0,
         0,
         true
      );

      tokenToSale[address(token)]=sale;
      emit created(address(token));




   }
   function buyTokens(address _token, uint256 _amount) external payable{
      TokenSale storage sale=tokenToSale[_token];
      sale.sold=sale.sold+_amount;
      uint256 cost=getCosts(sale.sold);
      uint256 amount=cost*(_amount/10**18);

      Token(_token).transfer(msg.sender,_amount);
      emit buy(_token,_amount);
      
   }
}
