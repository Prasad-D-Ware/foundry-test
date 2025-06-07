// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    address private owner;

    constructor() ERC20("PRASAD", "PR") {
        owner = msg.sender;
    }

    function mint(address reciever ,uint _value) public {
        require(msg.sender == owner);
        _mint(reciever,_value);
    }
}