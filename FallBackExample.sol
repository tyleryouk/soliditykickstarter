// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract FallBackExample {
    uint256 public result;

    receive() external payable {
        //solidity knows receive is a special function
        result = 1;
        //gets triggered anytime a transaction gets sent, even if the amount is 0
    }

    fallback() external payable {
        result = 2;
    }
}