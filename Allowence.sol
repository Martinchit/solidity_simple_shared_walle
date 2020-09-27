pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract Allowance is Ownable {

  using SafeMath for uint;
  struct allowanceDetails {
    uint money;
    bool whitelisted;
  }

  event AllowanceChanged(address indexed _targetAddress, address indexed _authorAddress, uint _oldAmount, uint _newAmount);
  event AllowanceRemoved(address indexed _targetAddress, address indexed _authorAddress);

  mapping(address => allowanceDetails) allowanceMapping;
  
  function isOwner() public view returns(bool) {
      return owner() == msg.sender;
  }

  function setAllowance(address _to, uint _amount) public onlyOwner {
    emit AllowanceChanged(_to, msg.sender, allowanceMapping[_to].money, _amount);
    allowanceMapping[_to].money = _amount;
    allowanceMapping[_to].whitelisted = true;
  }
  
  function checkAllowance() public view isMapped returns(uint) {
    return allowanceMapping[msg.sender].money;
  }
  
  function reduceAllowance(address _to, uint _amount) internal {
    emit AllowanceChanged(_to, msg.sender, allowanceMapping[_to].money, allowanceMapping[_to].money.sub(_amount));
    allowanceMapping[_to].money = allowanceMapping[_to].money.sub(_amount);
  }
  
  function removeAllowance(address _to) public onlyOwner {
    emit AllowanceRemoved(_to, msg.sender);
    allowanceMapping[_to].money = 0;
    allowanceMapping[_to].whitelisted = false;
  }

  modifier isOwnerOrRichEnough(uint _withdrawAmount) {
    require(isOwner() || allowanceMapping[msg.sender].money >= _withdrawAmount, "You don't have enough money to withdraw");
    _;
  }
  
  modifier isMapped() {
    require(isOwner() || allowanceMapping[msg.sender].whitelisted, "You are not whitelisted in the allowance list");
    _;
  }
}