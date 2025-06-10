// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Lock.sol";
import "src/Token.sol";

contract TestLock is Test {
    Token token;
    Lock lock;

    function setUp() public {
        token = new Token();
        lock = new Lock(address(token));
    }

    function testLocking() public {
        token.mint(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 200);
        vm.startPrank(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a);

        token.approve(address(lock), 200);

        lock.deposit(token, 200);

        assertEq(token.balanceOf(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a), 0);
        assertEq(token.balanceOf(address(lock)), 200);

        lock.withdraw(token, 200);

        assertEq(token.balanceOf(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a), 200);
        assertEq(token.balanceOf(address(lock)), 0);
    }

}
