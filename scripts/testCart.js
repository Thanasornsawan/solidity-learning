const main = async () => {
    const [owner, std1] = await hre.ethers.getSigners();
    const courseContractFactory = await hre.ethers.getContractFactory('Courses');
    const courseContract = await courseContractFactory.deploy();
    await courseContract.deployed();
    
    const paymentContractFactory = await hre.ethers.getContractFactory('Payment');
    const paymentContract = await paymentContractFactory.deploy();
    await paymentContract.deployed();

    const cartContractFactory = await hre.ethers.getContractFactory('Cart');
    const cartContract = await cartContractFactory.deploy(courseContract.address, paymentContract.address);
    await cartContract.deployed();

    console.log("Course contract deployed to:", courseContract.address);
    console.log("Payment contract deployed to:", paymentContract.address);
    console.log("Cart contract deployed to:", cartContract.address);

    let newCourse = await courseContract.addCourse(200, "course1");
        await courseContract.addCourse(300, "course2");
        await courseContract.addCourse(100, "course3");
    let getAllCourse = await courseContract.getAllCourses();
    let up = await courseContract.updateDeatailCourse("change title naa", 150);

    let selectCourse = await cartContract.chooseCoursesToBuy(0);
        selectCourse = await cartContract.chooseCoursesToBuy(1);
        selectCourse = await cartContract.chooseCoursesToBuy(2);
    //get transaction return value from function chooseCourseToBuy -------
    const trace = await network.provider.send("debug_traceTransaction", [selectCourse.hash])
    const [cart] = ethers.utils.defaultAbiCoder.decode(
        ['uint[]'],
        `0x${trace.returnValue}`
    )
    console.log(`cart: ${cart}`);
    const removeSelectCourse = await cartContract.removeCourseToBuy(1);
    const viewCart = await cartContract.viewCart();
    console.log("Final cart: " + viewCart.toString());

    let totalPrice = await cartContract.calculateTotalPrice();
    console.log("Total price to pay: " + totalPrice.toString());

    const addStdBalance = await paymentContract.connect(std1).addBalance(1000);
    const getStdBalance = await paymentContract.connect(std1).getBalance();
    console.log("student balance: " + getStdBalance.toString());
    
    const payCourse = await cartContract.connect(std1).payCourse(owner.address);
    //get event from solidity contract (in npx hardhat node not shows event,need to use this solution)
    const payCourseEvent = await payCourse.wait();
    for (const event of payCourseEvent.events) {
        console.log(`Event ${event.event} with args ${event.args}`);
    }
    //------------------------------------------------------------------------------------------------
    const getOwnerBalance = await paymentContract.getBalance();
    console.log("Teacher balance: " + getOwnerBalance.toString());
    const getStdBalance2 = await paymentContract.connect(std1).getBalance();
    console.log("student balance after payment: " + getStdBalance2.toString());

     //test method deposit involve with msg.value --------------------------------
    const depositToOwner = await paymentContract.deposit({
        from: owner.address,
        value: ethers.utils.parseUnits("100","wei")
    });

    let getOwnerBalance2 = await paymentContract.getBalance();
      getOwnerBalance2 = ethers.utils.parseUnits(getOwnerBalance2.toString(),"wei");
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