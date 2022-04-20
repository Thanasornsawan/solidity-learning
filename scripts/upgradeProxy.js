const PROXY = "0x61509bda0A25247a3AFa430DC8d25601038fDecb";
const main = async () => {
    const MyTokenImplementation = await hre.ethers.getContractFactory('MyTokenImplementation');
    console.log("Upgrading Proxy...");
    const tokenV2 = await hre.upgrades.upgradeProxy(PROXY, MyTokenImplementation);
    console.log("proxy upgrade successfully");

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