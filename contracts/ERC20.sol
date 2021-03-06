pragma solidity ^0.4.16;
import "./ERC20Basic.sol";

contract ERC20 is ERC20Basic {
    function allowance(address owner, address spender) constant returns (uint256);
    function transferFrom(address from, address to, uint256 value) returns (bool);
    function approve(address spender, uint256 value) returns (bool);

    // KYBER-NOTE! code changed to comply with ERC20 standard
    event Approval(address indexed _owner, address indexed _spender, uint _value);
    //event Approval(address indexed owner, address indexed spender, uint256 value);
}