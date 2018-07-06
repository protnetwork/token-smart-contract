var PrototypeNetworkToken = artifacts.require("./PrototypeNetworkToken.sol");


contract(PrototypeNetworkToken,function(accounts){

    var totalSupply = 2100000000

    var owner = accounts[0]

    var user = accounts[1]

    var value = web3.toWei(10000,"ether");

    var valuePercent40 = web3.toWei(4000,"ether")

    var prot;

    it("TotalSupply should be 2100000000",function(){
        PrototypeNetworkToken.deployed().then(function(instance){
            return instance.totalSupply.call();
        }).then(function(bal){
            return web3.fromWei(bal,"ether")
        }).then(function(value){
            assert.equal(totalSupply,value,"Total supply is not 210000000")
        })
    });


    it("Owner should be "+ owner,function(){
        PrototypeNetworkToken.deployed().then(function(instance){
            return instance.owner.call();
        }).then(function(_owner){
            assert.equal(_owner,owner,"Owner is not right")
        })
    });

    it("Transfer 10000 prot to " + user, function(){
        PrototypeNetworkToken.deployed().then(function(instance){
            prot = instance;
            return instance.transfer(user,value,{from:owner});
        }).then(function(){
            return prot.balanceOf.call(user)
        }).then(function (balance) {
             console.log(balance.toNumber())
            assert.equal(value,balance.toNumber(),"Owner is not right")
        })
    });

    it("Test lock 40% of 10000 at one stage",function(){
        PrototypeNetworkToken.deployed().then(function(instance){
            prot = instance;
            return instance.issueToken(user,value,{from:owner,gas:4700000})
        }).then(function(){
            return prot.available.call(user);
        }).then(function(avail){
            assert.equal(valuePercent40,avail.toNumber(),"Lock wrong")
        })
    })

})