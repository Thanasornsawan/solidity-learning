const main = async () => {
    const MyTokenProxy = await hre.ethers.getContractFactory('MyTokenProxy');
    console.log("Deploying Proxy...");
    const proxy = await hre.upgrades.deployProxy(MyTokenProxy, [12, 12], {kind:'uups'});
    await proxy.deployed();
    console.log("proxy address: ", proxy.address);

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