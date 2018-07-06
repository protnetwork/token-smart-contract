pragma solidity ^0.4.16;
import "./StandardToken.sol";
import "./Ownable.sol";

contract Lock is StandardToken, Ownable{

    mapping(address => uint256) public lockedBalance;

    mapping(address => uint256) public lockStartTime;

    mapping(address => uint256) public usedBalance;

    function availablePercent(address _to) internal constant returns (uint256) {
        uint256 percent = 40;
        percent += ((now - lockStartTime[_to]) / 10 minutes ) * 20;
        if(percent > 100) {
            percent = 100;
        }
        return percent;
    }

    function issueToken(address _to,uint256 _value) public onlyOwner {
        require(super.transfer(_to,_value) ==  true);
        lockedBalance[_to] = lockedBalance[_to].add(_value);
        lockStartTime[_to] = block.timestamp;
    }

    function available(address _to) public constant returns (uint256) {
        uint256 percent = availablePercent(_to);
        uint256 avail = lockedBalance[_to];
        avail = avail.mul(percent);
        avail = avail.div(100);
        avail = avail.sub(usedBalance[_to]);
        return avail ;
    }

    function lockTransfer(address _to, uint256 _value) internal returns (bool) {
        uint256 avail1 = available(msg.sender);
        uint256 avail2 = balances[msg.sender].add(usedBalance[msg.sender]).sub(lockedBalance[msg.sender]);
        uint256 totalAvail = avail1.add(avail2);
        require(_value <= totalAvail);
        bool ret = super.transfer(_to,_value);
        if(ret == true) {
            if(_value > avail2){
                usedBalance[msg.sender] = usedBalance[msg.sender].add(_value).sub(avail2);
            }
        }
        if(usedBalance[msg.sender] >= lockedBalance[msg.sender]) {
            delete lockStartTime[msg.sender];
        }
        return ret;
    }

    function lockTransferFrom(address _from,address _to, uint256 _value) internal returns (bool) {
        uint256 avail1 = available(_from);
        uint256 avail2 = balances[_from].add(usedBalance[_from]).sub(lockedBalance[_from]);
        uint256 totalAvail = avail1.add(avail2);
        require(_value <= totalAvail);
        bool ret = super.transferFrom(_from,_to,_value);
        if(ret == true) {
            if(_value > avail2){
                usedBalance[_from] = usedBalance[_from].add(_value).sub(avail2);
            }
        }
        if(usedBalance[_from] >= lockedBalance[_from]) {
            delete lockStartTime[_from];
        }
        return ret;
    }
}
