// get funds from users
// withdraw funds
// set a minumum funding value in USD

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract FundMe {

    uint public minUSD = 5;

    function fund() public payable{
        //want anyone to call fund
        //how do we send ETH to this contract?
        //msg.value = number of wei sent to the contract
        require(msg.value >= minUSD, "didn't send enough eth"); //1e18 = 1ETH
        //must fund at least 1.0 eth 

    }

    function withdraw() public {

    }
}