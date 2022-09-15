const { ethers, upgrades } = require("hardhat");

const PROXY = '0x38693148eC494ECB0af73E40E7302111Aa0Cc5A4';

async function main() {
 const MintsclubV2 = await ethers.getContractFactory("MintsclubV2");
 console.log("Upgrading MintsclubV2...");
 await upgrades.upgradeProxy(PROXY, MintsclubV2);
 console.log("MintsclubV2 upgraded successfully");
}

main();