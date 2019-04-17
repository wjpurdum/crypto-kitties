const EmissionsCalculator = artifacts.require("./CalculateEmissions.sol")
module.exports = async function(deployer) {
    await deployer.deploy(EmissionsCalculator)
}