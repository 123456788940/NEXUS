// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ICO is ERC20{
    address owner=0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
    modifier onlyOwner() {
        require(owner==msg.sender, "only owner has access");
        _;
    }
    uint public tokenPrice;
    uint public totalPool;
    uint public initialSupply;
    constructor(address _owner, uint _initialSupply, uint _tokenPrice) ERC20("Helix Token", "HLX"){
        _mint(msg.sender, initialSupply);
        initialSupply=_initialSupply;
        tokenPrice = _tokenPrice;
        owner=_owner;


    }

    mapping(address=>bool) public authenticated;
     mapping(address=>bool) public isEnded;
     mapping(address=>bool) public isDistributed;
     address[] public payees;

    function buyToken(uint amount, uint payableAmount) external onlyOwner {
        require(amount>0, "amount has to be valid");
        require(payableAmount>0, "amount has to be valid");
        require(payableAmount == amount * tokenPrice, "not valid payable amount");
         authenticated[owner] = true;
         transferFrom(msg.sender, address(this), amount);
         _transfer(msg.sender, owner, payableAmount);
         totalPool+=amount;
         
         

    }
      
      
        function endToken() external onlyOwner {
          isEnded[owner] = true;
        }

        function distributeToken(address[] calldata receivers, uint amount) external onlyOwner {
            for (uint i = 0; i < receivers.length; i++){
         require(!isDistributed[receivers[i]], "distribution not doner");
          isDistributed[receivers[i]] = true;
          payees.push(receivers[i]);
          transfer(receivers[i], amount);
        }
        }
    
}
