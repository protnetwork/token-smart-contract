var PrototypeNetworkToken = artifacts.require("./PrototypeNetworkToken.sol");


contract(PrototypeNetworkToken,function(accounts){

    var totalSupply = 2100000000

    var owner = accounts[0]

    var user1 = accounts[1]

    var user2 = accounts[2]

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

    it("Transfer 10000 prot to " + user1, function(){
        PrototypeNetworkToken.deployed().then(function(instance){
            prot = instance;
            return instance.transfer(user1,value,{from:owner});
        }).then(function(){
            return prot.balanceOf.call(user1)
        }).then(function (balance) {
             console.log(balance.toNumber())
            assert.equal(value,balance.toNumber(),"Transfer 10000 prot to " + user1 + " is not right")
        })
    });

    it("Test lock 40% of 10000 at one stage",function(){
        PrototypeNetworkToken.deployed().then(function(instance){
            prot = instance;
            return instance.issueToken(user2,value,{from:owner,gas:4700000})
        }).then(function(){
            return prot.available.call(user2);
        }).then(function(avail){
            assert.equal(valuePercent40,avail.toNumber(),"Lock wrong")
        })
    })

})