var chai = require("chai");
var chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);
var assert = chai.assert;
const { ethers } = require("hardhat");

    describe("MyToken upgrade version", function () {
    
        before('get factories',async function () {
            [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
            this.MyTokenProxy = await hre.ethers.getContractFactory('MyTokenProxy');
            this.MyTokenImplementation = await hre.ethers.getContractFactory('MyTokenImplementation');
     
        });
  
        it("go to V2", async function () {
            const proxy = await hre.upgrades.deployProxy(this.MyTokenProxy, [12, 12], {kind:'uups'});
            await proxy.deployed();
            console.log("proxy address: ", proxy.address);
            console.log("Balance of owner token 'PLY': ", (await proxy.balanceOf(owner.address)).toString());

            assert(await proxy.name()==="MyToken");
            assert(await proxy.symbol()==="PLY");

            const tokenV2 = await hre.upgrades.upgradeProxy(proxy, this.MyTokenImplementation);
            assert(await tokenV2.version()==="version 3!");
            console.log("Area: ", (await tokenV2.area()).toString());
        });

    });