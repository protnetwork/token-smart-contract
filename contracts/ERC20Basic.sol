pragma solidity ^0.4.16;

contract ERC20Basic {
    uint256 public totalSupply;
    function balanceOf(address who) constant returns (uint256);
    function transfer(address to, uint256 value) returns (bool);

    // KYBER-NOTE! code changed to comply with ERC20 standard
    event Transfer(address indexed _from, address indexed _to, uint _value);
    //event Transfer(address indexed from, address indexed to, uint256 value);
}
