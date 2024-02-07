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
        priceAgainstUSD=10*17;

        owner=_owner;
        

    }

    struct preSale{
        address participants;
        bool hasParticipated;
    }

    struct finalization{
        bool finalized;
        address saleParticipants;
    }
    mapping(address=> preSale) public presale;
    mapping(address=>finalization) public finalize;
    function initiateSale() public onlyOwner{
        isInitiated[investor] = false;
    }


    function participateInSale(uint amount) public {
        require(amount>0, "deposit amount has to have a value");
        isInitiated[investor] = true;
        require(!presale[msg.sender].hasParticipated, "participation not done yet");
        presale[msg.sender] = preSale({
            participants: msg.sender,
            hasParticipated: false
        });
        presale[msg.sender].hasParticipated = true;
       ParticipantFee=amount;
       Helix.transferFrom(owner, investor, amount);
     

    }


    function finalizeSale() public onlyOwner{
      require(!finalize[investor].finalized, "finalization not done yet");
      finalize[msg.sender] = finalization({
        finalized: false,
        saleParticipants: msg.sender
      });
      finalize[investor].finalized = true;
    }



}
