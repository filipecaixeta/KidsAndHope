var ConvertLib = artifacts.require("./ConvertLib.sol");
var KidHope = artifacts.require("./KidHope.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, KidHope);
  deployer.deploy(KidHope);
};
