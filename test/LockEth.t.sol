// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/LockEth.sol";
import "src/Token.sol";

contract TestContract is Test { 
    LockEth lock;

    function setUp() public {
        lock = new LockEth();
    }

    function testLockingEth() public{

        vm.deal(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 10 ether);
        vm.startPrank(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a);
        lock.deposit{value: 10 ether}();

        assertEq(address(lock).balance, 10 ether);
        assertEq(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a.balance, 0);

        lock.withdraw(5 ether);

        assertEq(address(lock).balance, 5 ether);
        assertEq(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a.balance, 5 ether);
    }


}
