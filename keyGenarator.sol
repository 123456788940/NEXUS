// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract keyGenarator {
    struct keyPair {
        uint pvtKey;
        uint[2]pubKey;
    }

    mapping(address=>keyPair) public _keyPair;
    
    function genarateKeyPair() public {
        uint privatekey =uint(keccak256(abi.encodePacked(block. timestamp, msg.sender, block.difficulty)));
        uint[3] memory publicKey;
        publicKey[0] =privatekey;
        publicKey[1] =0;
        publicKey[2] =0;
        
        require(publicKey[0] !=0, "invalid public Key");

        _keyPair[msg.sender] =keyPair(privatekey, [publicKey[0] ,0]);
            
            


    }
}
