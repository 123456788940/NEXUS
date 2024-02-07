// SPDX-License-Identifier: MIT
pragma solidity ^0.8;



import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PreSale {
    using SafeMath for uint;
    address public investor;
    modifier onlyOwner() {
        require(owner==msg.sender, "only owner has access");
        _;
    }
    
    address public owner;
    
    ERC20 public Helix;
   uint public priceAgainstUSD;
    uint public totalTokens;
    mapping(address=>bool) public isInitiated;
    uint public ParticipantFee;

    constructor(address _investor, address _owner, uint _totalTokens, address _Helix) {
       totalTokens=_totalTokens;
        investor=_investor;
        Helix = ERC20(_Helix);
        priceAgainstUSD=10*10**17;

        owner=_owner;
        

    }

    struct preSale{
        address participants;
        bool hasParticipated;
    }

    mapping(address=> preSale) public presale;
 
    function initiateSale() public onlyOwner{
        isInitiated[owner] = true;
    }


    function participateInSale(uint amount) public payable{
        require(amount>0, "deposit amount has to have a value");
        isInitiated[owner] = true;
        require(!presale[investor].hasParticipated, "participation not done yet");
        presale[investor] = preSale({
            participants: msg.sender,
            hasParticipated: false
        });
       ParticipantFee=amount;
             uint tokenAmount = amount.mul(priceAgainstUSD).div(1 ether);
      Helix.transferFrom(owner, investor, tokenAmount);
     totalTokens-=amount;

    }


    }



