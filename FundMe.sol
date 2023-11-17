// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public i_owner; //immutable owner
    uint256 public constant MINIMUM_USD = 5 * 10 ** 18;
    
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "need at least $5");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw() public {
        for(uint256 i = 0; i < funders.length; i++){
            address currentFunder = funders[i]; //setting current funder to a 0xC address
            addressToAmountFunded[currentFunder] = 0; //setting mapping of 0xC address to 0
        }
        funders = new address[](0); //resetting the array funders
        (bool callSucess, ) = payable(msg.sender).call({value: address(this).balance}(""));
        require(callSucess,  "Call failed");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "sender is not owner");
        _;
    }
}