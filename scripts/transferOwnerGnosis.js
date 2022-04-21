async function main () {
    const gnosisSafe = '0x07F6310dD5bA6f545b1517F3fFf93B0E4C904401';
    const MyTokenProxy = await hre.ethers.getContractFactory('MyTokenProxy');
    const contract = MyTokenProxy.attach('0x61509bda0A25247a3AFa430DC8d25601038fDecb');

    console.log("Previous owner:", await contract.owner());
    const tx = await contract.transferOwnership(gnosisSafe);
    console.log('Transferring ownership of ProxyAdmin...');
    // The owner of the ProxyAdmin can upgrade our contracts
    await tx.wait();
    console.log("New owner:", await contract.owner());
    console.log('Transferred ownership of ProxyAdmin to:', gnosisSafe);

  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });