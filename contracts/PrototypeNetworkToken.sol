pragma solidity ^0.4.16;
import "./Lock.sol";


contract PrototypeNetworkToken is Lock{
    string  public  constant name = "Prototype Network";
    string  public  constant symbol = "PROT";
    uint    public  constant decimals = 18;

    bool public transferEnabled = true;


    modifier validDestination( address to ) {
        require(to != address(0x0));
        require(to != address(this) );
        _;
    }

    function PrototypeNetworkToken() {
        // Mint all tokens. Then disable minting forever.
        totalSupply = 2100000000 * (10 ** decimals);
        balances[msg.sender] = totalSupply;
        Transfer(address(0x0), msg.sender, totalSupply);
        transferOwnership(msg.sender); // admin could drain tokens that were sent here by mistake
    }

    function transfer(address _to, uint _value) validDestination(_to) returns (bool) {
        require(transferEnabled == true);

        // The sender is in locked address list
        if(lockStartTime[msg.sender] > 0) {
            return super.lockTransfer(_to,_value);
        }else {
            return super.transfer(_to, _value);
        }
    }

    function transferFrom(address _from, address _to, uint _value) validDestination(_to) returns (bool) {
        require(transferEnabled == true);
        // The sender is in locked address list
        if(lockStartTime[_from] > 0) {
            return super.lockTransferFrom(_from,_to,_value);
        }else {
            return super.transferFrom(_from, _to, _value);
        }
    }


    function emergencyERC20Drain( ERC20 token, uint amount ) onlyOwner {
        token.transfer( owner, amount );
    }

    function setTransferEnable(bool enable) onlyOwner {
        transferEnabled = enable;
    }
}
