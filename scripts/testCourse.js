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
        await courseContract.addCourse(100, "course2");
    let getAllCourse = await courseContract.getAllCourses();
    let up = await courseContract.updateDeatailCourse("change title naa", 150);
    let getCourseById = await courseContract.getCourseById(1);
    let selectCourse = await courseContract.chooseCoursesToBuy(1);
        await courseContract.chooseCoursesToBuy(2);
    let totalPrice = await courseContract.calculateTotalPrice();
    console.log("Total price to pay: " + totalPrice.toNumber());

    const addStdBalance = await courseContract.connect(std1).addBalance(1000);
    const getStdBalance = await courseContract.connect(std1).getBalance();
    console.log("student balance: " + getStdBalance.toNumber());
    const payCourse = await courseContract.connect(std1).payCourse(owner.address);
    const payCourseEvent = await payCourse.wait();
    for (const event of payCourseEvent.events) {
      console.log(`Event ${event.event} with args ${event.args}`);
    }

    const getOwnerBalance = await courseContract.getBalance();
    console.log("Teacher balance: " + getOwnerBalance.toNumber());
    const getStdBalance2 = await courseContract.connect(std1).getBalance();
    console.log("student balance: " + getStdBalance2.toNumber());
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