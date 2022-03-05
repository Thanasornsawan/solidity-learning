const main = async () => {
    const [owner, std1] = await hre.ethers.getSigners();
    const courseContractFactory = await hre.ethers.getContractFactory('Courses');
    const courseContract = await courseContractFactory.deploy();
    await courseContract.deployed();

    const examContractFactory = await hre.ethers.getContractFactory('Exam');
    const examContract = await examContractFactory.deploy();
    await examContract.deployed();

    const cartContractFactory = await hre.ethers.getContractFactory('Cart');
    const cartContract = await cartContractFactory.deploy(courseContract.address);
    await cartContract.deployed();

    console.log("Course contract deployed to:", courseContract.address);
    console.log("Cart contract deployed to:", cartContract.address);
    console.log("Exam contract deployed to:", examContract.address);
    console.log("Owner address:", owner.address);
    console.log("Student address:", std1.address);

    let newCourse = await courseContract.addCourse(200, "course1");
        await courseContract.addCourse(300, "course2");
        await courseContract.addCourse(100, "course3");
    let getAllCourse = await courseContract.getAllCourses();
    let up = await courseContract.updateDeatailCourse(1,"change title naa", 150, false);
    let getCourseById = await courseContract.getCourseById(1);

    let selectCourse = await cartContract.connect(std1).chooseCoursesToBuy(0);
        selectCourse = await cartContract.connect(std1).chooseCoursesToBuy(1);
        selectCourse = await cartContract.connect(std1).chooseCoursesToBuy(2);
    //get transaction return value from function chooseCourseToBuy -------
    const trace = await network.provider.send("debug_traceTransaction", [selectCourse.hash])
    const [cart] = ethers.utils.defaultAbiCoder.decode(
        ['uint[]'],
        `0x${trace.returnValue}`
    )
    console.log(`cart: ${cart}`);
    const removeSelectCourse = await cartContract.connect(std1).removeCourseToBuy(1);
    const viewCart = await cartContract.connect(std1).viewCart();
    console.log("Final cart: " + viewCart.toString());

    let totalPrice = await cartContract.calculateTotalPrice();
    console.log("Total price to pay: " + totalPrice.toString());

    const addStdBalance = await cartContract.connect(std1).addBalance(1000);
    const getStdBalance = await cartContract.connect(std1).getBalance();
    console.log("student balance: " + getStdBalance.toString());
    
    const payCourse = await cartContract.connect(std1).payCourse(owner.address);
    //get event from solidity contract (in npx hardhat node not shows event,need to use this solution)
    const payCourseEvent = await payCourse.wait();
    for (const event of payCourseEvent.events) {
        console.log(`Event ${event.event} with args ${event.args}`);
    }
    //------------------------------------------------------------------------------------------------
    const checkStatePaid = await cartContract.connect(std1).getStatusPaid(owner.address);
    console.log(`paid status to address ${owner.address}: `+ checkStatePaid.toString());
    const checkCart = await cartContract.connect(std1).viewCart();
    checkCart.length == 0 ? console.log("cart status: empty"): console.log("cart status: " + checkCart.toString());
    
    const getOwnerBalance = await cartContract.getBalance();
    console.log("Teacher balance: " + getOwnerBalance.toString());
    const getStdBalance2 = await cartContract.connect(std1).getBalance();
    console.log("student balance after payment: " + getStdBalance2.toString());

    const getMyCourse = await cartContract.connect(std1).getMyCourse();
    console.log("My course ID: "+ getMyCourse.toString());

    const getAllStudent = await cartContract.getAllStudents();
    console.log("All Students address: ");
    console.log(getAllStudent);

    //-----------------------------------------------------------------------------

    const depositContract = await cartContract.depositContract({
        from: owner.address,
        value: ethers.utils.parseUnits("50","wei")
    });
    console.log("Total contract balance :" + depositContract.value.toString());

    let getOwnerBalance2 = await cartContract.getBalance();
      getOwnerBalance2 = ethers.utils.parseUnits(getOwnerBalance2.toString(),"wei");
      console.log("Teacher balance after deposit contract: " + getOwnerBalance2);

    //----- test exam contract integrate with cart contract --
    const retakeExam = await cartContract.registerRetakeExam();
    const checkStatusExam = await cartContract.getStatusExam();
    const convert = checkStatusExam.toString();
    if (convert=="1") {console.log("status = Retake")} 
    else if(convert=="0") {console.log("status = Waiting")} else {console.log("status = Complete")}

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