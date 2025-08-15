const { loadFixture } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Factory", function () {
    const FEE = ethers.parseUnits("0.01", 18); // BigInt in Ethers v6

    async function deployFactoryFixture() {
        const [deployer,creator]=await ethers.getSigners();
        const Factory = await ethers.getContractFactory("Factory");
        const factory = await Factory.deploy(FEE);
        const transaction=await factory.connect(creator).create("TestToken", "TTK",{value:FEE});
        await transaction.wait();
        return { factory,deployer,creator};
    }

    describe("Deployment", function () {
        it("Should set the right fee", async function () {
            const { factory } = await loadFixture(deployFactoryFixture);
            expect(await factory.fee()).to.equal(FEE);
        });
         it("Should set the owner", async function () {
            const { factory,deployer } = await loadFixture(deployFactoryFixture);
            expect(await factory.owner()).to.equal(deployer.address);
        });
    });
    describe("creating",function(){
        it("should set the owner",async function(){

        } 
            
        )

    })
});
