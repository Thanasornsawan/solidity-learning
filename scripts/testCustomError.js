const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const vendingMachineContractFactory = await hre.ethers.getContractFactory('VendingMachine');
    const vendingMachineContract = await vendingMachineContractFactory.deploy();
    await vendingMachineContract.deployed();
    console.log("Contract deployed to:", vendingMachineContract.address);
    console.log("Owner address:", owner.address);
    console.log("Random person address:", randomPerson.address);  

    let testErr = await vendingMachineContract.connect(randomPerson).withdraw();
    
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();