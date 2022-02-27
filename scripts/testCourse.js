const main = async () => {
    const [owner, std1] = await hre.ethers.getSigners();
    const courseContractFactory = await hre.ethers.getContractFactory('Courses');
    const courseContract = await courseContractFactory.deploy();
    await courseContract.deployed();
    console.log("Contract deployed to:", courseContract.address);
    console.log("Owner address:", owner.address);
    console.log("Student address:", std1.address);  

    let newCourse = await courseContract.addCourse(200, "course1");
    let newCourse2 = await courseContract.addCourse(300, "course2");
    let getAllCourse = await courseContract.getAllCourses();
    let up = await courseContract.updateDeatailCourse("change title naa", 150);
    let getCourseById = await courseContract.getCourseById(1);
    console.log(getCourseById);
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