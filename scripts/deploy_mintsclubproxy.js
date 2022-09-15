const { ethers, upgrades } = require("hardhat");

const name = "mynft";
//const base = "am/";
async function main() {
 const MintsclubProxy = await ethers.getContractFactory("MintsclubProxy");

 console.log("Deploying Mintsclub...");

 const Mintsclub = await upgrades.deployProxy(MintsclubProxy, [name], {
   initializer: "initialize",
 });
 await Mintsclub.deployed();

 console.log("Mintsclub deployed to:", Mintsclub.address);
}

main();