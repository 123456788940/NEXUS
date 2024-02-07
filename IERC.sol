// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract IERC is ERC20 {
    uint initialSupply;
    uint priceAgainstUSD;

    constructor (uint _initialSupply) ERC20("Helix Token", "HLX") {
        initialSupply = _initialSupply;
        priceAgainstUSD=10*17;
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
