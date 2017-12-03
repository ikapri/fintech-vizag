module.exports = function(callback) {
    var Iface;
    Interface.deployed().then(function(instance){Iface=instance;});
    var lender1 = [32,"asd","qwe",2,24,5000,"AHSJS","SEX","1245","6578","BHATAPARA","NULL"];
    Iface.setBorrower( ...lender1 );
    console.log(Iface.getBorrowers());

    
};
