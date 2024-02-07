// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract IERC is ERC20 {
    uint initialSupply;

    constructor (uint _initialSupply) ERC20("Helix Token", "HLX") {
        initialSupply = _initialSupply;
        _mint(msg.sender, initialSupply);
    }

    function mint(uint amount, address to) public {
        _mint(to, amount);
    }

    function burn(uint amount, address to) public {
        _burn(to, amount);
    }

    function trackToken() public view returns(uint) {
        return trackToken();
    }
}
