// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./IERC.sol";

contract PreSale {
    address public owner;
    modifier onlyOwner() {
        require(owner==msg.sender, "only owner has access");
        _;
    }

    ERC20 public Helix;
    mapping(address=>bool) public isInitiated;
    uint public ParticipantFee;

    constructor(address _owner, address _Helix) {
        Helix = ERC20(_Helix);
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
        isInitiated[owner] = false;
    }


    function participateInSale(uint amount) public {
        require(amount>0, "deposit amount has to have a value");
        isInitiated[owner] = true;
        require(!presale[msg.sender].hasParticipated, "participation not done yet");
        presale[msg.sender] = preSale({
            participants: msg.sender,
            hasParticipated: false
        });
        presale[msg.sender].hasParticipated = true;
       ParticipantFee=amount;
       Helix.transferFrom(msg.sender, address(this), amount);

    }


    function finalizeSale() public onlyOwner{
      require(!finalize[owner].finalized, "finalization not done yet");
      finalize[msg.sender] = finalization({
        finalized: false,
        saleParticipants: msg.sender
      });
      finalize[owner].finalized = true;
    }



}
