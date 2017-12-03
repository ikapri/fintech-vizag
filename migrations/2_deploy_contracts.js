var Interface = artifacts.require("./Interface.sol");
var Agreement = artifacts.require("./Agreements.sol");

module.exports = function(deployer) {
  deployer.deploy(Interface);
  deployer.deploy(Agreement);
};
