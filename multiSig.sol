// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

contract multiSig {
 address signer1= 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
  address signer2=0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
   address signer3=0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
 address signer4=0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
   address signer5=0x17F6AD8Ef982297579C203069C1DbfFE4348c372;
    uint public totalPool;

    constructor(address _signer1, address _signer2, address _signer3, address _signer4, address _signer5) {
        signer1=_signer1;
        signer2=_signer2;
        signer3=_signer3;
        signer4=_signer4;
        signer5=_signer5;
      

    }
    mapping(address=>bool) public authenticated;
       modifier onlySigners() {
    require(signer1==msg.sender || signer2 == msg.sender || signer3 == msg.sender || signer4 == msg.sender || signer5==msg.sender, "only these addresses have access");
    _;
}

    function sign() public onlySigners{
        authenticated[msg.sender] = false;
      

    }


    function sendAmount(uint amount) public {
        require(amount>0, "there has to be a valid amount");
        require(authenticated[signer1] && authenticated[signer2] && authenticated[signer3] && authenticated[signer4] && authenticated[signer5], "not authnticated");
        authenticated[msg.sender] = true;
           totalPool-=amount;
    }


    function receiveAmount(uint amount) public {
         require(amount>0, "there has to be a valid amount"); 
           require(authenticated[signer1] && authenticated[signer2] && authenticated[signer3] && authenticated[signer4] && authenticated[signer5], "not authenticated"); 
          authenticated[msg.sender] = true;
           totalPool+=amount;
    }

    function trackTransactions() public view returns(uint) {
       return totalPool;
    }
}
