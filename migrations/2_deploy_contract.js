var SafeMath = artifacts.require("./SafeMath.sol");
var PrototypeNetworkToken = artifacts.require("./PrototypeNetworkToken.sol");

module.exports = function(deployer) {
    deployer.deploy(SafeMath);
    deployer.link(SafeMath, PrototypeNetworkToken);
    deployer.deploy(PrototypeNetworkToken);
};