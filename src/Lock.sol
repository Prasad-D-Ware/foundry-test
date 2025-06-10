// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract Lock is Ownable {
    address tokenAddress;
    mapping(address => uint) lockedAmount;
    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress =_tokenAddress;
    }

    function deposit(IERC20 _tokenAddress , uint _amount) public {
        require(tokenAddress == address(_tokenAddress));
        require(_tokenAddress.allowance(msg.sender, address(this)) >= _amount);
        require(_tokenAddress.transferFrom(msg.sender,address(this) , _amount));
        lockedAmount[msg.sender] += _amount;
    }

    function withdraw(IERC20 _tokenAddress , uint _amount) public {
        require(lockedAmount[msg.sender] >= _amount);
        lockedAmount[msg.sender] -= _amount;
        _tokenAddress.transfer(msg.sender, _amount);

    }


}
