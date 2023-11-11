const hre = require("hardhat");

async function main() {
  const Degen = await hre.ethers.getContractFactory("DegenToken");


  const points = await Degen.deploy();
  

  console.log(`Degen token deployed to ${Degen.target}`);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
