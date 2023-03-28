import {ethers} from "hardhat";

async function main() {
    const [deployer] = await ethers.getSigners();

    const lockFactory = await ethers.getContractFactory("Lock");
    // const lock = await lockFactory.deploy(1000, { value: ethers.utils.parseEther("0.001") });
    const lock = await lockFactory.deploy("0x0000000");
    console.log(`Lock deployed to ${lock.address}`);


    // const currentTimestampInSeconds = Math.round(Date.now() / 1000);
    // const unlockTime = currentTimestampInSeconds + 60;
    //
    // const lockedAmount = ethers.utils.parseEther("0.001");
    //
    // const Lock = await ethers.getContractFactory("Lock");
    // const lock = await Lock.deploy(unlockTime, { value: lockedAmount });
    //
    // await lock.deployed();
    //
    // console.log(
    //   `Lock with ${ethers.utils.formatEther(lockedAmount)}ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`
    // );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
