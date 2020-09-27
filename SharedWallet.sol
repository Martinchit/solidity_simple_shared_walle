pragma solidity ^0.6.0;

import "./Allowance.sol";

contract SharedWallet is Allowance {
    
  event MoneySent(address indexed _beneficiary, uint _amount);
  event MoneyReceived(address indexed _from, uint _amount);

  function withdrawMoney(address payable _to, uint _amount) public isOwnerOrRichEnough(_amount) {
    require(address(this).balance >= _amount, "There are not enough funds stored in this smart contract!");
    if (!isOwner()) {
      reduceAllowance(_to, _amount); 
    }
    _to.transfer(_amount);
    emit MoneySent(_to, _amount);
  }
  
  function renounceOwnership() public override onlyOwner {
      revert("Cannot renounce ownership");
  }

  receive() external payable {
    emit MoneyReceived(msg.sender, msg.value);
  }
}
