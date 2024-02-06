// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract keyGenerator {
    struct keyPair {
        uint pvtKey;
        uint[2] pubKey;
    }
    address public owner=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    mapping(address=>keyPair) public _keyPair;

     constructor() {
        owner == msg.sender;
     }


modifier onlyOwner() {
    require(owner==msg.sender, "only owner has access");
    _;
}

    function generateKeyPair() public onlyOwner{
        uint privateKey = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, block.difficulty)));
        uint[3] memory publicKey;
        publicKey[0] = privateKey;
        publicKey[1] = 0;
        publicKey[2] = 0;
     
         require(publicKey[0] !=0, "invalid public Key");

        _keyPair[msg.sender] =keyPair(privateKey, [publicKey[0], 0]);



    }
}
