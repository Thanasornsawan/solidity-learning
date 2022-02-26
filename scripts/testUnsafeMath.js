const main = async () => {
    const unSafeMathContractFactory = await hre.ethers.getContractFactory('unSafeMath');
    const unSafeMathContract = await unSafeMathContractFactory.deploy();
    await unSafeMathContract.deployed();
    console.log("Contract deployed to:", unSafeMathContract.address);
  
    /*
    let safe = await unSafeMathContract.testUnderflow();
    console.log(safe);
    */

    let unsafe = await unSafeMathContract.testUncheckedUnderflow();
    console.log(unsafe);
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