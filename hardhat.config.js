require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require('@nomicfoundation/hardhat-toolbox');
require("@nomiclabs/hardhat-etherscan");

require("dotenv").config();

module.exports = {
 solidity: "0.8.7",
 networks: {
   rinkeby: {
     url: `https://eth-rinkeby.alchemyapi.io/v2/${process.env.INFURA_API_KEY}`,
    // `https://rinkeby.infura.io/v3/${process.env.INFURA_API_KEY}`,
     accounts: [process.env.PRIVATE_KEY],
   },
   goerli: {
    url: `https://eth-goerli.g.alchemy.com/v2/${process.env.GOERLI_API_KEY}`,
   // `https://rinkeby.infura.io/v3/${process.env.INFURA_API_KEY}`,
    accounts: [process.env.PRIVATE_KEY],
  },
 },
 etherscan: {
   apiKey: process.env.ETHERSCAN_API_KEY,
 },
};