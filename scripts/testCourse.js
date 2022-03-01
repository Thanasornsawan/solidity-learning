const main = async () => {
    const [owner, std1] = await hre.ethers.getSigners();
    const courseContractFactory = await hre.ethers.getContractFactory('Courses');
    const courseContract = await courseContractFactory.deploy();
    await courseContract.deployed();
    console.log("Contract deployed to:", courseContract.address);
    console.log("Owner address:", owner.address);
    console.log("Student address:", std1.address);  

    let newCourse = await courseContract.addCourse(200, "course1");
        await courseContract.addCourse(300, "course2");
        await courseContract.addCourse(100, "course3");
    let getAllCourse = await courseContract.getAllCourses();
    let up = await courseContract.updateDeatailCourse("change title naa", 150);
    let getCourseById = await courseContract.getCourseById(1);
    let selectCourse = await courseContract.chooseCoursesToBuy(0);
        selectCourse = await courseContract.chooseCoursesToBuy(1);
        selectCourse = await courseContract.chooseCoursesToBuy(2);
    //get transaction return value from function chooseCourseToBuy -------
    const trace = await network.provider.send("debug_traceTransaction", [selectCourse.hash])
    const [cart] = ethers.utils.defaultAbiCoder.decode(
      ['uint[]'],
      `0x${trace.returnValue}`
      )
      console.log(`cart: ${cart}`)      
    //--------------------------------------------------------------------
    const removeSelectCourse = await courseContract.removeCourseToBuy(1);
    const viewCart = await courseContract.viewCart();
    console.log("Final cart: " + viewCart.toString());
    let totalPrice = await courseContract.calculateTotalPrice();
    console.log("Total price to pay: " + totalPrice.toNumber());

    const addStdBalance = await courseContract.connect(std1).addBalance(1000);
    const getStdBalance = await courseContract.connect(std1).getBalance();
    console.log("student balance: " + getStdBalance.toNumber());

    const payCourse = await courseContract.connect(std1).payCourse(owner.address);
    //get event from solidity contract (in npx hardhat node not shows event,need to use this solution)
    const payCourseEvent = await payCourse.wait();
    for (const event of payCourseEvent.events) {
      console.log(`Event ${event.event} with args ${event.args}`);
    }
    //------------------------------------------------------------------------------------------------
    const getOwnerBalance = await courseContract.getBalance();
    console.log("Teacher balance: " + getOwnerBalance.toNumber());
    const getStdBalance2 = await courseContract.connect(std1).getBalance();
    console.log("student balance after payment: " + getStdBalance2.toNumber());

    //test method deposit involve with msg.value --------------------------------
    const depositToOwner = await courseContract.deposit({
      from: owner.address,
      value: ethers.utils.parseEther("0.5")
    });

    let getOwnerBalance2 = await courseContract.getBalance();
        getOwnerBalance2 = ethers.utils.formatEther(getOwnerBalance2);
    console.log("Teacher balance after deposit: " + getOwnerBalance2);
    //----------------------------------------------------------------------------
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