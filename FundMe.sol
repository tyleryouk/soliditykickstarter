// get funds from users
// withdraw funds
// set a minumum funding value in USD

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    uint public minUSD = 5;

    function fund() public payable{
        //want anyone to call fund
        //how do we send ETH to this contract?
        //msg.value = number of wei sent to the contract
        require(msg.value >= minUSD, "didn't send enough eth"); //1e18 = 1ETH
        //must fund at least 1.0 eth 

    }
    function getPrice() public {
        //Address on docs.chain.link price feed addresses 
        //sepolia testnet eth to usd
        //0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
    }
    function getConversionRate() public {

    }
    
    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function withdraw() public {

    }
}