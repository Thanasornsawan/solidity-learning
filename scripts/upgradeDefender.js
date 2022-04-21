const { defender } = require("hardhat");
async function main() {
  const proxyAddress = "0x61509bda0A25247a3AFa430DC8d25601038fDecb";

  const MyTokenImplementation = await hre.ethers.getContractFactory('MyTokenImplementation');
  console.log("Preparing proposal...");

  //const proposal = await defender.proposeUpgrade(proxyAddress, MyTokenImplementation);
  const proposal = await defender.proposeUpgrade(proxyAddress, MyTokenImplementation, {
    description: "upgrade contact via genosis safe in openzeppelin defender",
    multisig: '0x07F6310dD5bA6f545b1517F3fFf93B0E4C904401', // Your Gnosis Safe address here
    multisigType: 'Gnosis Safe',
    title: "Upgrading via a multisig gnosis v3",
  });
  console.log("Upgrade proposal created at:", proposal.url);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  })