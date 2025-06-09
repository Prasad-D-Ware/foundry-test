// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Token.sol";

contract TestToken is Test {
    Token t;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function setUp() public {
        t = new Token();
    }

    function testMint() public {
        t.mint(address(this), 1000);
        assertEq(t.balanceOf(address(this)), 1000);
    }

    function testTransfer() public {
        t.mint(address(this), 100);
        t.transfer(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 10);
        assertEq(t.balanceOf(address(this)), 90);
    }

    function testApprove() public {
        t.mint(address(this), 100);

        t.approve(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 20);
        vm.prank(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a);
        t.transferFrom(
            address(this),
            0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a,
            10
        );

        assertEq(t.balanceOf(address(this)), 90);
        assertEq(t.balanceOf(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a), 10);
        assertEq(
            t.allowance(
                address(this),
                0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a
            ),
            10
        );
    }

    function testRevertSpendMore() public {
        t.mint(address(this), 100);
        vm.expectRevert();
        t.transfer(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 1000);
    }

    function testRevertTransfer() public {
        vm.expectRevert();
        t.transfer(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 1000);
    }

    function testRevertExceedAllowance() public {
        t.mint(address(this), 100);

        t.approve(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 20);
        vm.prank(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a);
        vm.expectRevert();
        t.transferFrom(
            address(this),
            0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a,
            30
        );
    }

    function testTransferEmit() public {
        t.mint(address(this), 100);

        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this),0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 10);

        t.transfer(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 10);
    }

    function testApproveAndTransferFromEmit() public {
        t.mint(address(this), 100);

        vm.expectEmit(true, true, false, true);
        emit Approval(address(this), 0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 50);

        t.approve(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 50);

        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this),0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 10);

        vm.prank(0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a);
        t.transferFrom(address(this), 0x6b33AfEcce4198E5127d4c8970c16C1ed75Cc62a, 10);

    }
}
