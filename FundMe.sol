// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner(); //custom error

//right now, costs 840,197 gas
//going to bring this down
// at 751,214
// at 726,937
// added two special functions
// at 732,322

contract FundMe {
    using PriceConverter for uint256;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public i_owner; //immutable owner
    uint256 public constant MINIMUM_USD = 5e18; //5 to the power of 18 or 5 * 10 ** 18
    
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        for(uint256 i = 0; i < funders.length; i++){
            address currentFunder = funders[i]; //setting current funder to a 0xC address
            addressToAmountFunded[currentFunder] = 0; //setting mapping of 0xC address to 0
        }
        funders = new address[](0); //resetting the array funders
        (bool callSucess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess,  "Call failed");
    }

    modifier onlyOwner() {
        //require(msg.sender == i_owner, "sender is not owner"); //require caller of function to be onlyOwner
        if(msg.sender != i_owner){ revert NotOwner(); }
        _; //here, put the code of the function where the modifier is called
    }

    //adding receive and fallback for when a user sends this contract ETH without calling fund
    receive() external payable{
        fund();
    }
    fallback() external payable{
        fund();
    }  
}