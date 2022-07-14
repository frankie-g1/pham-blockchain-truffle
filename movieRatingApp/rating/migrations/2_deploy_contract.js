var Ratings = artifacts.require("./Rating.sol")

module.exports = function(deployer) { 
    deployer.deploy(Ratings, ['Avatar', 'Inception', 'Spider Man: Home Coming', 'Star Wars: The Last Jedi'], {gas:6700000})
}