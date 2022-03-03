const main = async () => {
    const courseContractFactory = await hre.ethers.getContractFactory('Courses');
    const courseContract = await courseContractFactory.deploy();
    await courseContract.deployed();

    const cartContractFactory = await hre.ethers.getContractFactory('Cart');
    const cartContract = await cartContractFactory.deploy(courseContract.address);
    await cartContract.deployed();

    const examContractFactory = await hre.ethers.getContractFactory('Exam');
    const examContract = await examContractFactory.deploy();
    await examContract.deployed();

    console.log("Course contract deployed to:", courseContract.address);
    console.log("Cart contract deployed to:", cartContract.address);
    console.log("Exam contract deployed to:", examContract.address);
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