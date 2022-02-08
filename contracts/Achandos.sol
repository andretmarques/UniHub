pragma solidity ^0.8.11;

contract Achandos{
    string public user;
    uint public tokens;


    constructor() public{
        user = "Unknown" ;
        tokens = 0 ;
    }


    function set(string memory name, uint tokCount) public{
        user = name ;
        tokens = tokCount ;
    }

    function decrement(uint decrementBy) public{
        tokens -= decrementBy ;
    }


    function increment(uint incrementBy) public{
        tokens += incrementBy ;
    }
}