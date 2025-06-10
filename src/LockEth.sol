// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract LockEth is Ownable {
    mapping(address => uint) lockedAmount;
    constructor() Ownable(msg.sender) {
    }

    function deposit() public payable {
        require(msg.value > 0, "Amount should be Greater then Zero");
        lockedAmount[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(_amount > 0, "Amount should be greater then Zero");
        require(lockedAmount[msg.sender] >= _amount);
        lockedAmount[msg.sender] -= _amount;
        (bool success, ) = msg.sender.call{value : _amount}("");
        require(success);
    }


}
